import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_section_shell_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trip_management_row_widget.dart';
import 'package:dashboardtaxi/features/trip/presentation/states/trip_bloc.dart';

/// The records list, built as **slivers** so only on-screen cards are laid out.
/// It used to be a `Column` of every loaded trip inside a plain `ListView`:
/// with pagination that grew without bound and any dashboard state change
/// (a search keystroke, a realtime status patch) re-laid-out all of them,
/// which is what made the tab feel frozen.
class DashboardTripsListSection extends StatelessWidget {
  const DashboardTripsListSection({
    super.key,
    required this.trips,
    this.hasActiveFilter = false,
  });

  final List<DashboardTripEntity> trips;
  final bool hasActiveFilter;

  @override
  Widget build(BuildContext context) {
    final isEmpty = trips.isEmpty;

    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: DashboardSectionShellWidget(
            title: AppStrings.dashboardAllTrips,
            icon: FontAwesomeIcons.route,
            itemCount: isEmpty ? null : trips.length,
            decorate: false,
            child: const SizedBox.shrink(),
          ),
        ),
        if (isEmpty)
          SliverToBoxAdapter(
            child: EmptyStateWidget(
              text: hasActiveFilter
                  ? AppStrings.dashboardNoFilteredTrips
                  : AppStrings.dashboardNoTrips,
            ),
          )
        else
          SliverList.separated(
            itemCount: trips.length,
            separatorBuilder: (_, _) => AppSpacing.sm.verticalSpace,
            itemBuilder: (context, index) {
              final trip = trips[index];
              return RepaintBoundary(
                // Highlight follows TripBloc — the single source of truth for
                // "which trip is open". Scoped per row so selecting a trip
                // repaints two cards, not the whole list. The bloc is passed
                // explicitly (it is a lazySingleton) because this list also
                // renders on the pushed /dashboard_trips route, which sits
                // outside RootScreen's provider.
                child: BlocSelector<TripBloc, TripState, bool>(
                  bloc: getIt<TripBloc>(),
                  selector: (state) => state.selectedTripId == trip.id,
                  builder: (context, isSelected) => _TripCard(
                    isSelected: isSelected,
                    child: DashboardTripManagementRowWidget(
                      trip: trip,
                      isSelected: isSelected,
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}

class _TripCard extends StatelessWidget {
  const _TripCard({required this.child, required this.isSelected});

  final Widget child;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(
          color: isSelected
              ? context.primary.withValues(alpha: 0.55)
              : context.onSurface.withValues(alpha: 0.08),
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: Padding(padding: REdgeInsets.all(AppSpacing.lg), child: child),
    );
  }
}
