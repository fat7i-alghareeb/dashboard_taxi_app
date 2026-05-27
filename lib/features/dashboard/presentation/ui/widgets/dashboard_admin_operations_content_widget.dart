import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_admin_config_section.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_admin_drivers_section.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_admin_full_audit_section.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_admin_users_section.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_admin_vehicle_types_section.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_admin_profile_section.dart';

class DashboardAdminOperationsContentWidget extends StatelessWidget {
  const DashboardAdminOperationsContentWidget({
    super.key,
    required this.operations,
    required this.isActionLoading,
  });

  final DashboardAdminOperationsEntity operations;
  final bool isActionLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DashboardAdminProfileSection(profile: operations.adminProfile),
        if (operations.adminProfile != null) AppSpacing.xl.verticalSpace,
        DashboardAdminConfigSection(
          config: operations.config,
          isActionLoading: isActionLoading,
        ),
        AppSpacing.xl.verticalSpace,
        DashboardAdminDriversSection(
          drivers: operations.drivers,
          vehicleTypes: operations.vehicleTypes,
          isActionLoading: isActionLoading,
        ),
        AppSpacing.xl.verticalSpace,
        DashboardAdminVehicleTypesSection(
          vehicleTypes: operations.vehicleTypes,
          isActionLoading: isActionLoading,
        ),
        AppSpacing.xl.verticalSpace,
        DashboardAdminUsersSection(users: operations.users),
        AppSpacing.xl.verticalSpace,
        DashboardAdminFullAuditSection(logs: operations.auditLogs),
      ],
    );
  }
}
