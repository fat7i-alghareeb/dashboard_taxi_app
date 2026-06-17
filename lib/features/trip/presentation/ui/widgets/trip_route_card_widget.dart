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
