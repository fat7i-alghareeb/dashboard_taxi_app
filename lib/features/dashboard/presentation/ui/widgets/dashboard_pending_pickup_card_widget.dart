import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_assign_driver_sheet.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_status_chip_widget.dart';

class DashboardPendingPickupCardWidget extends StatelessWidget {
  const DashboardPendingPickupCardWidget({
    super.key,
    required this.trip,
    required this.drivers,
    required this.liveDrivers,
  });

  final DashboardTripEntity trip;
  final List<DashboardDriverEntity> drivers;
  final List<DashboardDriverLocationEntity> liveDrivers;

  @override
  Widget build(BuildContext context) {
    final pickup = trip.pickupLabel == null || trip.pickupLabel!.isEmpty
        ? AppStrings.dashboardNoPickupLocation
        : trip.pickupLabel!;
    final distances = _driverDistancesById();

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
                    color: AppColors.warning.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(AppRadii.sm.r),
                  ),
                  child: Center(
                    child: FaIcon(
                      FontAwesomeIcons.locationDot,
                      size: 14.r,
                      color: AppColors.warning,
                    ),
                  ),
                ),
                AppSpacing.md.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trip.referenceCode,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.s14w600.copyWith(
                          color: context.onSurface,
                        ),
                      ),
                      AppSpacing.xs.verticalSpace,
                      Row(
                        children: [
                          Text(
                            trip.fareLabel,
                            style: AppTextStyles.s12w500.copyWith(
                              color: context.onSurface.withValues(alpha: 0.78),
                            ),
                          ),
                          AppSpacing.sm.horizontalSpace,
                          DashboardStatusChipWidget(
                            label: trip.status,
                            tone: DashboardStatusTone.warning,
                            dense: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            AppSpacing.md.verticalSpace,
            Text(
              pickup,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.s12w400.copyWith(
                color: context.onSurface.withValues(alpha: 0.60),
              ),
            ),
            AppSpacing.lg.verticalSpace,
            AppButton.primary(
              onTap: () => DashboardAssignDriverSheet.show(
                context,
                trip: trip,
                drivers: drivers,
                driverDistances: distances,
              ),
              layout: const AppButtonLayout(height: 40),
              child: AppButtonChild.label(AppStrings.dashboardAssignDriver),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 280.ms).slideY(begin: 0.05, end: 0);
  }

  Map<String, double> _driverDistancesById() {
    if (!trip.hasPickupLocation) return const {};
    final assignableIds = drivers
        .where((driver) => driver.vehicleTypeId == trip.vehicleTypeId)
        .map((driver) => driver.id)
        .toSet();
    final distances = <String, double>{};

    for (final driver in liveDrivers) {
      if (!assignableIds.contains(driver.driverId) || !driver.hasLocation) {
        continue;
      }
      distances[driver.driverId] = _distanceKm(
        trip.pickupLatitude!,
        trip.pickupLongitude!,
        driver.latitude!,
        driver.longitude!,
      );
    }

    return distances;
  }

  double _distanceKm(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    const earthRadiusKm = 6371.0;
    final startLatRadians = _toRadians(startLatitude);
    final endLatRadians = _toRadians(endLatitude);
    final deltaLat = _toRadians(endLatitude - startLatitude);
    final deltaLng = _toRadians(endLongitude - startLongitude);
    final a =
        sin(deltaLat / 2) * sin(deltaLat / 2) +
        cos(startLatRadians) *
            cos(endLatRadians) *
            sin(deltaLng / 2) *
            sin(deltaLng / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadiusKm * c;
  }

  double _toRadians(double degrees) => degrees * pi / 180;
}
