import '../../../../core/utils/result.dart';
import '../../data/params/broadcast_notification_params.dart';

abstract class NotificationRepository {
  /// Broadcasts a push notification to the target audience. Admin-only on the
  /// backend. Returns success when the broadcast was accepted for delivery.
  Future<Result<void>> broadcast(BroadcastNotificationParams params);
}
