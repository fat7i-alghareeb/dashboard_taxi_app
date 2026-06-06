import 'package:injectable/injectable.dart';

import '../../../../core/utils/result.dart';
import '../../../../utils/helpers/colored_print.dart';
import '../../data/params/broadcast_notification_params.dart';
import '../repositories/notification_repository.dart';

@lazySingleton
class NotificationFacade {
  const NotificationFacade(this._repository);

  final NotificationRepository _repository;

  Future<Result<void>> broadcast(BroadcastNotificationParams params) {
    printC('[NotificationFacade] broadcast title="${params.title}"');
    return _repository.broadcast(params);
  }
}
