import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_live_map_body.dart';

class DashboardLiveMapScreen extends StatelessWidget {
  const DashboardLiveMapScreen({super.key});

  static const String pagePath = '/dashboard_live_map';
  static const String pageName = 'DashboardLiveMapScreen';

  @override
  Widget build(BuildContext context) {
    return AppScaffold.body(
      scaffoldConfig: const AppScaffoldConfig(safeArea: []),
      child: const DashboardLiveMapBody(),
    );
  }
}
