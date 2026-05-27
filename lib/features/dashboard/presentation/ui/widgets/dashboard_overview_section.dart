import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_activity_section.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_fleet_section.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_header_section.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_metrics_grid_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_overview_label_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_pending_drivers_section.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_pending_trips_section.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_recent_trips_section.dart';

class DashboardOverviewSection extends StatelessWidget {
  const DashboardOverviewSection({super.key, required this.overview});

  final DashboardEntity overview;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const DashboardHeaderSection(),
          AppSpacing.xxl.verticalSpace,
          DashboardOverviewLabelWidget(
            label: AppStrings.dashboardOverviewLabel,
          ),
          AppSpacing.md.verticalSpace,
          DashboardMetricsGridWidget(overview: overview),
          AppSpacing.xxl.verticalSpace,
          DashboardPendingTripsSection(
            trips: overview.pendingTrips,
            drivers: overview.assignableDrivers,
          ),
          AppSpacing.xl.verticalSpace,
          DashboardPendingDriversSection(drivers: overview.pendingDrivers),
          AppSpacing.xl.verticalSpace,
          DashboardRecentTripsSection(trips: overview.recentTrips),
          AppSpacing.xl.verticalSpace,
          DashboardFleetSection(vehicleTypes: overview.vehicleTypes),
          AppSpacing.xl.verticalSpace,
          DashboardActivitySection(logs: overview.auditLogs),
          AppSpacing.xxl.verticalSpace,
        ],
      ),
    );
  }
}
