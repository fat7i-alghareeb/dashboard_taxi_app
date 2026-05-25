import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';

class DashboardVehicleTypeRowWidget extends StatelessWidget {
  const DashboardVehicleTypeRowWidget({super.key, required this.vehicleType});

  final DashboardVehicleTypeEntity vehicleType;

  @override
  Widget build(BuildContext context) {
    final rate = AppStrings.dashboardRatePerKm.replaceAll(
      '{value}',
      vehicleType.ratePerKm.toStringAsFixed(2),
    );
    final capacity = AppStrings.dashboardCapacityValue.replaceAll(
      '{value}',
      vehicleType.capacity.toString(),
    );
    final minFare = AppStrings.dashboardMinFareValue.replaceAll(
      '{value}',
      vehicleType.minFare.toStringAsFixed(2),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(AppRadii.sm.r),
        border: Border.all(color: context.primary.withValues(alpha: 0.12)),
      ),
      child: Padding(
        padding: REdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            FaIcon(FontAwesomeIcons.taxi, size: 16.r, color: context.primary),
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
                    capacity,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.s12w400.copyWith(
                      color: context.onSurface.withValues(alpha: 0.62),
                    ),
                  ),
                ],
              ),
            ),
            AppSpacing.sm.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  rate,
                  style: AppTextStyles.s14w600.copyWith(
                    color: context.onSurface,
                  ),
                ),
                AppSpacing.xs.verticalSpace,
                Text(
                  minFare,
                  style: AppTextStyles.s12w400.copyWith(
                    color: context.onSurface.withValues(alpha: 0.62),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
