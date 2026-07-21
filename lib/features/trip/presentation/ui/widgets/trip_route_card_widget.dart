import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_stop_row_widget.dart';

class TripRouteCardWidget extends StatelessWidget {
  const TripRouteCardWidget({super.key, required this.trip});

  final TripEntity trip;

  @override
  Widget build(BuildContext context) {
    final stops = trip.stops;
    int nextStopIndex = -1;
    for (var i = 0; i < stops.length; i++) {
      if (!stops[i].isCompleted) {
        nextStopIndex = i;
        break;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (trip.isAirport && trip.flightNumber?.trim().isNotEmpty == true) ...[
          _AirportFlightCard(flightNumber: trip.flightNumber!.trim()),
          AppSpacing.md.verticalSpace,
        ],
        for (var i = 0; i < stops.length; i++)
          TripStopRowWidget(
            label: i == 0
                ? AppStrings.tripPickup
                : i == stops.length - 1
                ? AppStrings.tripDropoff
                : AppStrings.tripStopNumber.trParams({'number': '$i'}),
            value: stops[i].displayLabel,
            isPickup: i == 0,
            isLast: i == stops.length - 1,
            isCompleted: stops[i].isCompleted,
            isNext: i == nextStopIndex,
            latitude: stops[i].latitude,
            longitude: stops[i].longitude,
          ),
        AppSpacing.md.verticalSpace,
        _PartySizeRow(
          passengerCount: trip.passengerCount,
          bagCount: trip.bagCount,
        ),
      ],
    );
  }
}

/// Passenger and luggage counts. The admin needs these to pick a vehicle and to
/// spot when the customer changes them mid-trip.
class _PartySizeRow extends StatelessWidget {
  const _PartySizeRow({required this.passengerCount, required this.bagCount});

  final int passengerCount;
  final int bagCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _PartySizeChip(
            icon: FontAwesomeIcons.users,
            label: AppStrings.tripPassengerCount.trParams({
              'count': '$passengerCount',
            }),
          ),
        ),
        AppSpacing.sm.horizontalSpace,
        Expanded(
          child: _PartySizeChip(
            icon: FontAwesomeIcons.suitcase,
            label: AppStrings.tripBagCount.trParams({'count': '$bagCount'}),
          ),
        ),
      ],
    );
  }
}

class _PartySizeChip extends StatelessWidget {
  const _PartySizeChip({required this.icon, required this.label});

  final FaIconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: context.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadii.md.r),
      ),
      child: Row(
        children: [
          FaIcon(
            icon,
            size: 14.r,
            color: context.onSurface.withValues(alpha: 0.65),
          ),
          AppSpacing.sm.horizontalSpace,
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.s14w500.copyWith(color: context.onSurface),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _AirportFlightCard extends StatelessWidget {
  const _AirportFlightCard({required this.flightNumber});

  final String flightNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: context.primary.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(AppRadii.md.r),
        border: Border.all(color: context.primary.withValues(alpha: 0.24)),
      ),
      child: Row(
        children: [
          FaIcon(FontAwesomeIcons.planeArrival, color: context.primary),
          AppSpacing.md.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.airportPickup,
                  style: AppTextStyles.s12w500.copyWith(
                    color: context.onSurface.withValues(alpha: 0.65),
                  ),
                ),
                2.verticalSpace,
                Text(
                  '${AppStrings.flightNumber}: $flightNumber',
                  style: AppTextStyles.s16w600.copyWith(
                    color: context.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
