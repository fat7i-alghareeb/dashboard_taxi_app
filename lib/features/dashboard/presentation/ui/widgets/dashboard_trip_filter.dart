import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';

enum DashboardTripFilter {
  all,
  scheduled,
  pending,
  active,
  completed,
  cancelled;

  String label() {
    switch (this) {
      case DashboardTripFilter.all:
        return AppStrings.dashboardFilterAll;
      case DashboardTripFilter.scheduled:
        return AppStrings.filterScheduled;
      case DashboardTripFilter.pending:
        return AppStrings.dashboardFilterPending;
      case DashboardTripFilter.active:
        return AppStrings.dashboardFilterActive;
      case DashboardTripFilter.completed:
        return AppStrings.dashboardFilterCompleted;
      case DashboardTripFilter.cancelled:
        return AppStrings.dashboardFilterCancelled;
    }
  }

  bool matches(DashboardTripEntity trip) {
    final s = trip.status.toLowerCase();
    switch (this) {
      case DashboardTripFilter.all:
        return true;
      case DashboardTripFilter.scheduled:
        return s == 'scheduled';
      case DashboardTripFilter.pending:
        return s == 'pending' ||
            s == 'requested' ||
            s == 'pendingdriver';
      case DashboardTripFilter.active:
        return s == 'active' ||
            s == 'started' ||
            s == 'assigned' ||
            s == 'driverassigned' ||
            s == 'enroute' ||
            s == 'en_route' ||
            s == 'driverenroute' ||
            s == 'arrived' ||
            s == 'driverarrived' ||
            s == 'inprogress';
      case DashboardTripFilter.completed:
        return s == 'completed';
      case DashboardTripFilter.cancelled:
        return s == 'cancelled' || s == 'canceled';
    }
  }
}
