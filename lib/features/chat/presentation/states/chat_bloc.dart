import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/services/realtime/realtime_connection_state.dart';
import '../../../../core/services/realtime/realtime_event.dart';
import '../../../../core/services/realtime/realtime_service.dart';
import '../../../../core/services/session/auth_manager.dart';
import '../../../../core/utils/bloc_status.dart';
import '../../../../core/utils/result.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/repositories/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';
part 'chat_bloc.freezed.dart';

/// Drives the per-trip chat surface: loads history, streams live messages over
/// SignalR, sends text/photos, and locks when the trip ends. A fresh instance
/// is created per active trip (see [ChatEvent.opened]).
@injectable
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(this._repository, this._realtime, this._authManager)
    : super(const ChatState()) {
    on<_Opened>(_onOpened);
    on<_ViewOpened>(_onViewOpened);
    on<_ViewClosed>(_onViewClosed);
    on<_SyncRequested>(_onSyncRequested);
    on<_SendText>(_onSendText);
    on<_SendPhoto>(_onSendPhoto);
    on<_MessageReceived>(_onMessageReceived);
    on<_ChatClosedReceived>(_onChatClosedReceived);
  }

  final ChatRepository _repository;
  final RealtimeService _realtime;
  final AuthManager _authManager;

  StreamSubscription<RealtimeEvent>? _realtimeSub;
  StreamSubscription<RealtimeConnectionState>? _connSub;
  RealtimeConnectionState? _lastConnState;
  String? _tripId;

  String? get _myUserId => _authManager.currentUser?.id;

  Future<void> _onOpened(_Opened event, Emitter<ChatState> emit) async {
    _tripId = event.tripId;
    printC('[ChatBloc] opened trip=${event.tripId}');

    await _realtimeSub?.cancel();
    _realtimeSub = _realtime.events
        .where((e) => e.tripId == event.tripId)
        .listen(_onRealtimeEvent);

    // Belt-and-suspenders: also subscribe to the per-trip server group. The
    // server already pushes to our per-user group, but this hardens delivery.
    // Queues internally until the socket is connected and re-joins on reconnect.
    unawaited(_realtime.joinTripGroup(event.tripId));

    // Recover messages that arrived while the socket was down: SignalR does not
    // redeliver them, so re-fetch history whenever the connection (re)enters the
    // connected state. Without this the only recovery is a full app restart.
    _lastConnState = _realtime.currentConnectionState;
    await _connSub?.cancel();
    _connSub = _realtime.connectionState.listen((next) {
      final wasConnected = _lastConnState == RealtimeConnectionState.connected;
      _lastConnState = next;
      if (next == RealtimeConnectionState.connected && !wasConnected) {
        if (!isClosed) add(const ChatEvent.syncRequested());
      }
    });

    emit(state.copyWith(loadStatus: const BlocStatus.loading()));
    final result = await _repository.getMessages(event.tripId);
    result.when(
      success: (messages) {
        emit(
          state.copyWith(
            messages: _mergeMessages(state.messages, messages),
            loadStatus: const BlocStatus.success(null),
          ),
        );
      },
      failure: (message) {
        printY('[ChatBloc] load failed: $message');
        emit(state.copyWith(loadStatus: BlocStatus.failure(message)));
      },
    );
  }

  /// Silent history re-sync — re-fetches and merges without flipping the
  /// full-screen loader, so a (re)connect or sheet re-open recovers any pushes
  /// missed while the socket was down. De-dup keeps already-shown messages.
  Future<void> _onSyncRequested(
    _SyncRequested event,
    Emitter<ChatState> emit,
  ) async {
    final tripId = _tripId;
    if (tripId == null) return;
    printC('[ChatBloc] sync trip=$tripId');
    final result = await _repository.getMessages(tripId);
    result.when(
      success: (messages) {
        final merged = _mergeMessages(state.messages, messages);
        if (merged.length != state.messages.length) {
          emit(state.copyWith(messages: merged));
        }
      },
      failure: (message) => printY('[ChatBloc] sync failed: $message'),
    );
  }

  void _onRealtimeEvent(RealtimeEvent event) {
    if (isClosed) return;
    if (event is RealtimeTripMessageReceived) {
      add(
        ChatEvent.messageReceived(
          ChatMessageEntity(
            id: event.messageId,
            tripId: event.tripId,
            senderId: event.senderId,
            senderRole: event.senderRole,
            content: event.content,
            photoUrl: event.photoUrl,
            sentAtUtc:
                DateTime.tryParse(event.sentAtUtc)?.toUtc() ??
                DateTime.now().toUtc(),
          ),
        ),
      );
    } else if (event is RealtimeChatClosed) {
      add(const ChatEvent.chatClosedReceived());
    }
  }

  void _onViewOpened(_ViewOpened event, Emitter<ChatState> emit) {
    emit(state.copyWith(isViewing: true, unreadCount: 0));
    // Re-open of the sheet reuses this bloc (no fresh _onOpened), so pull any
    // messages that were missed while it was closed / the socket was down.
    if (_tripId != null) add(const ChatEvent.syncRequested());
  }

  void _onViewClosed(_ViewClosed event, Emitter<ChatState> emit) {
    emit(state.copyWith(isViewing: false));
  }

  Future<void> _onSendText(_SendText event, Emitter<ChatState> emit) async {
    final tripId = _tripId;
    final text = event.text.trim();
    if (tripId == null || text.isEmpty) return;

    emit(state.copyWith(sendStatus: const BlocStatus.loading()));
    final result = await _repository.sendMessage(tripId, text: text);
    _emitSendResult(result, emit);
  }

  Future<void> _onSendPhoto(_SendPhoto event, Emitter<ChatState> emit) async {
    final tripId = _tripId;
    if (tripId == null) return;

    emit(state.copyWith(sendStatus: const BlocStatus.loading()));
    final result = await _repository.sendMessage(tripId, photoPath: event.path);
    _emitSendResult(result, emit);
  }

  void _emitSendResult(
    Result<ChatMessageEntity> result,
    Emitter<ChatState> emit,
  ) {
    result.when(
      success: (message) {
        emit(
          state.copyWith(
            messages: _mergeMessage(state.messages, message),
            sendStatus: const BlocStatus.success(null),
          ),
        );
      },
      failure: (msg) {
        printY('[ChatBloc] send failed: $msg');
        emit(state.copyWith(sendStatus: BlocStatus.failure(msg)));
      },
    );
  }

  void _onMessageReceived(_MessageReceived event, Emitter<ChatState> emit) {
    final isMine = event.message.senderId == _myUserId;
    final merged = _mergeMessage(state.messages, event.message);
    final isNew = merged.length != state.messages.length;
    final shouldCount = isNew && !isMine && !state.isViewing;
    emit(
      state.copyWith(
        messages: merged,
        unreadCount: shouldCount ? state.unreadCount + 1 : state.unreadCount,
      ),
    );
  }

  void _onChatClosedReceived(
    _ChatClosedReceived event,
    Emitter<ChatState> emit,
  ) {
    printC('[ChatBloc] chat closed trip=$_tripId');
    emit(state.copyWith(isClosed: true));
  }

  /// Appends [message] keeping the list ordered by time and de-duplicated by id
  /// (the server echoes the sender's own message back over SignalR).
  List<ChatMessageEntity> _mergeMessage(
    List<ChatMessageEntity> current,
    ChatMessageEntity message,
  ) {
    if (current.any((m) => m.id == message.id)) return current;
    final next = [...current, message]
      ..sort((a, b) => a.sentAtUtc.compareTo(b.sentAtUtc));
    return next;
  }

  /// Merges a batch (history re-fetch) into [current], keeping it ordered by
  /// time and de-duplicated by id. Returns [current] unchanged when nothing new.
  List<ChatMessageEntity> _mergeMessages(
    List<ChatMessageEntity> current,
    List<ChatMessageEntity> incoming,
  ) {
    final byId = {for (final m in current) m.id: m};
    var added = false;
    for (final m in incoming) {
      if (byId.containsKey(m.id)) continue;
      byId[m.id] = m;
      added = true;
    }
    if (!added) return current;
    return byId.values.toList()
      ..sort((a, b) => a.sentAtUtc.compareTo(b.sentAtUtc));
  }

  @override
  Future<void> close() async {
    await _realtimeSub?.cancel();
    await _connSub?.cancel();
    return super.close();
  }
}
