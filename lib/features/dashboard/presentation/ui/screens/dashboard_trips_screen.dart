import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trips_body.dart';

class DashboardTripsScreen extends StatelessWidget {
  const DashboardTripsScreen({super.key});

  static const String pagePath = '/dashboard_trips';
  static const String pageName = 'DashboardTripsScreen';

  @override
  Widget build(BuildContext context) {
    return AppScaffold.body(child: const DashboardTripsBody());
  }
}
