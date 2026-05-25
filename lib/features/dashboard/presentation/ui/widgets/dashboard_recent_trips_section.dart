import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_recent_trip_row_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_section_shell_widget.dart';

class DashboardRecentTripsSection extends StatelessWidget {
  const DashboardRecentTripsSection({super.key, required this.trips});

  final List<DashboardTripEntity> trips;

  @override
  Widget build(BuildContext context) {
    return DashboardSectionShellWidget(
      title: AppStrings.dashboardRecentTrips,
      icon: FontAwesomeIcons.route,
      child: trips.isEmpty
          ? EmptyStateWidget(text: AppStrings.dashboardNoRecentTrips)
          : Column(
              children: trips
                  .map(
                    (trip) => Padding(
                      padding: REdgeInsets.only(bottom: AppSpacing.sm),
                      child: DashboardRecentTripRowWidget(trip: trip),
                    ),
                  )
                  .toList(),
            ),
    );
  }
}
