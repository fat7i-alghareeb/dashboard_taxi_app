import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_stop_row_widget.dart';

class TripRouteCardWidget extends StatelessWidget {
  const TripRouteCardWidget({super.key, required this.trip});

  final TripEntity trip;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TripStopRowWidget(
          label: AppStrings.tripPickup,
          value: trip.pickup?.displayLabel ?? AppStrings.tripUnknownAddress,
          isPickup: true,
          isLast: false,
        ),
        TripStopRowWidget(
          label: AppStrings.tripDropoff,
          value: trip.dropoff?.displayLabel ?? AppStrings.tripUnknownAddress,
          isPickup: false,
          isLast: true,
        ),
      ],
    );
  }
}
