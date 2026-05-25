import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_admin_user_row_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_section_shell_widget.dart';

class DashboardAdminUsersSection extends StatelessWidget {
  const DashboardAdminUsersSection({super.key, required this.users});

  final List<DashboardUserEntity> users;

  @override
  Widget build(BuildContext context) {
    return DashboardSectionShellWidget(
      title: AppStrings.dashboardUserManagement,
      icon: FontAwesomeIcons.usersGear,
      child: users.isEmpty
          ? EmptyStateWidget(text: AppStrings.dashboardNoUsers)
          : Column(
              children: users
                  .map(
                    (user) => Padding(
                      padding: REdgeInsets.only(bottom: AppSpacing.sm),
                      child: DashboardAdminUserRowWidget(user: user),
                    ),
                  )
                  .toList(),
            ),
    );
  }
}
