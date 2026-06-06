import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../params/broadcast_notification_params.dart';

@lazySingleton
class NotificationRemoteDataSource {
  const NotificationRemoteDataSource(this._dio);

  final Dio _dio;

  Future<void> broadcast(BroadcastNotificationParams params) {
    return rethrowAsAppException(() async {
      printY(
        '[NotificationRemoteDataSource] broadcast -> '
        '${ApiEndpoints.broadcastNotification} title="${params.title}"',
      );
      await _dio.post<dynamic>(
        ApiEndpoints.broadcastNotification,
        data: params.toJson(),
      );
      printG('[NotificationRemoteDataSource] broadcast success');
    });
  }
}
