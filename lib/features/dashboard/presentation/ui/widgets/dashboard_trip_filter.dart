import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/dashboard/domain/entities/dashboard_entity.dart';

enum DashboardTripFilter {
  all,
  pending,
  active,
  completed,
  cancelled;

  String label() {
    switch (this) {
      case DashboardTripFilter.all:
        return AppStrings.dashboardFilterAll;
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
      case DashboardTripFilter.pending:
        return s == 'pending' || s == 'requested';
      case DashboardTripFilter.active:
        return s == 'active' ||
            s == 'started' ||
            s == 'assigned' ||
            s == 'enroute' ||
            s == 'en_route' ||
            s == 'arrived';
      case DashboardTripFilter.completed:
        return s == 'completed';
      case DashboardTripFilter.cancelled:
        return s == 'cancelled' || s == 'canceled';
    }
  }
}
