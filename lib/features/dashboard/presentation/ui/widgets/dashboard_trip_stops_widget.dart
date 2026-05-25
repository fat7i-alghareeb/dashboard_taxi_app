import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trip_stop_line_widget.dart';

class DashboardTripStopsWidget extends StatelessWidget {
  const DashboardTripStopsWidget({super.key, required this.details});

  final DashboardTripDetailsEntity details;

  @override
  Widget build(BuildContext context) {
    final pickup = details.pickup;
    final dropoff = details.dropoff;

    return Column(
      children: [
        DashboardTripStopLineWidget(
          label: AppStrings.tripPickup,
          value: pickup?.label ?? AppStrings.tripUnknownAddress,
          icon: FontAwesomeIcons.locationDot,
        ),
        AppSpacing.md.verticalSpace,
        DashboardTripStopLineWidget(
          label: AppStrings.tripDropoff,
          value: dropoff?.label ?? AppStrings.tripUnknownAddress,
          icon: FontAwesomeIcons.flagCheckered,
        ),
      ],
    );
  }
}
