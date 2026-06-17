import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trip_stop_line_widget.dart';

class DashboardTripStopsWidget extends StatelessWidget {
  const DashboardTripStopsWidget({super.key, required this.details});

  final DashboardTripDetailsEntity details;

  @override
  Widget build(BuildContext context) {
    final stops = details.stops;

    if (stops.isEmpty) {
      return DashboardTripStopLineWidget(
        label: AppStrings.dashboardRouteSummary,
        value: AppStrings.tripUnknownAddress,
        isPickup: false,
        isLast: true,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < stops.length; i++)
          DashboardTripStopLineWidget(
            label: _labelForStop(i, stops.length),
            value: stops[i].displayLabel,
            isPickup: i == 0,
            isLast: i == stops.length - 1,
            latitude: stops[i].latitude,
            longitude: stops[i].longitude,
          ),
      ],
    );
  }

  String _labelForStop(int index, int total) {
    if (index == 0) return AppStrings.tripPickup;
    if (index == total - 1) return AppStrings.tripDropoff;
    return AppStrings.tripStopNumber.trParams({'number': '$index'});
  }
}
