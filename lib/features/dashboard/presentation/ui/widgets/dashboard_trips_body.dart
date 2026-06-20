import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/states/dashboard_bloc.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trip_filter.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trip_filter_pills_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trips_header_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trips_list_section.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trips_shimmer_widget.dart';

class DashboardTripsBody extends StatefulWidget {
  final bool showBackButton;

  const DashboardTripsBody({super.key, this.showBackButton = true});

  @override
  State<DashboardTripsBody> createState() => _DashboardTripsBodyState();
}

class _DashboardTripsBodyState extends State<DashboardTripsBody> {
  DashboardTripFilter _filter = DashboardTripFilter.all;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<DashboardBloc>()
            ..add(const DashboardEvent.adminTripsRequested()),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<DashboardBloc>().add(
                const DashboardEvent.adminTripsRequested(),
              );
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: REdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.lg,
              ),
              children: [
                DashboardTripsHeaderWidget(
                  showBackButton: widget.showBackButton,
                ),
                AppSpacing.lg.verticalSpace,
                DashboardTripFilterPillsWidget(
                  selected: _filter,
                  onChanged: (f) => setState(() => _filter = f),
                ),
                AppSpacing.xl.verticalSpace,
                StatusBuilder<List<DashboardTripEntity>>(
                  state: state.adminTripsState,
                  loading: () => const DashboardTripsShimmerWidget(),
                  success: (trips) {
                    final filtered = trips
                        .where((t) => _filter.matches(t))
                        .toList();
                    return DashboardTripsListSection(
                      trips: filtered,
                      selectedTripId: state.selectedTripId,
                      hasActiveFilter: _filter != DashboardTripFilter.all,
                    );
                  },
                ),
                AppSpacing.xxl.verticalSpace,
              ],
            ),
          );
        },
      ),
    );
  }
}
