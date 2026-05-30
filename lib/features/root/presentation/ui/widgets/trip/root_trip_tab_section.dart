import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trips_body.dart';

class RootTripTabSection extends StatelessWidget {
  const RootTripTabSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: BlocProvider(
        create: (_) =>
            getIt<DashboardBloc>()..add(const DashboardEvent.adminTripsRequested()),
        child: const DashboardTripsBody(
          showBackButton: false,
        ),
      ),
    );
  }
}
