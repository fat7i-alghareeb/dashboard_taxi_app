import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_admin_driver_row_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_divider_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_section_shell_widget.dart';

class DashboardAdminDriversSection extends StatelessWidget {
  const DashboardAdminDriversSection({
    super.key,
    required this.drivers,
    required this.vehicleTypes,
    required this.isActionLoading,
  });

  final List<DashboardDriverEntity> drivers;
  final List<DashboardVehicleTypeEntity> vehicleTypes;
  final bool isActionLoading;

  @override
  Widget build(BuildContext context) {
    return DashboardSectionShellWidget(
      title: AppStrings.dashboardDriverManagement,
      icon: FontAwesomeIcons.idCardClip,
      itemCount: drivers.isEmpty ? null : drivers.length,
      child: drivers.isEmpty
          ? EmptyStateWidget(text: AppStrings.dashboardNoDrivers)
          : Column(
              children: [
                for (int i = 0; i < drivers.length; i++) ...[
                  DashboardAdminDriverRowWidget(
                    driver: drivers[i],
                    vehicleTypes: vehicleTypes,
                    isActionLoading: isActionLoading,
                  ),
                  if (i != drivers.length - 1) const DashboardDividerWidget(),
                ],
              ],
            ),
    );
  }
}
