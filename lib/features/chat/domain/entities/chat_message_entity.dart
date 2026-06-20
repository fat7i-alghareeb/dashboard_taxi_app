import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message_entity.freezed.dart';

/// A single in-trip chat message. [senderRole] is one of
/// `Passenger` / `Driver` / `Admin`. Exactly one of [content] / [photoUrl]
/// (or both) is non-null.
@freezed
abstract class ChatMessageEntity with _$ChatMessageEntity {
  const factory ChatMessageEntity({
    required String id,
    required String tripId,
    required String senderId,
    required String senderRole,
    String? content,
    String? photoUrl,
    required DateTime sentAtUtc,
  }) = _ChatMessageEntity;
}
