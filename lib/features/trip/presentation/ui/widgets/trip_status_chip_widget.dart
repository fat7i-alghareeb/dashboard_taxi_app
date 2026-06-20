import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/trip/domain/entities/trip_entity.dart';

class TripStatusChipWidget extends StatelessWidget {
  const TripStatusChipWidget({super.key, required this.status});

  final TripStatus status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      TripStatus.accepted => context.primary,
      TripStatus.enRoute => AppColors.warning,
      TripStatus.arrived ||
      TripStatus.inProgress ||
      TripStatus.completed => AppColors.success,
      TripStatus.cancelled ||
      TripStatus.paymentFailed ||
      TripStatus.refunded => AppColors.error,
      _ => context.onSurface.withValues(alpha: 0.6),
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppRadii.sm.r),
      ),
      child: Padding(
        padding: REdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        child: Text(
          _label,
          style: AppTextStyles.s12w500.copyWith(color: color),
        ),
      ),
    );
  }

  String get _label {
    return switch (status) {
      TripStatus.awaitingAdminAcceptance => AppStrings.tripStatusPendingDriver,
      TripStatus.accepted => AppStrings.tripStatusDriverAssigned,
      TripStatus.enRoute => AppStrings.tripStatusDriverEnRoute,
      TripStatus.arrived => AppStrings.tripStatusDriverArrived,
      TripStatus.inProgress => AppStrings.tripStatusInProgress,
      TripStatus.completed => AppStrings.tripStatusCompleted,
      TripStatus.cancelled => AppStrings.tripStatusCancelled,
      _ => AppStrings.tripStatus,
    };
  }
}
