import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_admin_vehicle_type_row_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_divider_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_section_shell_widget.dart';

class DashboardAdminVehicleTypesSection extends StatelessWidget {
  const DashboardAdminVehicleTypesSection({
    super.key,
    required this.vehicleTypes,
    required this.isActionLoading,
  });

  final List<DashboardVehicleTypeEntity> vehicleTypes;
  final bool isActionLoading;

  @override
  Widget build(BuildContext context) {
    return DashboardSectionShellWidget(
      title: AppStrings.dashboardVehicleTypeManagement,
      icon: FontAwesomeIcons.taxi,
      itemCount: vehicleTypes.isEmpty ? null : vehicleTypes.length,
      child: vehicleTypes.isEmpty
          ? EmptyStateWidget(text: AppStrings.dashboardNoVehicleTypes)
          : Column(
              children: [
                for (int i = 0; i < vehicleTypes.length; i++) ...[
                  DashboardAdminVehicleTypeRowWidget(
                    vehicleType: vehicleTypes[i],
                    isActionLoading: isActionLoading,
                  ),
                  if (i != vehicleTypes.length - 1)
                    const DashboardDividerWidget(),
                ],
              ],
            ),
    );
  }
}
