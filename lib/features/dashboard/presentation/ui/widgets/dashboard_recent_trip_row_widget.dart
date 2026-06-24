import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_status_chip_widget.dart';

class DashboardRecentTripRowWidget extends StatelessWidget {
  const DashboardRecentTripRowWidget({super.key, required this.trip});

  final DashboardTripEntity trip;

  @override
  Widget build(BuildContext context) {
    final pickup = trip.pickupLabel ?? AppStrings.tripUnknownAddress;
    final dropoff = trip.dropoffLabel ?? AppStrings.tripUnknownAddress;

    return Padding(
      padding: REdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: REdgeInsets.only(top: AppSpacing.xs),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8.r,
                  height: 8.r,
                  decoration: BoxDecoration(
                    color: context.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: 1.5.r,
                  height: 16.h,
                  color: context.onSurface.withValues(alpha: 0.18),
                ),
                Container(
                  width: 8.r,
                  height: 8.r,
                  decoration: BoxDecoration(
                    color: context.onSurface.withValues(alpha: 0.45),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.md.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        trip.referenceCode,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.s14w600.copyWith(
                          color: context.onSurface,
                        ),
                      ),
                    ),
                    AppSpacing.sm.horizontalSpace,
                    Text(
                      trip.fareLabel,
                      style: AppTextStyles.s14w600.copyWith(
                        color: context.onSurface,
                      ),
                    ),
                  ],
                ),
                AppSpacing.xs.verticalSpace,
                Text(
                  pickup,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.s12w400.copyWith(
                    color: context.onSurface.withValues(alpha: 0.70),
                  ),
                ),
                AppSpacing.xs.verticalSpace,
                Text(
                  dropoff,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.s12w400.copyWith(
                    color: context.onSurface.withValues(alpha: 0.55),
                  ),
                ),
                AppSpacing.sm.verticalSpace,
                Row(
                  children: [
                    DashboardStatusChipWidget(
                      label: dashboardTripStatusLabel(trip.status),
                      tone: dashboardToneFromTripStatus(trip.status),
                      dense: true,
                    ),
                    AppSpacing.sm.horizontalSpace,
                    if (trip.createdAt != null)
                      Text(
                        trip.createdAt!.toSmartDateTime(),
                        style: AppTextStyles.s12w400.copyWith(
                          color: context.onSurface.withValues(alpha: 0.45),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
