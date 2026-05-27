import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_metric_card_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_status_chip_widget.dart';

class DashboardMetricsGridWidget extends StatelessWidget {
  const DashboardMetricsGridWidget({super.key, required this.overview});

  final DashboardEntity overview;

  @override
  Widget build(BuildContext context) {
    final cards = <Widget>[
      DashboardMetricCardWidget(
        label: AppStrings.dashboardTotalTrips,
        value: overview.totalTrips.toString(),
        icon: FontAwesomeIcons.route,
      ),
      DashboardMetricCardWidget(
        label: AppStrings.dashboardActiveTrips,
        value: overview.activeTrips.toString(),
        icon: FontAwesomeIcons.carSide,
        tone: DashboardStatusTone.info,
      ),
      DashboardMetricCardWidget(
        label: AppStrings.dashboardCompletedTrips,
        value: overview.completedTrips.toString(),
        icon: FontAwesomeIcons.circleCheck,
        tone: DashboardStatusTone.success,
      ),
      DashboardMetricCardWidget(
        label: AppStrings.dashboardOnlineDrivers,
        value: overview.onlineDrivers.toString(),
        icon: FontAwesomeIcons.bolt,
        tone: DashboardStatusTone.success,
      ),
      DashboardMetricCardWidget(
        label: AppStrings.dashboardPendingKyc,
        value: overview.pendingKycDrivers.toString(),
        icon: FontAwesomeIcons.idCard,
        tone: DashboardStatusTone.warning,
      ),
      DashboardMetricCardWidget(
        label: AppStrings.dashboardTotalDrivers,
        value: overview.totalDrivers.toString(),
        icon: FontAwesomeIcons.solidUser,
        tone: DashboardStatusTone.neutral,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = AppSpacing.md;
        final tileWidth = (constraints.maxWidth - spacing.w) / 2;
        return Wrap(
          spacing: spacing.w,
          runSpacing: spacing.h,
          children: [
            for (int i = 0; i < cards.length; i++)
              SizedBox(
                width: tileWidth,
                child: cards[i]
                    .animate(delay: (i * 50).ms)
                    .fadeIn(duration: 280.ms)
                    .slideY(begin: 0.06, end: 0, duration: 280.ms),
              ),
          ],
        );
      },
    );
  }
}
