import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_divider_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_pending_trip_row_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_section_shell_widget.dart';

class DashboardPendingTripsSection extends StatelessWidget {
  const DashboardPendingTripsSection({
    super.key,
    required this.trips,
    required this.drivers,
  });

  final List<DashboardTripEntity> trips;
  final List<DashboardDriverEntity> drivers;

  @override
  Widget build(BuildContext context) {
    return DashboardSectionShellWidget(
      title: AppStrings.dashboardPendingDispatch,
      icon: FontAwesomeIcons.bell,
      itemCount: trips.isEmpty ? null : trips.length,
      child: trips.isEmpty
          ? EmptyStateWidget(text: AppStrings.dashboardNoPendingDispatch)
          : Column(
              children: [
                for (int i = 0; i < trips.length; i++) ...[
                  DashboardPendingTripRowWidget(
                    trip: trips[i],
                    drivers: drivers,
                  ),
                  if (i != trips.length - 1) const DashboardDividerWidget(),
                ],
              ],
            ),
    );
  }
}
