import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_admin_vehicle_type_row_widget.dart';
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
      child: vehicleTypes.isEmpty
          ? EmptyStateWidget(text: AppStrings.dashboardNoVehicleTypes)
          : Column(
              children: vehicleTypes
                  .map(
                    (type) => Padding(
                      padding: REdgeInsets.only(bottom: AppSpacing.sm),
                      child: DashboardAdminVehicleTypeRowWidget(
                        vehicleType: type,
                        isActionLoading: isActionLoading,
                      ),
                    ),
                  )
                  .toList(),
            ),
    );
  }
}
