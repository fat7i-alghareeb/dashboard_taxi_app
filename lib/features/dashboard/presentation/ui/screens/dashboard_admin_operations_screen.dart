import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_admin_operations_body.dart';

class DashboardAdminOperationsScreen extends StatelessWidget {
  const DashboardAdminOperationsScreen({super.key});

  static const String pagePath = '/dashboard_admin_operations';
  static const String pageName = 'DashboardAdminOperationsScreen';

  @override
  Widget build(BuildContext context) {
    return AppScaffold.body(child: const DashboardAdminOperationsBody());
  }
}
