import '../../domain/entities/chat_message_entity.dart';
import '../models/chat_message_model.dart';

extension ChatMessageModelMapper on ChatMessageModel {
  ChatMessageEntity get toEntity => ChatMessageEntity(
    id: id,
    tripId: tripId,
    senderId: senderId,
    senderRole: senderRole,
    content: content,
    photoUrl: photoUrl,
    sentAtUtc: sentAtUtc,
  );
}
