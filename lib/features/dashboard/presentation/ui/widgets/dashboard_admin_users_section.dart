import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_admin_user_row_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_divider_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_section_shell_widget.dart';

class DashboardAdminUsersSection extends StatelessWidget {
  const DashboardAdminUsersSection({super.key, required this.users});

  final List<DashboardUserEntity> users;

  @override
  Widget build(BuildContext context) {
    return DashboardSectionShellWidget(
      title: AppStrings.dashboardUserManagement,
      icon: FontAwesomeIcons.usersGear,
      itemCount: users.isEmpty ? null : users.length,
      child: users.isEmpty
          ? EmptyStateWidget(text: AppStrings.dashboardNoUsers)
          : Column(
              children: [
                for (int i = 0; i < users.length; i++) ...[
                  DashboardAdminUserRowWidget(user: users[i]),
                  if (i != users.length - 1) const DashboardDividerWidget(),
                ],
              ],
            ),
    );
  }
}
