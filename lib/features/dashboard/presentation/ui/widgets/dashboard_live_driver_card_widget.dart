import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';

class DashboardLiveDriverCardWidget extends StatelessWidget {
  const DashboardLiveDriverCardWidget({super.key, required this.driver});

  final DashboardDriverLocationEntity driver;

  @override
  Widget build(BuildContext context) {
    final name = driver.name.isEmpty
        ? AppStrings.dashboardUnknownDriver
        : driver.name;
    final vehicleType =
        driver.vehicleTypeName == null || driver.vehicleTypeName!.isEmpty
        ? AppStrings.dashboardNoVehicleTypeAssigned
        : driver.vehicleTypeName!;
    final lastSeen = driver.locationUpdatedAt == null
        ? AppStrings.tripUnknownAddress
        : AppStrings.dashboardLastSeen.replaceAll(
            '{time}',
            driver.locationUpdatedAt!.toSmartDateTime(),
          );
    final color = driver.isBusy ? AppColors.error : AppColors.success;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.surface.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: color.withValues(alpha: 0.18)),
        boxShadow: context.shadows.grey,
      ),
      child: Padding(
        padding: REdgeInsets.all(AppSpacing.lg),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppRadii.sm.r),
              ),
              child: Padding(
                padding: REdgeInsets.all(AppSpacing.md),
                child: FaIcon(FontAwesomeIcons.taxi, size: 18.r, color: color),
              ),
            ),
            AppSpacing.md.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.s16w600.copyWith(
                      color: context.onSurface,
                    ),
                  ),
                  AppSpacing.xs.verticalSpace,
                  Text(
                    vehicleType,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.s12w400.copyWith(
                      color: context.onSurface.withValues(alpha: 0.62),
                    ),
                  ),
                  AppSpacing.xs.verticalSpace,
                  Text(
                    lastSeen,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.s12w400.copyWith(
                      color: context.onSurface.withValues(alpha: 0.62),
                    ),
                  ),
                ],
              ),
            ),
            AppSpacing.md.horizontalSpace,
            Text(
              driver.status,
              style: AppTextStyles.s12w400.copyWith(color: color),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: AppDurations.normal).slideY(begin: 0.08);
  }
}
