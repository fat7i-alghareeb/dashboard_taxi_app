import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_audit_log_row_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_divider_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_section_shell_widget.dart';

class DashboardAdminFullAuditSection extends StatelessWidget {
  const DashboardAdminFullAuditSection({super.key, required this.logs});

  final List<DashboardAuditLogEntity> logs;

  @override
  Widget build(BuildContext context) {
    return DashboardSectionShellWidget(
      title: AppStrings.dashboardAuditTrail,
      icon: FontAwesomeIcons.clockRotateLeft,
      itemCount: logs.isEmpty ? null : logs.length,
      child: logs.isEmpty
          ? EmptyStateWidget(text: AppStrings.dashboardNoRecentActivity)
          : Column(
              children: [
                for (int i = 0; i < logs.length; i++) ...[
                  DashboardAuditLogRowWidget(log: logs[i]),
                  if (i != logs.length - 1) const DashboardDividerWidget(),
                ],
              ],
            ),
    );
  }
}
