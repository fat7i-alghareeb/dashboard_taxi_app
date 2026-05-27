import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trip_timeline_row_widget.dart';

class DashboardTripTimelineWidget extends StatelessWidget {
  const DashboardTripTimelineWidget({super.key, required this.details});

  final DashboardTripDetailsEntity details;

  @override
  Widget build(BuildContext context) {
    final rows = [
      (AppStrings.tripCreatedAt, details.createdAt?.toSmartDateTime()),
      (AppStrings.dashboardAssignedAt, details.assignedAt?.toSmartDateTime()),
      (AppStrings.dashboardArrivedAt, details.arrivedAt?.toSmartDateTime()),
      (AppStrings.dashboardStartedAt, details.startedAt?.toSmartDateTime()),
      (AppStrings.dashboardCompletedAt, details.completedAt?.toSmartDateTime()),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (int i = 0; i < rows.length; i++)
          DashboardTripTimelineRowWidget(
            label: rows[i].$1,
            value: rows[i].$2,
            isLast: i == rows.length - 1,
          ),
      ],
    );
  }
}
