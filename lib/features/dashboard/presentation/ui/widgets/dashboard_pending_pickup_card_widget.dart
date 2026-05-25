import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_assign_driver_sheet.dart';

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
        : AppStrings.dashboardPickupAddress.replaceAll(
            '{address}',
            trip.pickupLabel!,
          );
    final distances = _driverDistancesById();

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.surface.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.2)),
        boxShadow: context.shadows.grey,
      ),
      child: Padding(
        padding: REdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.locationDot,
                  size: 18.r,
                  color: AppColors.warning,
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
                        style: AppTextStyles.s16w600.copyWith(
                          color: context.onSurface,
                        ),
                      ),
                      AppSpacing.xs.verticalSpace,
                      Text(
                        pickup,
                        maxLines: 2,
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
                  trip.fareLabel,
                  style: AppTextStyles.s14w600.copyWith(
                    color: context.onSurface,
                  ),
                ),
              ],
            ),
            AppSpacing.lg.verticalSpace,
            AppButton.primary(
              onTap: () => DashboardAssignDriverSheet.show(
                context,
                trip: trip,
                drivers: drivers,
                driverDistances: distances,
              ),
              child: AppButtonChild.label(AppStrings.dashboardAssignDriver),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: AppDurations.normal).slideY(begin: 0.08);
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
