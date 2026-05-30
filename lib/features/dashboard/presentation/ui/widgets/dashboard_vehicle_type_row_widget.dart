import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';

class DashboardVehicleTypeRowWidget extends StatelessWidget {
  const DashboardVehicleTypeRowWidget({super.key, required this.vehicleType});

  final DashboardVehicleTypeEntity vehicleType;

  @override
  Widget build(BuildContext context) {
    final rate = AppStrings.dashboardRatePerKm.trParams({
      'value': vehicleType.ratePerKm.toStringAsFixed(2),
    });
    final capacity = AppStrings.dashboardCapacityValue.trParams({
      'value': vehicleType.capacity,
    });
    final minFare = AppStrings.dashboardMinFareValue.trParams({
      'value': vehicleType.minFare.toStringAsFixed(2),
    });

    return Padding(
      padding: REdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Container(
            height: 36.r,
            width: 36.r,
            decoration: BoxDecoration(
              color: context.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(AppRadii.sm.r),
            ),
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.taxi,
                size: 14.r,
                color: context.primary,
              ),
            ),
          ),
          AppSpacing.md.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vehicleType.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.s14w600.copyWith(
                    color: context.onSurface,
                  ),
                ),
                AppSpacing.xs.verticalSpace,
                Text(
                  '$capacity · $minFare',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.s12w400.copyWith(
                    color: context.onSurface.withValues(alpha: 0.60),
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.sm.horizontalSpace,
          Text(
            rate,
            style: AppTextStyles.s14w600.copyWith(color: context.primary),
          ),
        ],
      ),
    );
  }
}
