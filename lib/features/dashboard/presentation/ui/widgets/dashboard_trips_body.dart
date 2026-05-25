import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trip_details_panel_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trips_header_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trips_list_section.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trips_shimmer_widget.dart';

class DashboardTripsBody extends StatelessWidget {
  const DashboardTripsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<DashboardBloc>()..add(const DashboardEvent.adminTripsRequested()),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: REdgeInsets.all(AppSpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const DashboardTripsHeaderWidget(),
                AppSpacing.xl.verticalSpace,
                StatusBuilder<List<DashboardTripEntity>>(
                  state: state.adminTripsState,
                  loading: () => const DashboardTripsShimmerWidget(),
                  onRefresh: () async {
                    context.read<DashboardBloc>().add(
                      const DashboardEvent.adminTripsRequested(),
                    );
                  },
                  success: (trips) => DashboardTripsListSection(
                    trips: trips,
                    selectedTripId: state.selectedTripId,
                  ),
                ),
                AppSpacing.lg.verticalSpace,
                DashboardTripDetailsPanelWidget(state: state.tripDetailsState),
              ],
            ),
          );
        },
      ),
    );
  }
}
