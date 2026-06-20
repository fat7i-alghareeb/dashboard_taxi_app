part of 'chat_bloc.dart';

@freezed
abstract class ChatState with _$ChatState {
  const factory ChatState({
    @Default([]) List<ChatMessageEntity> messages,
    @Default(BlocStatus<void>.initial()) BlocStatus<void> loadStatus,
    @Default(BlocStatus<void>.initial()) BlocStatus<void> sendStatus,

    /// True once the trip ended — the message input is locked.
    @Default(false) bool isClosed,

    /// Whether the chat sheet is currently on screen (drives unread counting).
    @Default(false) bool isViewing,

    /// Messages received from other participants while the sheet was closed.
    @Default(0) int unreadCount,
  }) = _ChatState;
}
