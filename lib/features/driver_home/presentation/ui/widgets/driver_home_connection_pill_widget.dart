import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/core/services/realtime/realtime_connection_state.dart';

class DriverHomeConnectionPillWidget extends StatelessWidget {
  const DriverHomeConnectionPillWidget({
    super.key,
    required this.connectionState,
  });

  final RealtimeConnectionState connectionState;

  ({Color color, String label}) _statusFor() {
    switch (connectionState) {
      case RealtimeConnectionState.connected:
        return (color: AppColors.success, label: AppStrings.driverConnected);
      case RealtimeConnectionState.connecting:
      case RealtimeConnectionState.reconnecting:
        return (
          color: AppColors.warning,
          label: AppStrings.driverReconnecting,
        );
      case RealtimeConnectionState.disconnected:
        return (color: AppColors.error, label: AppStrings.driverDisconnected);
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = _statusFor();

    return SafeArea(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.surface,
          borderRadius: BorderRadius.circular(AppRadii.xl.r),
          border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
        ),
        child: Padding(
          padding: REdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8.r,
                height: 8.r,
                decoration: BoxDecoration(
                  color: status.color,
                  shape: BoxShape.circle,
                ),
              ),
              AppSpacing.sm.horizontalSpace,
              Text(
                status.label,
                style: AppTextStyles.s12w500.copyWith(
                  color: context.onSurface,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
