import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
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
      icon: FontAwesomeIcons.taxi,
      child: trips.isEmpty
          ? EmptyStateWidget(text: AppStrings.dashboardNoPendingDispatch)
          : Column(
              children: trips
                  .map(
                    (trip) => Padding(
                      padding: REdgeInsets.only(bottom: AppSpacing.sm),
                      child: DashboardPendingTripRowWidget(
                        trip: trip,
                        drivers: drivers,
                      ),
                    ),
                  )
                  .toList(),
            ),
    );
  }
}
