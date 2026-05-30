import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/control_center/presentation/ui/widgets/control_center_body.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';

/// Control Center — the single admin surface that merges platform pricing /
/// payments configuration with fleet (vehicle type) management.
///
/// Each section owns its loading state, so saving pricing never blocks the
/// fleet list and vice-versa.
class ControlCenterScreen extends StatelessWidget {
  const ControlCenterScreen({super.key});

  static const String pagePath = '/control-center';
  static const String pageName = 'ControlCenterScreen';

  @override
  Widget build(BuildContext context) {
    return AppScaffold.body(
      child: BlocProvider(
        create: (_) => getIt<DashboardBloc>()
          ..add(const DashboardEvent.adminConfigRequested())
          ..add(const DashboardEvent.adminVehicleTypesRequested()),
        child: const ControlCenterBody(),
      ),
    );
  }
}
