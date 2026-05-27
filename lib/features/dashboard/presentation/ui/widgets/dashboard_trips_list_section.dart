import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_divider_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_section_shell_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trip_management_row_widget.dart';

class DashboardTripsListSection extends StatelessWidget {
  const DashboardTripsListSection({
    super.key,
    required this.trips,
    required this.selectedTripId,
    this.hasActiveFilter = false,
  });

  final List<DashboardTripEntity> trips;
  final String? selectedTripId;
  final bool hasActiveFilter;

  @override
  Widget build(BuildContext context) {
    return DashboardSectionShellWidget(
      title: AppStrings.dashboardAllTrips,
      icon: FontAwesomeIcons.route,
      itemCount: trips.isEmpty ? null : trips.length,
      child: trips.isEmpty
          ? EmptyStateWidget(
              text: hasActiveFilter
                  ? AppStrings.dashboardNoFilteredTrips
                  : AppStrings.dashboardNoTrips,
            )
          : Column(
              children: [
                for (int i = 0; i < trips.length; i++) ...[
                  DashboardTripManagementRowWidget(
                    trip: trips[i],
                    isSelected: trips[i].id == selectedTripId,
                  ),
                  if (i != trips.length - 1) const DashboardDividerWidget(),
                ],
              ],
            ),
    );
  }
}
