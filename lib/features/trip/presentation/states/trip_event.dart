part of 'trip_bloc.dart';

@freezed
class TripEvent with _$TripEvent {
  const factory TripEvent.started() = _Started;
  const factory TripEvent.getAllRequested() = _GetAllRequested;
  const factory TripEvent.realtimeEventReceived(RealtimeEvent event) =
      _RealtimeEventReceived;
  const factory TripEvent.fetchActiveRequested(String tripId) =
      _FetchActiveRequested;
  const factory TripEvent.markEnRouteRequested(String tripId) =
      _MarkEnRouteRequested;
  const factory TripEvent.markArrivedRequested(String tripId) =
      _MarkArrivedRequested;
  const factory TripEvent.startTripRequested(String tripId) =
      _StartTripRequested;
  const factory TripEvent.completeTripRequested(String tripId) =
      _CompleteTripRequested;
  const factory TripEvent.clearCompletedSummaryRequested() =
      _ClearCompletedSummaryRequested;
  const factory TripEvent.driverCancelRequested({
    required String tripId,
    required String reason,
    String? note,
  }) = _DriverCancelRequested;
  const factory TripEvent.startWaitingRequested(String tripId) =
      _StartWaitingRequested;
  const factory TripEvent.stopWaitingRequested(String tripId) =
      _StopWaitingRequested;
}
