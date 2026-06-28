part of 'chat_bloc.dart';

@freezed
class ChatEvent with _$ChatEvent {
  /// Loads history and subscribes to live messages for [tripId]. Idempotent.
  const factory ChatEvent.opened(String tripId) = _Opened;

  /// The chat sheet became visible — clears the unread badge.
  const factory ChatEvent.viewOpened() = _ViewOpened;

  /// The chat sheet was dismissed.
  const factory ChatEvent.viewClosed() = _ViewClosed;

  /// Silently re-fetch history and merge it in. Fired after a (re)connect or
  /// when the sheet is (re)opened so messages that arrived while the socket was
  /// down — and were never pushed — are recovered without a full app restart.
  const factory ChatEvent.syncRequested() = _SyncRequested;

  const factory ChatEvent.sendText(String text) = _SendText;
  const factory ChatEvent.sendPhoto(String path) = _SendPhoto;

  const factory ChatEvent.messageReceived(ChatMessageEntity message) =
      _MessageReceived;
  const factory ChatEvent.chatClosedReceived() = _ChatClosedReceived;
}
