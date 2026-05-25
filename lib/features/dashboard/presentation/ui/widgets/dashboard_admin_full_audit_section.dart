import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_audit_log_row_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_section_shell_widget.dart';

class DashboardAdminFullAuditSection extends StatelessWidget {
  const DashboardAdminFullAuditSection({super.key, required this.logs});

  final List<DashboardAuditLogEntity> logs;

  @override
  Widget build(BuildContext context) {
    return DashboardSectionShellWidget(
      title: AppStrings.dashboardAuditTrail,
      icon: FontAwesomeIcons.timeline,
      child: logs.isEmpty
          ? EmptyStateWidget(text: AppStrings.dashboardNoRecentActivity)
          : Column(
              children: logs
                  .map(
                    (log) => Padding(
                      padding: REdgeInsets.only(bottom: AppSpacing.sm),
                      child: DashboardAuditLogRowWidget(log: log),
                    ),
                  )
                  .toList(),
            ),
    );
  }
}
