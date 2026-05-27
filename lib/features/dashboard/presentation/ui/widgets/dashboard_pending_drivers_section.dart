import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_divider_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_pending_driver_row_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_section_shell_widget.dart';

class DashboardPendingDriversSection extends StatelessWidget {
  const DashboardPendingDriversSection({super.key, required this.drivers});

  final List<DashboardDriverEntity> drivers;

  @override
  Widget build(BuildContext context) {
    return DashboardSectionShellWidget(
      title: AppStrings.dashboardPendingDriverReviews,
      icon: FontAwesomeIcons.idCard,
      itemCount: drivers.isEmpty ? null : drivers.length,
      child: drivers.isEmpty
          ? EmptyStateWidget(text: AppStrings.dashboardNoPendingDriverReviews)
          : Column(
              children: [
                for (int i = 0; i < drivers.length; i++) ...[
                  DashboardPendingDriverRowWidget(driver: drivers[i]),
                  if (i != drivers.length - 1) const DashboardDividerWidget(),
                ],
              ],
            ),
    );
  }
}
