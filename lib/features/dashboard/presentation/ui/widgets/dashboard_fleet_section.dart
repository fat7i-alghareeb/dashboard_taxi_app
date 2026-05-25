import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppStrings.dashboardVehicleTypes,
            style: AppTextStyles.s14w600.copyWith(color: context.onSurface),
          ),
          AppSpacing.md.verticalSpace,
          if (vehicleTypes.isEmpty)
            EmptyStateWidget(text: AppStrings.dashboardNoVehicleTypes)
          else
            Column(
              children: vehicleTypes
                  .map(
                    (type) => Padding(
                      padding: REdgeInsets.only(bottom: AppSpacing.sm),
                      child: DashboardVehicleTypeRowWidget(vehicleType: type),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}
