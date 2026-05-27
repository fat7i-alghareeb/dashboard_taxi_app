import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_status_chip_widget.dart';

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

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
      ),
      child: Padding(
        padding: REdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  height: 40.r,
                  width: 40.r,
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
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.s14w600.copyWith(
                          color: context.onSurface,
                        ),
                      ),
                      AppSpacing.xs.verticalSpace,
                      Text(
                        vehicleType,
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
                DashboardStatusChipWidget(
                  label: driver.status,
                  tone: dashboardToneFromDriverStatus(driver.status),
                  dense: true,
                ),
              ],
            ),
            AppSpacing.sm.verticalSpace,
            Text(
              lastSeen,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.s12w400.copyWith(
                color: context.onSurface.withValues(alpha: 0.45),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 280.ms).slideY(begin: 0.05, end: 0);
  }
}
