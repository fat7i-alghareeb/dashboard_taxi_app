import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_live_map_stat_tile_widget.dart';

class DashboardLiveMapStatsWidget extends StatelessWidget {
  const DashboardLiveMapStatsWidget({super.key, required this.drivers});

  final List<DashboardDriverLocationEntity> drivers;

  @override
  Widget build(BuildContext context) {
    final mapped = drivers.where((driver) => driver.hasLocation).length;
    final idle = drivers.where((driver) => driver.isOnline).length;
    final busy = drivers.where((driver) => driver.isBusy).length;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.surface.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
        boxShadow: context.shadows.grey,
      ),
      child: Padding(
        padding: REdgeInsets.all(AppSpacing.lg),
        child: Row(
          children: [
            Expanded(
              child: DashboardLiveMapStatTileWidget(
                label: AppStrings.dashboardMappedDrivers,
                value: mapped.toString(),
                icon: FontAwesomeIcons.locationDot,
                color: context.primary,
              ),
            ),
            Expanded(
              child: DashboardLiveMapStatTileWidget(
                label: AppStrings.dashboardIdleDrivers,
                value: idle.toString(),
                icon: FontAwesomeIcons.carSide,
                color: AppColors.success,
              ),
            ),
            Expanded(
              child: DashboardLiveMapStatTileWidget(
                label: AppStrings.dashboardBusyDrivers,
                value: busy.toString(),
                icon: FontAwesomeIcons.route,
                color: AppColors.error,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: AppDurations.normal).slideY(begin: 0.08);
  }
}
