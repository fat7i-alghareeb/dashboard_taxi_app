import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/control_center/presentation/ui/widgets/control_center_section_error.dart';
import 'package:dashboardtaxi/features/control_center/presentation/ui/widgets/control_center_vehicle_type_card.dart';
import 'package:dashboardtaxi/features/control_center/presentation/ui/widgets/control_center_vehicle_type_form_sheet.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';

class ControlCenterFleetSection extends StatelessWidget {
  const ControlCenterFleetSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      buildWhen: (prev, curr) =>
          prev.adminVehicleTypesState != curr.adminVehicleTypesState ||
          prev.vehicleTypeActionState != curr.vehicleTypeActionState,
      builder: (context, state) {
        final isBusy = state.vehicleTypeActionState.isLoading;
        return AppSectionShell(
          title: AppStrings.controlCenterFleetTitle,
          subtitle: AppStrings.controlCenterFleetSubtitle,
          icon: FontAwesomeIcons.carSide,
          isBusy: isBusy,
          trailingLabel: AppStrings.settingsVehicleTypeAdd,
          onTrailingTap: isBusy
              ? null
              : () => ControlCenterVehicleTypeFormSheet.show(context),
          child: state.adminVehicleTypesState.when(
            initial: () => const _FleetShimmer(),
            loading: () => const _FleetShimmer(),
            success: (vehicleTypes) => vehicleTypes.isEmpty
                ? EmptyStateWidget(text: AppStrings.settingsEmptyVehicleTypes)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (int i = 0; i < vehicleTypes.length; i++) ...[
                        ControlCenterVehicleTypeCard(
                          vehicleType: vehicleTypes[i],
                          isBusy: isBusy,
                        ),
                        if (i != vehicleTypes.length - 1)
                          AppSpacing.md.verticalSpace,
                      ],
                    ],
                  ),
            failure: (message) => ControlCenterSectionError(
              message: message,
              onRetry: () => context.read<DashboardBloc>().add(
                const DashboardEvent.adminVehicleTypesRequested(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _FleetShimmer extends StatelessWidget {
  const _FleetShimmer();

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Column(
        children: [
          for (int i = 0; i < 3; i++) ...[
            Container(
              height: 96.h,
              decoration: BoxDecoration(
                color: context.onSurface.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(AppRadii.md.r),
              ),
            ),
            if (i != 2) AppSpacing.md.verticalSpace,
          ],
        ],
      ),
    );
  }
}
