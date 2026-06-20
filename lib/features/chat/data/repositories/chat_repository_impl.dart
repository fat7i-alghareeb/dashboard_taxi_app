import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/utils/result.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_datasource.dart';
import '../mappers/chat_message_mapper.dart';

@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  const ChatRepositoryImpl(this._remote);

  final ChatRemoteDataSource _remote;

  @override
  Future<Result<List<ChatMessageEntity>>> getMessages(String tripId) {
    return runAsResult(() async {
      printM('[ChatRepository] getMessages trip=$tripId');
      final models = await _remote.getMessages(tripId);
      printG('[ChatRepository] getMessages count=${models.length}');
      return models.map((m) => m.toEntity).toList();
    });
  }

  @override
  Future<Result<ChatMessageEntity>> sendMessage(
    String tripId, {
    String? text,
    String? photoPath,
  }) {
    return runAsResult(() async {
      printM('[ChatRepository] sendMessage trip=$tripId');
      final model = await _remote.sendMessage(
        tripId,
        text: text,
        photoPath: photoPath,
      );
      printG('[ChatRepository] sendMessage success id=${model.id}');
      return model.toEntity;
    });
  }
}
