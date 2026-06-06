import 'package:injectable/injectable.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/utils/result.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_remote_datasource.dart';
import '../params/broadcast_notification_params.dart';

@LazySingleton(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  const NotificationRepositoryImpl(this._remote);

  final NotificationRemoteDataSource _remote;

  @override
  Future<Result<void>> broadcast(BroadcastNotificationParams params) {
    return runAsResult(() async {
      printC(
        '[NotificationRepository] broadcast start title="${params.title}"',
      );
      await _remote.broadcast(params);
      printG('[NotificationRepository] broadcast success');
    });
  }
}
