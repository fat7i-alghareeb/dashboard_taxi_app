import '../../domain/entities/trip_entity.dart';
import 'trip_bloc.dart';

/// Discrete UI stages presented by [TripSheetSection].
///
/// The customer-side `OrderSheetMode` swaps content via `AnimatedSwitcher` —
/// we mirror the same idea on the driver/admin side, but driven by the trip's
/// server status instead of a user-typed booking flow.
enum TripSheetStage {
  /// No selected trip and no recent completion — idle map.
  idle,

  /// Selected trip not yet assigned (`pendingDriver`/`scheduled`): admin can
  /// take it or assign a driver.
  pendingAssignment,

  /// Trip assigned, awaiting accept (`driverAssigned`).
  incoming,

  /// Driver heading to pickup (`driverEnRoute`).
  toPickup,

  /// Driver waiting at pickup, customer not yet on board (`driverArrived`).
  atPickup,

  /// Trip in progress towards stops/destination (`inProgress`).
  inProgress,

  /// Trip just completed in-session — show summary until dismissed.
  summary,

  /// A terminal or non-actionable trip selected from the list — read-only info.
  readonly,
}

extension TripSheetStageX on TripState {
  TripSheetStage get sheetStage {
    // Only an in-session completion (set by the complete/cancel flows) shows the
    // celebratory summary. Tapping a finished trip uses the read-only stage.
    if (completedTrip != null) return TripSheetStage.summary;

    // Pending/new admin trips no longer auto-open the sheet; they surface via
    // the Trips-tab badge + notification. The sheet only shows a selected trip.
    final trip = activeTrip;
    if (trip == null) return TripSheetStage.idle;

    return switch (trip.status) {
      TripStatus.pendingDriver ||
      TripStatus.scheduled => TripSheetStage.pendingAssignment,
      TripStatus.driverAssigned => TripSheetStage.incoming,
      TripStatus.driverEnRoute => TripSheetStage.toPickup,
      TripStatus.driverArrived => TripSheetStage.atPickup,
      TripStatus.inProgress => TripSheetStage.inProgress,
      _ => TripSheetStage.readonly,
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
