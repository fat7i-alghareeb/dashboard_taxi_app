import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../models/chat_message_model.dart';

@lazySingleton
class ChatRemoteDataSource {
  const ChatRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<ChatMessageModel>> getMessages(String tripId) {
    return rethrowAsAppException(() async {
      printY('[ChatRemoteDataSource] getMessages trip=$tripId');
      final res = await _dio.get<dynamic>(ApiEndpoints.tripMessages(tripId));
      final data = res.data as List<dynamic>? ?? const [];
      return data
          .map((e) => ChatMessageModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  Future<ChatMessageModel> sendMessage(
    String tripId, {
    String? text,
    String? photoPath,
  }) {
    return rethrowAsAppException(() async {
      printY(
        '[ChatRemoteDataSource] sendMessage trip=$tripId hasText=${text != null} hasPhoto=${photoPath != null}',
      );

      final formData = FormData();
      if (text != null && text.trim().isNotEmpty) {
        formData.fields.add(MapEntry('Content', text.trim()));
      }
      if (photoPath != null) {
        formData.files.add(
          MapEntry('Photo', await MultipartFile.fromFile(photoPath)),
        );
      }

      final res = await _dio.post<dynamic>(
        ApiEndpoints.tripMessages(tripId),
        data: formData,
      );
      return ChatMessageModel.fromJson(res.data as Map<String, dynamic>);
    });
  }
}
