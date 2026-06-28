import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/customers/domain/entities/customer_filter_args.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trips_body.dart';

class DashboardTripsScreen extends StatelessWidget {
  const DashboardTripsScreen({super.key, this.customerFilter});

  /// Optional customer to pre-filter the records by (passed via route `extra`).
  final CustomerFilterArgs? customerFilter;

  static const String pagePath = '/dashboard_trips';
  static const String pageName = 'DashboardTripsScreen';

  @override
  Widget build(BuildContext context) {
    return AppScaffold.body(
      child: DashboardTripsBody(customerFilter: customerFilter),
    );
  }
}
