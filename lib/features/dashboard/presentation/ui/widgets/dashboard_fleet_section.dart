import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_divider_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_section_shell_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_vehicle_type_row_widget.dart';

class DashboardFleetSection extends StatelessWidget {
  const DashboardFleetSection({super.key, required this.vehicleTypes});

  final List<DashboardVehicleTypeEntity> vehicleTypes;

  @override
  Widget build(BuildContext context) {
    return DashboardSectionShellWidget(
      title: AppStrings.dashboardFleet,
      icon: FontAwesomeIcons.taxi,
      itemCount: vehicleTypes.isEmpty ? null : vehicleTypes.length,
      child: vehicleTypes.isEmpty
          ? EmptyStateWidget(text: AppStrings.dashboardNoVehicleTypes)
          : Column(
              children: [
                for (int i = 0; i < vehicleTypes.length; i++) ...[
                  DashboardVehicleTypeRowWidget(vehicleType: vehicleTypes[i]),
                  if (i != vehicleTypes.length - 1)
                    const DashboardDividerWidget(),
                ],
              ],
            ),
    );
  }
}
