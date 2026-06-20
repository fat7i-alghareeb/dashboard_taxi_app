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
      ],
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
