import '../../domain/entities/trip_entity.dart';
import 'trip_bloc.dart';

/// Discrete UI stages presented by [TripSheetSection].
///
/// The customer-side `OrderSheetMode` swaps content via `AnimatedSwitcher` —
/// we mirror the same idea on the driver/admin side, but driven by the trip's
/// server status instead of a user-typed booking flow.
enum TripSheetStage {
  /// No active trip and no recent completion — idle map.
  idle,

  /// New trip arrived (admin-only): waiting for admin to take or dismiss.
  adminPending,

  /// Trip just assigned to this driver, awaiting accept (`driverAssigned`).
  incoming,

  /// Driver heading to pickup (`driverEnRoute`).
  toPickup,

  /// Driver waiting at pickup, customer not yet on board (`driverArrived`).
  atPickup,

  /// Trip in progress towards stops/destination (`inProgress`).
  inProgress,

  /// Trip just completed — show summary until dismissed.
  summary,
}

extension TripSheetStageX on TripState {
  TripSheetStage get sheetStage {
    if (completedTrip != null) return TripSheetStage.summary;
    final trip = activeTrip;
    if (trip == null) {
      if (pendingTrip != null) return TripSheetStage.adminPending;
      return TripSheetStage.idle;
    }
    return switch (trip.status) {
      TripStatus.driverAssigned => TripSheetStage.incoming,
      TripStatus.driverEnRoute => TripSheetStage.toPickup,
      TripStatus.driverArrived => TripSheetStage.atPickup,
      TripStatus.inProgress => TripSheetStage.inProgress,
      _ => TripSheetStage.idle,
    };
  }
}

extension TripEntityStopsX on TripEntity {
  /// Stops between pickup and dropoff (exclusive). `stops` is `[pickup, ..., dropoff]`.
  List<TripStopEntity> get intermediateStops {
    if (stops.length <= 2) return const <TripStopEntity>[];
    return stops.sublist(1, stops.length - 1);
  }

  bool get hasIntermediateStops => intermediateStops.isNotEmpty;
}
