import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:dashboardtaxi/features/control_center/presentation/ui/widgets/control_center_fleet_section.dart';
import 'package:dashboardtaxi/features/control_center/presentation/ui/widgets/control_center_header.dart';
import 'package:dashboardtaxi/features/control_center/presentation/ui/widgets/control_center_pricing_section.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';

class ControlCenterBody extends StatelessWidget {
  const ControlCenterBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DashboardBloc, DashboardState>(
      listenWhen: (a, b) =>
          a.configActionState != b.configActionState ||
          a.vehicleTypeActionState != b.vehicleTypeActionState,
      listener: (context, state) {
        for (final action in [
          state.configActionState,
          state.vehicleTypeActionState,
        ]) {
          action.maybeWhen(
            success: (_) => showSuccessOverlay(context, AppStrings.done),
            failure: (message) => showErrorOverlay(context, message),
            orElse: () {},
          );
        }
      },
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<DashboardBloc>()
            ..add(const DashboardEvent.adminConfigRequested())
            ..add(const DashboardEvent.adminVehicleTypesRequested());
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: REdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.xxl,
          ),
          children: [
            const ControlCenterHeader(),
            AppSpacing.xl.verticalSpace,
            const ControlCenterPricingSection(),
            AppSpacing.xl.verticalSpace,
            const ControlCenterFleetSection(),
          ],
        ),
      ),
    );
  }
}
