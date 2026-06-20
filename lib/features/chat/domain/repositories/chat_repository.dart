import '../../../../core/utils/result.dart';
import '../entities/chat_message_entity.dart';

abstract class ChatRepository {
  Future<Result<List<ChatMessageEntity>>> getMessages(String tripId);

  Future<Result<ChatMessageEntity>> sendMessage(
    String tripId, {
    String? text,
    String? photoPath,
  });
}
