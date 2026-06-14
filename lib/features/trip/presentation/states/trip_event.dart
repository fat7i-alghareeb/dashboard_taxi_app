part of 'trip_bloc.dart';

@freezed
class TripEvent with _$TripEvent {
  const factory TripEvent.started() = _Started;
  const factory TripEvent.getAllRequested() = _GetAllRequested;
  const factory TripEvent.realtimeEventReceived(RealtimeEvent event) =
      _RealtimeEventReceived;
  const factory TripEvent.fetchActiveRequested(String tripId) =
      _FetchActiveRequested;
  const factory TripEvent.activeTripResolveRequested() =
      _ActiveTripResolveRequested;
  const factory TripEvent.tripSelected(String tripId) = _TripSelected;
  const factory TripEvent.selectionCleared() = _SelectionCleared;
  const factory TripEvent.markEnRouteRequested(String tripId) =
      _MarkEnRouteRequested;
  const factory TripEvent.markArrivedRequested(String tripId) =
      _MarkArrivedRequested;
  const factory TripEvent.resendArrivedNotificationRequested(String tripId) =
      _ResendArrivedNotificationRequested;
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
  const factory TripEvent.completeStopRequested({
    required String tripId,
    required int sequence,
  }) = _CompleteStopRequested;
  const factory TripEvent.adminSelfAssignRequested(String tripId) =
      _AdminSelfAssignRequested;
  const factory TripEvent.adminCancelRequested(String tripId) =
      _AdminCancelRequested;
  const factory TripEvent.dismissPendingTripRequested(String tripId) =
      _DismissPendingTripRequested;
}
