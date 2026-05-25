import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trip_timeline_row_widget.dart';

class DashboardTripTimelineWidget extends StatelessWidget {
  const DashboardTripTimelineWidget({super.key, required this.details});

  final DashboardTripDetailsEntity details;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DashboardTripTimelineRowWidget(
          label: AppStrings.tripCreatedAt,
          value: details.createdAt?.toSmartDateTime(),
        ),
        DashboardTripTimelineRowWidget(
          label: AppStrings.dashboardAssignedAt,
          value: details.assignedAt?.toSmartDateTime(),
        ),
        DashboardTripTimelineRowWidget(
          label: AppStrings.dashboardArrivedAt,
          value: details.arrivedAt?.toSmartDateTime(),
        ),
        DashboardTripTimelineRowWidget(
          label: AppStrings.dashboardStartedAt,
          value: details.startedAt?.toSmartDateTime(),
        ),
        DashboardTripTimelineRowWidget(
          label: AppStrings.dashboardCompletedAt,
          value: details.completedAt?.toSmartDateTime(),
        ),
      ],
    );
  }
}
