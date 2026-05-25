import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_activity_section.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_fleet_section.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_header_section.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_metric_card_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_pending_drivers_section.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_pending_trips_section.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_recent_trips_section.dart';

class DashboardOverviewSection extends StatelessWidget {
  const DashboardOverviewSection({super.key, required this.overview});

  final DashboardEntity overview;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: REdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const DashboardHeaderSection(),
          AppSpacing.xl.verticalSpace,
          Wrap(
            spacing: AppSpacing.md.w,
            runSpacing: AppSpacing.md.h,
            children: [
              DashboardMetricCardWidget(
                label: AppStrings.dashboardTotalTrips,
                value: overview.totalTrips.toString(),
                icon: FontAwesomeIcons.route,
              ),
              DashboardMetricCardWidget(
                label: AppStrings.dashboardActiveTrips,
                value: overview.activeTrips.toString(),
                icon: FontAwesomeIcons.carSide,
              ),
              DashboardMetricCardWidget(
                label: AppStrings.dashboardCompletedTrips,
                value: overview.completedTrips.toString(),
                icon: FontAwesomeIcons.circleCheck,
              ),
              DashboardMetricCardWidget(
                label: AppStrings.dashboardOnlineDrivers,
                value: overview.onlineDrivers.toString(),
                icon: FontAwesomeIcons.bolt,
              ),
              DashboardMetricCardWidget(
                label: AppStrings.dashboardPendingKyc,
                value: overview.pendingKycDrivers.toString(),
                icon: FontAwesomeIcons.idCard,
              ),
              DashboardMetricCardWidget(
                label: AppStrings.dashboardTotalDrivers,
                value: overview.totalDrivers.toString(),
                icon: FontAwesomeIcons.solidUser,
              ),
              DashboardMetricCardWidget(
                label: AppStrings.dashboardVehicleTypes,
                value: overview.vehicleTypes.length.toString(),
                icon: FontAwesomeIcons.taxi,
              ),
            ],
          ),
          AppSpacing.xl.verticalSpace,
          DashboardFleetSection(vehicleTypes: overview.vehicleTypes),
          AppSpacing.lg.verticalSpace,
          DashboardPendingTripsSection(
            trips: overview.pendingTrips,
            drivers: overview.assignableDrivers,
          ),
          AppSpacing.lg.verticalSpace,
          DashboardPendingDriversSection(drivers: overview.pendingDrivers),
          AppSpacing.lg.verticalSpace,
          DashboardRecentTripsSection(trips: overview.recentTrips),
          AppSpacing.lg.verticalSpace,
          DashboardActivitySection(logs: overview.auditLogs),
        ],
      ),
    );
  }
}
