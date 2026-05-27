import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/screens/dashboard_trips_screen.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_divider_widget.dart';
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
      itemCount: trips.isEmpty ? null : trips.length,
      trailingLabel: trips.isEmpty ? null : AppStrings.dashboardSeeAll,
      onTrailingTap: trips.isEmpty
          ? null
          : () => context.push(DashboardTripsScreen.pagePath),
      child: trips.isEmpty
          ? EmptyStateWidget(text: AppStrings.dashboardNoRecentTrips)
          : Column(
              children: [
                for (int i = 0; i < trips.length; i++) ...[
                  DashboardRecentTripRowWidget(trip: trips[i]),
                  if (i != trips.length - 1) const DashboardDividerWidget(),
                ],
              ],
            ),
    );
  }
}
