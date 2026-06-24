import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

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
    on<_SendText>(_onSendText);
    on<_SendPhoto>(_onSendPhoto);
    on<_MessageReceived>(_onMessageReceived);
    on<_ChatClosedReceived>(_onChatClosedReceived);
  }

  final ChatRepository _repository;
  final RealtimeService _realtime;
  final AuthManager _authManager;

  StreamSubscription<RealtimeEvent>? _realtimeSub;
  String? _tripId;

  String? get _myUserId => _authManager.currentUser?.id;

  Future<void> _onOpened(_Opened event, Emitter<ChatState> emit) async {
    _tripId = event.tripId;
    printC('[ChatBloc] opened trip=${event.tripId}');

    await _realtimeSub?.cancel();
    _realtimeSub = _realtime.events
        .where((e) => e.tripId == event.tripId)
        .listen(_onRealtimeEvent);

    emit(state.copyWith(loadStatus: const BlocStatus.loading()));
    final result = await _repository.getMessages(event.tripId);
    result.when(
      success: (messages) {
        final sorted = [...messages]
          ..sort((a, b) => a.sentAtUtc.compareTo(b.sentAtUtc));
        emit(
          state.copyWith(
            messages: sorted,
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

  @override
  Future<void> close() async {
    await _realtimeSub?.cancel();
    return super.close();
  }
}
