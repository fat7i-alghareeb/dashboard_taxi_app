import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/trip/domain/entities/trip_entity.dart';

class TripStatusChipWidget extends StatelessWidget {
  const TripStatusChipWidget({super.key, required this.status});

  final TripStatus status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      TripStatus.driverAssigned => context.primary,
      TripStatus.driverEnRoute => AppColors.warning,
      TripStatus.driverArrived => AppColors.success,
      TripStatus.inProgress => AppColors.success,
      TripStatus.completed => AppColors.success,
      TripStatus.cancelled ||
      TripStatus.paymentFailed ||
      TripStatus.refunded => AppColors.error,
      _ => context.onSurface.withValues(alpha: 0.6),
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: color.withValues(alpha: 0.42)),
      ),
      child: Padding(
        padding: REdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        child: Text(
          _label,
          style: AppTextStyles.s14w400.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  String get _label {
    return switch (status) {
      TripStatus.driverAssigned => AppStrings.tripStatusDriverAssigned,
      TripStatus.driverEnRoute => AppStrings.tripStatusDriverEnRoute,
      TripStatus.driverArrived => AppStrings.tripStatusDriverArrived,
      TripStatus.inProgress => AppStrings.tripStatusInProgress,
      TripStatus.completed => AppStrings.tripStatusCompleted,
      TripStatus.cancelled => AppStrings.tripStatusCancelled,
      _ => AppStrings.tripStatus,
    };
  }
}
