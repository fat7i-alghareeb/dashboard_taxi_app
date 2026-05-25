import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_section_shell_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trip_management_row_widget.dart';

class DashboardTripsListSection extends StatelessWidget {
  const DashboardTripsListSection({
    super.key,
    required this.trips,
    required this.selectedTripId,
  });

  final List<DashboardTripEntity> trips;
  final String? selectedTripId;

  @override
  Widget build(BuildContext context) {
    return DashboardSectionShellWidget(
      title: AppStrings.dashboardAllTrips,
      icon: FontAwesomeIcons.route,
      child: trips.isEmpty
          ? EmptyStateWidget(text: AppStrings.dashboardNoTrips)
          : Column(
              children: trips
                  .map(
                    (trip) => Padding(
                      padding: REdgeInsets.only(bottom: AppSpacing.sm),
                      child: DashboardTripManagementRowWidget(
                        trip: trip,
                        isSelected: trip.id == selectedTripId,
                      ),
                    ),
                  )
                  .toList(),
            ),
    );
  }
}
