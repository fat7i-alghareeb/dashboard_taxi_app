import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:dashboardtaxi/features/trip/presentation/ui/widgets/trip_info_tile_widget.dart';

class TripAssignmentFareRowWidget extends StatelessWidget {
  const TripAssignmentFareRowWidget({super.key, required this.trip});

  final TripEntity trip;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TripInfoTileWidget(
            label: AppStrings.tripFareLabel,
            value: AppStrings.tripFare.trParams({
              'fare': trip.quotedFare.toStringAsFixed(2),
              'currency': trip.currencyCode,
            }),
          ),
        ),
        AppSpacing.lg.horizontalSpace,
        Expanded(
          child: TripInfoTileWidget(
            label: AppStrings.tripVehicleType,
            value: trip.vehicleTypeName ?? trip.vehicleLabel,
          ),
        ),
      ],
    );
  }
}
