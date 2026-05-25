import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_live_map_content_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_live_map_loading_widget.dart';

class DashboardLiveMapBody extends StatelessWidget {
  const DashboardLiveMapBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DashboardBloc>()
        ..add(const DashboardEvent.overviewRequested())
        ..add(const DashboardEvent.driverLocationsRequested()),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          final overview = state.overviewState.maybeWhen(
            success: (data) => data,
            orElse: () => null,
          );

          return StatusBuilder<List<DashboardDriverLocationEntity>>(
            state: state.driverLocationsState,
            loading: () => const DashboardLiveMapLoadingWidget(),
            success: (drivers) => DashboardLiveMapContentWidget(
              drivers: drivers,
              pendingTrips: overview?.pendingTrips ?? const [],
              assignableDrivers: overview?.assignableDrivers ?? const [],
            ),
          );
        },
      ),
    );
  }
}
