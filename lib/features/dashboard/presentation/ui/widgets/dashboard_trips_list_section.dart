import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_section_shell_widget.dart';
import 'package:dashboardtaxi/features/dashboard/presentation/ui/widgets/dashboard_trip_management_row_widget.dart';

class DashboardTripsListSection extends StatelessWidget {
  const DashboardTripsListSection({
    super.key,
    required this.trips,
    required this.selectedTripId,
    this.hasActiveFilter = false,
  });

  final List<DashboardTripEntity> trips;
  final String? selectedTripId;
  final bool hasActiveFilter;

  @override
  Widget build(BuildContext context) {
    final isEmpty = trips.isEmpty;
    return DashboardSectionShellWidget(
      title: AppStrings.dashboardAllTrips,
      icon: FontAwesomeIcons.route,
      itemCount: isEmpty ? null : trips.length,
      decorate: isEmpty,
      child: isEmpty
          ? EmptyStateWidget(
              text: hasActiveFilter
                  ? AppStrings.dashboardNoFilteredTrips
                  : AppStrings.dashboardNoTrips,
            )
          : Column(
              children: [
                for (int i = 0; i < trips.length; i++) ...[
                  _TripCard(
                    child: DashboardTripManagementRowWidget(
                      trip: trips[i],
                      isSelected: trips[i].id == selectedTripId,
                    ),
                  ),
                  if (i != trips.length - 1) AppSpacing.sm.verticalSpace,
                ],
              ],
            ),
    );
  }
}

class _TripCard extends StatelessWidget {
  const _TripCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(
          color: context.onSurface.withValues(alpha: 0.08),
        ),
      ),
      child: Padding(
        padding: REdgeInsets.all(AppSpacing.lg),
        child: child,
      ),
    );
  }
}
