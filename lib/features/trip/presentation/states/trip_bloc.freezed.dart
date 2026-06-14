// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TripEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TripEvent()';
}


}

/// @nodoc
class $TripEventCopyWith<$Res>  {
$TripEventCopyWith(TripEvent _, $Res Function(TripEvent) __);
}


/// Adds pattern-matching-related methods to [TripEvent].
extension TripEventPatterns on TripEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _GetAllRequested value)?  getAllRequested,TResult Function( _RealtimeEventReceived value)?  realtimeEventReceived,TResult Function( _FetchActiveRequested value)?  fetchActiveRequested,TResult Function( _ActiveTripResolveRequested value)?  activeTripResolveRequested,TResult Function( _TripSelected value)?  tripSelected,TResult Function( _SelectionCleared value)?  selectionCleared,TResult Function( _MarkEnRouteRequested value)?  markEnRouteRequested,TResult Function( _MarkArrivedRequested value)?  markArrivedRequested,TResult Function( _ResendArrivedNotificationRequested value)?  resendArrivedNotificationRequested,TResult Function( _StartTripRequested value)?  startTripRequested,TResult Function( _CompleteTripRequested value)?  completeTripRequested,TResult Function( _ClearCompletedSummaryRequested value)?  clearCompletedSummaryRequested,TResult Function( _DriverCancelRequested value)?  driverCancelRequested,TResult Function( _CompleteStopRequested value)?  completeStopRequested,TResult Function( _AdminSelfAssignRequested value)?  adminSelfAssignRequested,TResult Function( _AdminCancelRequested value)?  adminCancelRequested,TResult Function( _DismissPendingTripRequested value)?  dismissPendingTripRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _GetAllRequested() when getAllRequested != null:
return getAllRequested(_that);case _RealtimeEventReceived() when realtimeEventReceived != null:
return realtimeEventReceived(_that);case _FetchActiveRequested() when fetchActiveRequested != null:
return fetchActiveRequested(_that);case _ActiveTripResolveRequested() when activeTripResolveRequested != null:
return activeTripResolveRequested(_that);case _TripSelected() when tripSelected != null:
return tripSelected(_that);case _SelectionCleared() when selectionCleared != null:
return selectionCleared(_that);case _MarkEnRouteRequested() when markEnRouteRequested != null:
return markEnRouteRequested(_that);case _MarkArrivedRequested() when markArrivedRequested != null:
return markArrivedRequested(_that);case _ResendArrivedNotificationRequested() when resendArrivedNotificationRequested != null:
return resendArrivedNotificationRequested(_that);case _StartTripRequested() when startTripRequested != null:
return startTripRequested(_that);case _CompleteTripRequested() when completeTripRequested != null:
return completeTripRequested(_that);case _ClearCompletedSummaryRequested() when clearCompletedSummaryRequested != null:
return clearCompletedSummaryRequested(_that);case _DriverCancelRequested() when driverCancelRequested != null:
return driverCancelRequested(_that);case _CompleteStopRequested() when completeStopRequested != null:
return completeStopRequested(_that);case _AdminSelfAssignRequested() when adminSelfAssignRequested != null:
return adminSelfAssignRequested(_that);case _AdminCancelRequested() when adminCancelRequested != null:
return adminCancelRequested(_that);case _DismissPendingTripRequested() when dismissPendingTripRequested != null:
return dismissPendingTripRequested(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _GetAllRequested value)  getAllRequested,required TResult Function( _RealtimeEventReceived value)  realtimeEventReceived,required TResult Function( _FetchActiveRequested value)  fetchActiveRequested,required TResult Function( _ActiveTripResolveRequested value)  activeTripResolveRequested,required TResult Function( _TripSelected value)  tripSelected,required TResult Function( _SelectionCleared value)  selectionCleared,required TResult Function( _MarkEnRouteRequested value)  markEnRouteRequested,required TResult Function( _MarkArrivedRequested value)  markArrivedRequested,required TResult Function( _ResendArrivedNotificationRequested value)  resendArrivedNotificationRequested,required TResult Function( _StartTripRequested value)  startTripRequested,required TResult Function( _CompleteTripRequested value)  completeTripRequested,required TResult Function( _ClearCompletedSummaryRequested value)  clearCompletedSummaryRequested,required TResult Function( _DriverCancelRequested value)  driverCancelRequested,required TResult Function( _CompleteStopRequested value)  completeStopRequested,required TResult Function( _AdminSelfAssignRequested value)  adminSelfAssignRequested,required TResult Function( _AdminCancelRequested value)  adminCancelRequested,required TResult Function( _DismissPendingTripRequested value)  dismissPendingTripRequested,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _GetAllRequested():
return getAllRequested(_that);case _RealtimeEventReceived():
return realtimeEventReceived(_that);case _FetchActiveRequested():
return fetchActiveRequested(_that);case _ActiveTripResolveRequested():
return activeTripResolveRequested(_that);case _TripSelected():
return tripSelected(_that);case _SelectionCleared():
return selectionCleared(_that);case _MarkEnRouteRequested():
return markEnRouteRequested(_that);case _MarkArrivedRequested():
return markArrivedRequested(_that);case _ResendArrivedNotificationRequested():
return resendArrivedNotificationRequested(_that);case _StartTripRequested():
return startTripRequested(_that);case _CompleteTripRequested():
return completeTripRequested(_that);case _ClearCompletedSummaryRequested():
return clearCompletedSummaryRequested(_that);case _DriverCancelRequested():
return driverCancelRequested(_that);case _CompleteStopRequested():
return completeStopRequested(_that);case _AdminSelfAssignRequested():
return adminSelfAssignRequested(_that);case _AdminCancelRequested():
return adminCancelRequested(_that);case _DismissPendingTripRequested():
return dismissPendingTripRequested(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _GetAllRequested value)?  getAllRequested,TResult? Function( _RealtimeEventReceived value)?  realtimeEventReceived,TResult? Function( _FetchActiveRequested value)?  fetchActiveRequested,TResult? Function( _ActiveTripResolveRequested value)?  activeTripResolveRequested,TResult? Function( _TripSelected value)?  tripSelected,TResult? Function( _SelectionCleared value)?  selectionCleared,TResult? Function( _MarkEnRouteRequested value)?  markEnRouteRequested,TResult? Function( _MarkArrivedRequested value)?  markArrivedRequested,TResult? Function( _ResendArrivedNotificationRequested value)?  resendArrivedNotificationRequested,TResult? Function( _StartTripRequested value)?  startTripRequested,TResult? Function( _CompleteTripRequested value)?  completeTripRequested,TResult? Function( _ClearCompletedSummaryRequested value)?  clearCompletedSummaryRequested,TResult? Function( _DriverCancelRequested value)?  driverCancelRequested,TResult? Function( _CompleteStopRequested value)?  completeStopRequested,TResult? Function( _AdminSelfAssignRequested value)?  adminSelfAssignRequested,TResult? Function( _AdminCancelRequested value)?  adminCancelRequested,TResult? Function( _DismissPendingTripRequested value)?  dismissPendingTripRequested,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _GetAllRequested() when getAllRequested != null:
return getAllRequested(_that);case _RealtimeEventReceived() when realtimeEventReceived != null:
return realtimeEventReceived(_that);case _FetchActiveRequested() when fetchActiveRequested != null:
return fetchActiveRequested(_that);case _ActiveTripResolveRequested() when activeTripResolveRequested != null:
return activeTripResolveRequested(_that);case _TripSelected() when tripSelected != null:
return tripSelected(_that);case _SelectionCleared() when selectionCleared != null:
return selectionCleared(_that);case _MarkEnRouteRequested() when markEnRouteRequested != null:
return markEnRouteRequested(_that);case _MarkArrivedRequested() when markArrivedRequested != null:
return markArrivedRequested(_that);case _ResendArrivedNotificationRequested() when resendArrivedNotificationRequested != null:
return resendArrivedNotificationRequested(_that);case _StartTripRequested() when startTripRequested != null:
return startTripRequested(_that);case _CompleteTripRequested() when completeTripRequested != null:
return completeTripRequested(_that);case _ClearCompletedSummaryRequested() when clearCompletedSummaryRequested != null:
return clearCompletedSummaryRequested(_that);case _DriverCancelRequested() when driverCancelRequested != null:
return driverCancelRequested(_that);case _CompleteStopRequested() when completeStopRequested != null:
return completeStopRequested(_that);case _AdminSelfAssignRequested() when adminSelfAssignRequested != null:
return adminSelfAssignRequested(_that);case _AdminCancelRequested() when adminCancelRequested != null:
return adminCancelRequested(_that);case _DismissPendingTripRequested() when dismissPendingTripRequested != null:
return dismissPendingTripRequested(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  getAllRequested,TResult Function( RealtimeEvent event)?  realtimeEventReceived,TResult Function( String tripId)?  fetchActiveRequested,TResult Function()?  activeTripResolveRequested,TResult Function( String tripId)?  tripSelected,TResult Function()?  selectionCleared,TResult Function( String tripId)?  markEnRouteRequested,TResult Function( String tripId)?  markArrivedRequested,TResult Function( String tripId)?  resendArrivedNotificationRequested,TResult Function( String tripId)?  startTripRequested,TResult Function( String tripId)?  completeTripRequested,TResult Function()?  clearCompletedSummaryRequested,TResult Function( String tripId,  String reason,  String? note)?  driverCancelRequested,TResult Function( String tripId,  int sequence)?  completeStopRequested,TResult Function( String tripId)?  adminSelfAssignRequested,TResult Function( String tripId)?  adminCancelRequested,TResult Function( String tripId)?  dismissPendingTripRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _GetAllRequested() when getAllRequested != null:
return getAllRequested();case _RealtimeEventReceived() when realtimeEventReceived != null:
return realtimeEventReceived(_that.event);case _FetchActiveRequested() when fetchActiveRequested != null:
return fetchActiveRequested(_that.tripId);case _ActiveTripResolveRequested() when activeTripResolveRequested != null:
return activeTripResolveRequested();case _TripSelected() when tripSelected != null:
return tripSelected(_that.tripId);case _SelectionCleared() when selectionCleared != null:
return selectionCleared();case _MarkEnRouteRequested() when markEnRouteRequested != null:
return markEnRouteRequested(_that.tripId);case _MarkArrivedRequested() when markArrivedRequested != null:
return markArrivedRequested(_that.tripId);case _ResendArrivedNotificationRequested() when resendArrivedNotificationRequested != null:
return resendArrivedNotificationRequested(_that.tripId);case _StartTripRequested() when startTripRequested != null:
return startTripRequested(_that.tripId);case _CompleteTripRequested() when completeTripRequested != null:
return completeTripRequested(_that.tripId);case _ClearCompletedSummaryRequested() when clearCompletedSummaryRequested != null:
return clearCompletedSummaryRequested();case _DriverCancelRequested() when driverCancelRequested != null:
return driverCancelRequested(_that.tripId,_that.reason,_that.note);case _CompleteStopRequested() when completeStopRequested != null:
return completeStopRequested(_that.tripId,_that.sequence);case _AdminSelfAssignRequested() when adminSelfAssignRequested != null:
return adminSelfAssignRequested(_that.tripId);case _AdminCancelRequested() when adminCancelRequested != null:
return adminCancelRequested(_that.tripId);case _DismissPendingTripRequested() when dismissPendingTripRequested != null:
return dismissPendingTripRequested(_that.tripId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  getAllRequested,required TResult Function( RealtimeEvent event)  realtimeEventReceived,required TResult Function( String tripId)  fetchActiveRequested,required TResult Function()  activeTripResolveRequested,required TResult Function( String tripId)  tripSelected,required TResult Function()  selectionCleared,required TResult Function( String tripId)  markEnRouteRequested,required TResult Function( String tripId)  markArrivedRequested,required TResult Function( String tripId)  resendArrivedNotificationRequested,required TResult Function( String tripId)  startTripRequested,required TResult Function( String tripId)  completeTripRequested,required TResult Function()  clearCompletedSummaryRequested,required TResult Function( String tripId,  String reason,  String? note)  driverCancelRequested,required TResult Function( String tripId,  int sequence)  completeStopRequested,required TResult Function( String tripId)  adminSelfAssignRequested,required TResult Function( String tripId)  adminCancelRequested,required TResult Function( String tripId)  dismissPendingTripRequested,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _GetAllRequested():
return getAllRequested();case _RealtimeEventReceived():
return realtimeEventReceived(_that.event);case _FetchActiveRequested():
return fetchActiveRequested(_that.tripId);case _ActiveTripResolveRequested():
return activeTripResolveRequested();case _TripSelected():
return tripSelected(_that.tripId);case _SelectionCleared():
return selectionCleared();case _MarkEnRouteRequested():
return markEnRouteRequested(_that.tripId);case _MarkArrivedRequested():
return markArrivedRequested(_that.tripId);case _ResendArrivedNotificationRequested():
return resendArrivedNotificationRequested(_that.tripId);case _StartTripRequested():
return startTripRequested(_that.tripId);case _CompleteTripRequested():
return completeTripRequested(_that.tripId);case _ClearCompletedSummaryRequested():
return clearCompletedSummaryRequested();case _DriverCancelRequested():
return driverCancelRequested(_that.tripId,_that.reason,_that.note);case _CompleteStopRequested():
return completeStopRequested(_that.tripId,_that.sequence);case _AdminSelfAssignRequested():
return adminSelfAssignRequested(_that.tripId);case _AdminCancelRequested():
return adminCancelRequested(_that.tripId);case _DismissPendingTripRequested():
return dismissPendingTripRequested(_that.tripId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  getAllRequested,TResult? Function( RealtimeEvent event)?  realtimeEventReceived,TResult? Function( String tripId)?  fetchActiveRequested,TResult? Function()?  activeTripResolveRequested,TResult? Function( String tripId)?  tripSelected,TResult? Function()?  selectionCleared,TResult? Function( String tripId)?  markEnRouteRequested,TResult? Function( String tripId)?  markArrivedRequested,TResult? Function( String tripId)?  resendArrivedNotificationRequested,TResult? Function( String tripId)?  startTripRequested,TResult? Function( String tripId)?  completeTripRequested,TResult? Function()?  clearCompletedSummaryRequested,TResult? Function( String tripId,  String reason,  String? note)?  driverCancelRequested,TResult? Function( String tripId,  int sequence)?  completeStopRequested,TResult? Function( String tripId)?  adminSelfAssignRequested,TResult? Function( String tripId)?  adminCancelRequested,TResult? Function( String tripId)?  dismissPendingTripRequested,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _GetAllRequested() when getAllRequested != null:
return getAllRequested();case _RealtimeEventReceived() when realtimeEventReceived != null:
return realtimeEventReceived(_that.event);case _FetchActiveRequested() when fetchActiveRequested != null:
return fetchActiveRequested(_that.tripId);case _ActiveTripResolveRequested() when activeTripResolveRequested != null:
return activeTripResolveRequested();case _TripSelected() when tripSelected != null:
return tripSelected(_that.tripId);case _SelectionCleared() when selectionCleared != null:
return selectionCleared();case _MarkEnRouteRequested() when markEnRouteRequested != null:
return markEnRouteRequested(_that.tripId);case _MarkArrivedRequested() when markArrivedRequested != null:
return markArrivedRequested(_that.tripId);case _ResendArrivedNotificationRequested() when resendArrivedNotificationRequested != null:
return resendArrivedNotificationRequested(_that.tripId);case _StartTripRequested() when startTripRequested != null:
return startTripRequested(_that.tripId);case _CompleteTripRequested() when completeTripRequested != null:
return completeTripRequested(_that.tripId);case _ClearCompletedSummaryRequested() when clearCompletedSummaryRequested != null:
return clearCompletedSummaryRequested();case _DriverCancelRequested() when driverCancelRequested != null:
return driverCancelRequested(_that.tripId,_that.reason,_that.note);case _CompleteStopRequested() when completeStopRequested != null:
return completeStopRequested(_that.tripId,_that.sequence);case _AdminSelfAssignRequested() when adminSelfAssignRequested != null:
return adminSelfAssignRequested(_that.tripId);case _AdminCancelRequested() when adminCancelRequested != null:
return adminCancelRequested(_that.tripId);case _DismissPendingTripRequested() when dismissPendingTripRequested != null:
return dismissPendingTripRequested(_that.tripId);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements TripEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TripEvent.started()';
}


}




/// @nodoc


class _GetAllRequested implements TripEvent {
  const _GetAllRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetAllRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TripEvent.getAllRequested()';
}


}




/// @nodoc


class _RealtimeEventReceived implements TripEvent {
  const _RealtimeEventReceived(this.event);
  

 final  RealtimeEvent event;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RealtimeEventReceivedCopyWith<_RealtimeEventReceived> get copyWith => __$RealtimeEventReceivedCopyWithImpl<_RealtimeEventReceived>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RealtimeEventReceived&&(identical(other.event, event) || other.event == event));
}


@override
int get hashCode => Object.hash(runtimeType,event);

@override
String toString() {
  return 'TripEvent.realtimeEventReceived(event: $event)';
}


}

/// @nodoc
abstract mixin class _$RealtimeEventReceivedCopyWith<$Res> implements $TripEventCopyWith<$Res> {
  factory _$RealtimeEventReceivedCopyWith(_RealtimeEventReceived value, $Res Function(_RealtimeEventReceived) _then) = __$RealtimeEventReceivedCopyWithImpl;
@useResult
$Res call({
 RealtimeEvent event
});


$RealtimeEventCopyWith<$Res> get event;

}
/// @nodoc
class __$RealtimeEventReceivedCopyWithImpl<$Res>
    implements _$RealtimeEventReceivedCopyWith<$Res> {
  __$RealtimeEventReceivedCopyWithImpl(this._self, this._then);

  final _RealtimeEventReceived _self;
  final $Res Function(_RealtimeEventReceived) _then;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? event = null,}) {
  return _then(_RealtimeEventReceived(
null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as RealtimeEvent,
  ));
}

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RealtimeEventCopyWith<$Res> get event {
  
  return $RealtimeEventCopyWith<$Res>(_self.event, (value) {
    return _then(_self.copyWith(event: value));
  });
}
}

/// @nodoc


class _FetchActiveRequested implements TripEvent {
  const _FetchActiveRequested(this.tripId);
  

 final  String tripId;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchActiveRequestedCopyWith<_FetchActiveRequested> get copyWith => __$FetchActiveRequestedCopyWithImpl<_FetchActiveRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchActiveRequested&&(identical(other.tripId, tripId) || other.tripId == tripId));
}


@override
int get hashCode => Object.hash(runtimeType,tripId);

@override
String toString() {
  return 'TripEvent.fetchActiveRequested(tripId: $tripId)';
}


}

/// @nodoc
abstract mixin class _$FetchActiveRequestedCopyWith<$Res> implements $TripEventCopyWith<$Res> {
  factory _$FetchActiveRequestedCopyWith(_FetchActiveRequested value, $Res Function(_FetchActiveRequested) _then) = __$FetchActiveRequestedCopyWithImpl;
@useResult
$Res call({
 String tripId
});




}
/// @nodoc
class __$FetchActiveRequestedCopyWithImpl<$Res>
    implements _$FetchActiveRequestedCopyWith<$Res> {
  __$FetchActiveRequestedCopyWithImpl(this._self, this._then);

  final _FetchActiveRequested _self;
  final $Res Function(_FetchActiveRequested) _then;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tripId = null,}) {
  return _then(_FetchActiveRequested(
null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ActiveTripResolveRequested implements TripEvent {
  const _ActiveTripResolveRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActiveTripResolveRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TripEvent.activeTripResolveRequested()';
}


}




/// @nodoc


class _TripSelected implements TripEvent {
  const _TripSelected(this.tripId);
  

 final  String tripId;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripSelectedCopyWith<_TripSelected> get copyWith => __$TripSelectedCopyWithImpl<_TripSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripSelected&&(identical(other.tripId, tripId) || other.tripId == tripId));
}


@override
int get hashCode => Object.hash(runtimeType,tripId);

@override
String toString() {
  return 'TripEvent.tripSelected(tripId: $tripId)';
}


}

/// @nodoc
abstract mixin class _$TripSelectedCopyWith<$Res> implements $TripEventCopyWith<$Res> {
  factory _$TripSelectedCopyWith(_TripSelected value, $Res Function(_TripSelected) _then) = __$TripSelectedCopyWithImpl;
@useResult
$Res call({
 String tripId
});




}
/// @nodoc
class __$TripSelectedCopyWithImpl<$Res>
    implements _$TripSelectedCopyWith<$Res> {
  __$TripSelectedCopyWithImpl(this._self, this._then);

  final _TripSelected _self;
  final $Res Function(_TripSelected) _then;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tripId = null,}) {
  return _then(_TripSelected(
null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SelectionCleared implements TripEvent {
  const _SelectionCleared();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectionCleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TripEvent.selectionCleared()';
}


}




/// @nodoc


class _MarkEnRouteRequested implements TripEvent {
  const _MarkEnRouteRequested(this.tripId);
  

 final  String tripId;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarkEnRouteRequestedCopyWith<_MarkEnRouteRequested> get copyWith => __$MarkEnRouteRequestedCopyWithImpl<_MarkEnRouteRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarkEnRouteRequested&&(identical(other.tripId, tripId) || other.tripId == tripId));
}


@override
int get hashCode => Object.hash(runtimeType,tripId);

@override
String toString() {
  return 'TripEvent.markEnRouteRequested(tripId: $tripId)';
}


}

/// @nodoc
abstract mixin class _$MarkEnRouteRequestedCopyWith<$Res> implements $TripEventCopyWith<$Res> {
  factory _$MarkEnRouteRequestedCopyWith(_MarkEnRouteRequested value, $Res Function(_MarkEnRouteRequested) _then) = __$MarkEnRouteRequestedCopyWithImpl;
@useResult
$Res call({
 String tripId
});




}
/// @nodoc
class __$MarkEnRouteRequestedCopyWithImpl<$Res>
    implements _$MarkEnRouteRequestedCopyWith<$Res> {
  __$MarkEnRouteRequestedCopyWithImpl(this._self, this._then);

  final _MarkEnRouteRequested _self;
  final $Res Function(_MarkEnRouteRequested) _then;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tripId = null,}) {
  return _then(_MarkEnRouteRequested(
null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _MarkArrivedRequested implements TripEvent {
  const _MarkArrivedRequested(this.tripId);
  

 final  String tripId;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarkArrivedRequestedCopyWith<_MarkArrivedRequested> get copyWith => __$MarkArrivedRequestedCopyWithImpl<_MarkArrivedRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarkArrivedRequested&&(identical(other.tripId, tripId) || other.tripId == tripId));
}


@override
int get hashCode => Object.hash(runtimeType,tripId);

@override
String toString() {
  return 'TripEvent.markArrivedRequested(tripId: $tripId)';
}


}

/// @nodoc
abstract mixin class _$MarkArrivedRequestedCopyWith<$Res> implements $TripEventCopyWith<$Res> {
  factory _$MarkArrivedRequestedCopyWith(_MarkArrivedRequested value, $Res Function(_MarkArrivedRequested) _then) = __$MarkArrivedRequestedCopyWithImpl;
@useResult
$Res call({
 String tripId
});




}
/// @nodoc
class __$MarkArrivedRequestedCopyWithImpl<$Res>
    implements _$MarkArrivedRequestedCopyWith<$Res> {
  __$MarkArrivedRequestedCopyWithImpl(this._self, this._then);

  final _MarkArrivedRequested _self;
  final $Res Function(_MarkArrivedRequested) _then;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tripId = null,}) {
  return _then(_MarkArrivedRequested(
null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ResendArrivedNotificationRequested implements TripEvent {
  const _ResendArrivedNotificationRequested(this.tripId);
  

 final  String tripId;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResendArrivedNotificationRequestedCopyWith<_ResendArrivedNotificationRequested> get copyWith => __$ResendArrivedNotificationRequestedCopyWithImpl<_ResendArrivedNotificationRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResendArrivedNotificationRequested&&(identical(other.tripId, tripId) || other.tripId == tripId));
}


@override
int get hashCode => Object.hash(runtimeType,tripId);

@override
String toString() {
  return 'TripEvent.resendArrivedNotificationRequested(tripId: $tripId)';
}


}

/// @nodoc
abstract mixin class _$ResendArrivedNotificationRequestedCopyWith<$Res> implements $TripEventCopyWith<$Res> {
  factory _$ResendArrivedNotificationRequestedCopyWith(_ResendArrivedNotificationRequested value, $Res Function(_ResendArrivedNotificationRequested) _then) = __$ResendArrivedNotificationRequestedCopyWithImpl;
@useResult
$Res call({
 String tripId
});




}
/// @nodoc
class __$ResendArrivedNotificationRequestedCopyWithImpl<$Res>
    implements _$ResendArrivedNotificationRequestedCopyWith<$Res> {
  __$ResendArrivedNotificationRequestedCopyWithImpl(this._self, this._then);

  final _ResendArrivedNotificationRequested _self;
  final $Res Function(_ResendArrivedNotificationRequested) _then;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tripId = null,}) {
  return _then(_ResendArrivedNotificationRequested(
null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _StartTripRequested implements TripEvent {
  const _StartTripRequested(this.tripId);
  

 final  String tripId;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StartTripRequestedCopyWith<_StartTripRequested> get copyWith => __$StartTripRequestedCopyWithImpl<_StartTripRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StartTripRequested&&(identical(other.tripId, tripId) || other.tripId == tripId));
}


@override
int get hashCode => Object.hash(runtimeType,tripId);

@override
String toString() {
  return 'TripEvent.startTripRequested(tripId: $tripId)';
}


}

/// @nodoc
abstract mixin class _$StartTripRequestedCopyWith<$Res> implements $TripEventCopyWith<$Res> {
  factory _$StartTripRequestedCopyWith(_StartTripRequested value, $Res Function(_StartTripRequested) _then) = __$StartTripRequestedCopyWithImpl;
@useResult
$Res call({
 String tripId
});




}
/// @nodoc
class __$StartTripRequestedCopyWithImpl<$Res>
    implements _$StartTripRequestedCopyWith<$Res> {
  __$StartTripRequestedCopyWithImpl(this._self, this._then);

  final _StartTripRequested _self;
  final $Res Function(_StartTripRequested) _then;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tripId = null,}) {
  return _then(_StartTripRequested(
null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _CompleteTripRequested implements TripEvent {
  const _CompleteTripRequested(this.tripId);
  

 final  String tripId;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompleteTripRequestedCopyWith<_CompleteTripRequested> get copyWith => __$CompleteTripRequestedCopyWithImpl<_CompleteTripRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompleteTripRequested&&(identical(other.tripId, tripId) || other.tripId == tripId));
}


@override
int get hashCode => Object.hash(runtimeType,tripId);

@override
String toString() {
  return 'TripEvent.completeTripRequested(tripId: $tripId)';
}


}

/// @nodoc
abstract mixin class _$CompleteTripRequestedCopyWith<$Res> implements $TripEventCopyWith<$Res> {
  factory _$CompleteTripRequestedCopyWith(_CompleteTripRequested value, $Res Function(_CompleteTripRequested) _then) = __$CompleteTripRequestedCopyWithImpl;
@useResult
$Res call({
 String tripId
});




}
/// @nodoc
class __$CompleteTripRequestedCopyWithImpl<$Res>
    implements _$CompleteTripRequestedCopyWith<$Res> {
  __$CompleteTripRequestedCopyWithImpl(this._self, this._then);

  final _CompleteTripRequested _self;
  final $Res Function(_CompleteTripRequested) _then;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tripId = null,}) {
  return _then(_CompleteTripRequested(
null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ClearCompletedSummaryRequested implements TripEvent {
  const _ClearCompletedSummaryRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearCompletedSummaryRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TripEvent.clearCompletedSummaryRequested()';
}


}




/// @nodoc


class _DriverCancelRequested implements TripEvent {
  const _DriverCancelRequested({required this.tripId, required this.reason, this.note});
  

 final  String tripId;
 final  String reason;
 final  String? note;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriverCancelRequestedCopyWith<_DriverCancelRequested> get copyWith => __$DriverCancelRequestedCopyWithImpl<_DriverCancelRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriverCancelRequested&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,tripId,reason,note);

@override
String toString() {
  return 'TripEvent.driverCancelRequested(tripId: $tripId, reason: $reason, note: $note)';
}


}

/// @nodoc
abstract mixin class _$DriverCancelRequestedCopyWith<$Res> implements $TripEventCopyWith<$Res> {
  factory _$DriverCancelRequestedCopyWith(_DriverCancelRequested value, $Res Function(_DriverCancelRequested) _then) = __$DriverCancelRequestedCopyWithImpl;
@useResult
$Res call({
 String tripId, String reason, String? note
});




}
/// @nodoc
class __$DriverCancelRequestedCopyWithImpl<$Res>
    implements _$DriverCancelRequestedCopyWith<$Res> {
  __$DriverCancelRequestedCopyWithImpl(this._self, this._then);

  final _DriverCancelRequested _self;
  final $Res Function(_DriverCancelRequested) _then;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? reason = null,Object? note = freezed,}) {
  return _then(_DriverCancelRequested(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _CompleteStopRequested implements TripEvent {
  const _CompleteStopRequested({required this.tripId, required this.sequence});
  

 final  String tripId;
 final  int sequence;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompleteStopRequestedCopyWith<_CompleteStopRequested> get copyWith => __$CompleteStopRequestedCopyWithImpl<_CompleteStopRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompleteStopRequested&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.sequence, sequence) || other.sequence == sequence));
}


@override
int get hashCode => Object.hash(runtimeType,tripId,sequence);

@override
String toString() {
  return 'TripEvent.completeStopRequested(tripId: $tripId, sequence: $sequence)';
}


}

/// @nodoc
abstract mixin class _$CompleteStopRequestedCopyWith<$Res> implements $TripEventCopyWith<$Res> {
  factory _$CompleteStopRequestedCopyWith(_CompleteStopRequested value, $Res Function(_CompleteStopRequested) _then) = __$CompleteStopRequestedCopyWithImpl;
@useResult
$Res call({
 String tripId, int sequence
});




}
/// @nodoc
class __$CompleteStopRequestedCopyWithImpl<$Res>
    implements _$CompleteStopRequestedCopyWith<$Res> {
  __$CompleteStopRequestedCopyWithImpl(this._self, this._then);

  final _CompleteStopRequested _self;
  final $Res Function(_CompleteStopRequested) _then;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? sequence = null,}) {
  return _then(_CompleteStopRequested(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,sequence: null == sequence ? _self.sequence : sequence // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _AdminSelfAssignRequested implements TripEvent {
  const _AdminSelfAssignRequested(this.tripId);
  

 final  String tripId;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminSelfAssignRequestedCopyWith<_AdminSelfAssignRequested> get copyWith => __$AdminSelfAssignRequestedCopyWithImpl<_AdminSelfAssignRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminSelfAssignRequested&&(identical(other.tripId, tripId) || other.tripId == tripId));
}


@override
int get hashCode => Object.hash(runtimeType,tripId);

@override
String toString() {
  return 'TripEvent.adminSelfAssignRequested(tripId: $tripId)';
}


}

/// @nodoc
abstract mixin class _$AdminSelfAssignRequestedCopyWith<$Res> implements $TripEventCopyWith<$Res> {
  factory _$AdminSelfAssignRequestedCopyWith(_AdminSelfAssignRequested value, $Res Function(_AdminSelfAssignRequested) _then) = __$AdminSelfAssignRequestedCopyWithImpl;
@useResult
$Res call({
 String tripId
});




}
/// @nodoc
class __$AdminSelfAssignRequestedCopyWithImpl<$Res>
    implements _$AdminSelfAssignRequestedCopyWith<$Res> {
  __$AdminSelfAssignRequestedCopyWithImpl(this._self, this._then);

  final _AdminSelfAssignRequested _self;
  final $Res Function(_AdminSelfAssignRequested) _then;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tripId = null,}) {
  return _then(_AdminSelfAssignRequested(
null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _AdminCancelRequested implements TripEvent {
  const _AdminCancelRequested(this.tripId);
  

 final  String tripId;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminCancelRequestedCopyWith<_AdminCancelRequested> get copyWith => __$AdminCancelRequestedCopyWithImpl<_AdminCancelRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminCancelRequested&&(identical(other.tripId, tripId) || other.tripId == tripId));
}


@override
int get hashCode => Object.hash(runtimeType,tripId);

@override
String toString() {
  return 'TripEvent.adminCancelRequested(tripId: $tripId)';
}


}

/// @nodoc
abstract mixin class _$AdminCancelRequestedCopyWith<$Res> implements $TripEventCopyWith<$Res> {
  factory _$AdminCancelRequestedCopyWith(_AdminCancelRequested value, $Res Function(_AdminCancelRequested) _then) = __$AdminCancelRequestedCopyWithImpl;
@useResult
$Res call({
 String tripId
});




}
/// @nodoc
class __$AdminCancelRequestedCopyWithImpl<$Res>
    implements _$AdminCancelRequestedCopyWith<$Res> {
  __$AdminCancelRequestedCopyWithImpl(this._self, this._then);

  final _AdminCancelRequested _self;
  final $Res Function(_AdminCancelRequested) _then;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tripId = null,}) {
  return _then(_AdminCancelRequested(
null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _DismissPendingTripRequested implements TripEvent {
  const _DismissPendingTripRequested(this.tripId);
  

 final  String tripId;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DismissPendingTripRequestedCopyWith<_DismissPendingTripRequested> get copyWith => __$DismissPendingTripRequestedCopyWithImpl<_DismissPendingTripRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DismissPendingTripRequested&&(identical(other.tripId, tripId) || other.tripId == tripId));
}


@override
int get hashCode => Object.hash(runtimeType,tripId);

@override
String toString() {
  return 'TripEvent.dismissPendingTripRequested(tripId: $tripId)';
}


}

/// @nodoc
abstract mixin class _$DismissPendingTripRequestedCopyWith<$Res> implements $TripEventCopyWith<$Res> {
  factory _$DismissPendingTripRequestedCopyWith(_DismissPendingTripRequested value, $Res Function(_DismissPendingTripRequested) _then) = __$DismissPendingTripRequestedCopyWithImpl;
@useResult
$Res call({
 String tripId
});




}
/// @nodoc
class __$DismissPendingTripRequestedCopyWithImpl<$Res>
    implements _$DismissPendingTripRequestedCopyWith<$Res> {
  __$DismissPendingTripRequestedCopyWithImpl(this._self, this._then);

  final _DismissPendingTripRequested _self;
  final $Res Function(_DismissPendingTripRequested) _then;

/// Create a copy of TripEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tripId = null,}) {
  return _then(_DismissPendingTripRequested(
null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$TripState {

 BlocStatus<List<TripEntity>> get getAllState; BlocStatus<TripEntity> get activeTripState; BlocStatus<void> get markEnRouteState; BlocStatus<void> get markArrivedState; BlocStatus<void> get resendArrivedNotificationState; DateTime? get lastArrivedResendAt; BlocStatus<void> get startTripState; BlocStatus<void> get completeTripState; BlocStatus<void> get driverCancelState; BlocStatus<void> get completeStopState; TripEntity? get activeTrip; TripEntity? get completedTrip; List<TripEntity> get pendingTrips; DateTime? get arrivedAt; Set<int> get completedStops; BlocStatus<void> get adminSelfAssignState; BlocStatus<void> get adminCancelState;
/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripStateCopyWith<TripState> get copyWith => _$TripStateCopyWithImpl<TripState>(this as TripState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripState&&(identical(other.getAllState, getAllState) || other.getAllState == getAllState)&&(identical(other.activeTripState, activeTripState) || other.activeTripState == activeTripState)&&(identical(other.markEnRouteState, markEnRouteState) || other.markEnRouteState == markEnRouteState)&&(identical(other.markArrivedState, markArrivedState) || other.markArrivedState == markArrivedState)&&(identical(other.resendArrivedNotificationState, resendArrivedNotificationState) || other.resendArrivedNotificationState == resendArrivedNotificationState)&&(identical(other.lastArrivedResendAt, lastArrivedResendAt) || other.lastArrivedResendAt == lastArrivedResendAt)&&(identical(other.startTripState, startTripState) || other.startTripState == startTripState)&&(identical(other.completeTripState, completeTripState) || other.completeTripState == completeTripState)&&(identical(other.driverCancelState, driverCancelState) || other.driverCancelState == driverCancelState)&&(identical(other.completeStopState, completeStopState) || other.completeStopState == completeStopState)&&(identical(other.activeTrip, activeTrip) || other.activeTrip == activeTrip)&&(identical(other.completedTrip, completedTrip) || other.completedTrip == completedTrip)&&const DeepCollectionEquality().equals(other.pendingTrips, pendingTrips)&&(identical(other.arrivedAt, arrivedAt) || other.arrivedAt == arrivedAt)&&const DeepCollectionEquality().equals(other.completedStops, completedStops)&&(identical(other.adminSelfAssignState, adminSelfAssignState) || other.adminSelfAssignState == adminSelfAssignState)&&(identical(other.adminCancelState, adminCancelState) || other.adminCancelState == adminCancelState));
}


@override
int get hashCode => Object.hash(runtimeType,getAllState,activeTripState,markEnRouteState,markArrivedState,resendArrivedNotificationState,lastArrivedResendAt,startTripState,completeTripState,driverCancelState,completeStopState,activeTrip,completedTrip,const DeepCollectionEquality().hash(pendingTrips),arrivedAt,const DeepCollectionEquality().hash(completedStops),adminSelfAssignState,adminCancelState);

@override
String toString() {
  return 'TripState(getAllState: $getAllState, activeTripState: $activeTripState, markEnRouteState: $markEnRouteState, markArrivedState: $markArrivedState, resendArrivedNotificationState: $resendArrivedNotificationState, lastArrivedResendAt: $lastArrivedResendAt, startTripState: $startTripState, completeTripState: $completeTripState, driverCancelState: $driverCancelState, completeStopState: $completeStopState, activeTrip: $activeTrip, completedTrip: $completedTrip, pendingTrips: $pendingTrips, arrivedAt: $arrivedAt, completedStops: $completedStops, adminSelfAssignState: $adminSelfAssignState, adminCancelState: $adminCancelState)';
}


}

/// @nodoc
abstract mixin class $TripStateCopyWith<$Res>  {
  factory $TripStateCopyWith(TripState value, $Res Function(TripState) _then) = _$TripStateCopyWithImpl;
@useResult
$Res call({
 BlocStatus<List<TripEntity>> getAllState, BlocStatus<TripEntity> activeTripState, BlocStatus<void> markEnRouteState, BlocStatus<void> markArrivedState, BlocStatus<void> resendArrivedNotificationState, DateTime? lastArrivedResendAt, BlocStatus<void> startTripState, BlocStatus<void> completeTripState, BlocStatus<void> driverCancelState, BlocStatus<void> completeStopState, TripEntity? activeTrip, TripEntity? completedTrip, List<TripEntity> pendingTrips, DateTime? arrivedAt, Set<int> completedStops, BlocStatus<void> adminSelfAssignState, BlocStatus<void> adminCancelState
});


$BlocStatusCopyWith<List<TripEntity>, $Res> get getAllState;$BlocStatusCopyWith<TripEntity, $Res> get activeTripState;$BlocStatusCopyWith<void, $Res> get markEnRouteState;$BlocStatusCopyWith<void, $Res> get markArrivedState;$BlocStatusCopyWith<void, $Res> get resendArrivedNotificationState;$BlocStatusCopyWith<void, $Res> get startTripState;$BlocStatusCopyWith<void, $Res> get completeTripState;$BlocStatusCopyWith<void, $Res> get driverCancelState;$BlocStatusCopyWith<void, $Res> get completeStopState;$BlocStatusCopyWith<void, $Res> get adminSelfAssignState;$BlocStatusCopyWith<void, $Res> get adminCancelState;

}
/// @nodoc
class _$TripStateCopyWithImpl<$Res>
    implements $TripStateCopyWith<$Res> {
  _$TripStateCopyWithImpl(this._self, this._then);

  final TripState _self;
  final $Res Function(TripState) _then;

/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? getAllState = null,Object? activeTripState = null,Object? markEnRouteState = null,Object? markArrivedState = null,Object? resendArrivedNotificationState = null,Object? lastArrivedResendAt = freezed,Object? startTripState = null,Object? completeTripState = null,Object? driverCancelState = null,Object? completeStopState = null,Object? activeTrip = freezed,Object? completedTrip = freezed,Object? pendingTrips = null,Object? arrivedAt = freezed,Object? completedStops = null,Object? adminSelfAssignState = null,Object? adminCancelState = null,}) {
  return _then(_self.copyWith(
getAllState: null == getAllState ? _self.getAllState : getAllState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<TripEntity>>,activeTripState: null == activeTripState ? _self.activeTripState : activeTripState // ignore: cast_nullable_to_non_nullable
as BlocStatus<TripEntity>,markEnRouteState: null == markEnRouteState ? _self.markEnRouteState : markEnRouteState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,markArrivedState: null == markArrivedState ? _self.markArrivedState : markArrivedState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,resendArrivedNotificationState: null == resendArrivedNotificationState ? _self.resendArrivedNotificationState : resendArrivedNotificationState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,lastArrivedResendAt: freezed == lastArrivedResendAt ? _self.lastArrivedResendAt : lastArrivedResendAt // ignore: cast_nullable_to_non_nullable
as DateTime?,startTripState: null == startTripState ? _self.startTripState : startTripState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,completeTripState: null == completeTripState ? _self.completeTripState : completeTripState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,driverCancelState: null == driverCancelState ? _self.driverCancelState : driverCancelState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,completeStopState: null == completeStopState ? _self.completeStopState : completeStopState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,activeTrip: freezed == activeTrip ? _self.activeTrip : activeTrip // ignore: cast_nullable_to_non_nullable
as TripEntity?,completedTrip: freezed == completedTrip ? _self.completedTrip : completedTrip // ignore: cast_nullable_to_non_nullable
as TripEntity?,pendingTrips: null == pendingTrips ? _self.pendingTrips : pendingTrips // ignore: cast_nullable_to_non_nullable
as List<TripEntity>,arrivedAt: freezed == arrivedAt ? _self.arrivedAt : arrivedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedStops: null == completedStops ? _self.completedStops : completedStops // ignore: cast_nullable_to_non_nullable
as Set<int>,adminSelfAssignState: null == adminSelfAssignState ? _self.adminSelfAssignState : adminSelfAssignState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,adminCancelState: null == adminCancelState ? _self.adminCancelState : adminCancelState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,
  ));
}
/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<TripEntity>, $Res> get getAllState {
  
  return $BlocStatusCopyWith<List<TripEntity>, $Res>(_self.getAllState, (value) {
    return _then(_self.copyWith(getAllState: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<TripEntity, $Res> get activeTripState {
  
  return $BlocStatusCopyWith<TripEntity, $Res>(_self.activeTripState, (value) {
    return _then(_self.copyWith(activeTripState: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get markEnRouteState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.markEnRouteState, (value) {
    return _then(_self.copyWith(markEnRouteState: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get markArrivedState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.markArrivedState, (value) {
    return _then(_self.copyWith(markArrivedState: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get resendArrivedNotificationState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.resendArrivedNotificationState, (value) {
    return _then(_self.copyWith(resendArrivedNotificationState: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get startTripState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.startTripState, (value) {
    return _then(_self.copyWith(startTripState: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get completeTripState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.completeTripState, (value) {
    return _then(_self.copyWith(completeTripState: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get driverCancelState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.driverCancelState, (value) {
    return _then(_self.copyWith(driverCancelState: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get completeStopState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.completeStopState, (value) {
    return _then(_self.copyWith(completeStopState: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get adminSelfAssignState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.adminSelfAssignState, (value) {
    return _then(_self.copyWith(adminSelfAssignState: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get adminCancelState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.adminCancelState, (value) {
    return _then(_self.copyWith(adminCancelState: value));
  });
}
}


/// Adds pattern-matching-related methods to [TripState].
extension TripStatePatterns on TripState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripState value)  $default,){
final _that = this;
switch (_that) {
case _TripState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripState value)?  $default,){
final _that = this;
switch (_that) {
case _TripState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BlocStatus<List<TripEntity>> getAllState,  BlocStatus<TripEntity> activeTripState,  BlocStatus<void> markEnRouteState,  BlocStatus<void> markArrivedState,  BlocStatus<void> resendArrivedNotificationState,  DateTime? lastArrivedResendAt,  BlocStatus<void> startTripState,  BlocStatus<void> completeTripState,  BlocStatus<void> driverCancelState,  BlocStatus<void> completeStopState,  TripEntity? activeTrip,  TripEntity? completedTrip,  List<TripEntity> pendingTrips,  DateTime? arrivedAt,  Set<int> completedStops,  BlocStatus<void> adminSelfAssignState,  BlocStatus<void> adminCancelState)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripState() when $default != null:
return $default(_that.getAllState,_that.activeTripState,_that.markEnRouteState,_that.markArrivedState,_that.resendArrivedNotificationState,_that.lastArrivedResendAt,_that.startTripState,_that.completeTripState,_that.driverCancelState,_that.completeStopState,_that.activeTrip,_that.completedTrip,_that.pendingTrips,_that.arrivedAt,_that.completedStops,_that.adminSelfAssignState,_that.adminCancelState);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BlocStatus<List<TripEntity>> getAllState,  BlocStatus<TripEntity> activeTripState,  BlocStatus<void> markEnRouteState,  BlocStatus<void> markArrivedState,  BlocStatus<void> resendArrivedNotificationState,  DateTime? lastArrivedResendAt,  BlocStatus<void> startTripState,  BlocStatus<void> completeTripState,  BlocStatus<void> driverCancelState,  BlocStatus<void> completeStopState,  TripEntity? activeTrip,  TripEntity? completedTrip,  List<TripEntity> pendingTrips,  DateTime? arrivedAt,  Set<int> completedStops,  BlocStatus<void> adminSelfAssignState,  BlocStatus<void> adminCancelState)  $default,) {final _that = this;
switch (_that) {
case _TripState():
return $default(_that.getAllState,_that.activeTripState,_that.markEnRouteState,_that.markArrivedState,_that.resendArrivedNotificationState,_that.lastArrivedResendAt,_that.startTripState,_that.completeTripState,_that.driverCancelState,_that.completeStopState,_that.activeTrip,_that.completedTrip,_that.pendingTrips,_that.arrivedAt,_that.completedStops,_that.adminSelfAssignState,_that.adminCancelState);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BlocStatus<List<TripEntity>> getAllState,  BlocStatus<TripEntity> activeTripState,  BlocStatus<void> markEnRouteState,  BlocStatus<void> markArrivedState,  BlocStatus<void> resendArrivedNotificationState,  DateTime? lastArrivedResendAt,  BlocStatus<void> startTripState,  BlocStatus<void> completeTripState,  BlocStatus<void> driverCancelState,  BlocStatus<void> completeStopState,  TripEntity? activeTrip,  TripEntity? completedTrip,  List<TripEntity> pendingTrips,  DateTime? arrivedAt,  Set<int> completedStops,  BlocStatus<void> adminSelfAssignState,  BlocStatus<void> adminCancelState)?  $default,) {final _that = this;
switch (_that) {
case _TripState() when $default != null:
return $default(_that.getAllState,_that.activeTripState,_that.markEnRouteState,_that.markArrivedState,_that.resendArrivedNotificationState,_that.lastArrivedResendAt,_that.startTripState,_that.completeTripState,_that.driverCancelState,_that.completeStopState,_that.activeTrip,_that.completedTrip,_that.pendingTrips,_that.arrivedAt,_that.completedStops,_that.adminSelfAssignState,_that.adminCancelState);case _:
  return null;

}
}

}

/// @nodoc


class _TripState implements TripState {
  const _TripState({this.getAllState = const BlocStatus<List<TripEntity>>.initial(), this.activeTripState = const BlocStatus<TripEntity>.initial(), this.markEnRouteState = const BlocStatus<void>.initial(), this.markArrivedState = const BlocStatus<void>.initial(), this.resendArrivedNotificationState = const BlocStatus<void>.initial(), this.lastArrivedResendAt, this.startTripState = const BlocStatus<void>.initial(), this.completeTripState = const BlocStatus<void>.initial(), this.driverCancelState = const BlocStatus<void>.initial(), this.completeStopState = const BlocStatus<void>.initial(), this.activeTrip, this.completedTrip, final  List<TripEntity> pendingTrips = const <TripEntity>[], this.arrivedAt, final  Set<int> completedStops = const <int>{}, this.adminSelfAssignState = const BlocStatus<void>.initial(), this.adminCancelState = const BlocStatus<void>.initial()}): _pendingTrips = pendingTrips,_completedStops = completedStops;
  

@override@JsonKey() final  BlocStatus<List<TripEntity>> getAllState;
@override@JsonKey() final  BlocStatus<TripEntity> activeTripState;
@override@JsonKey() final  BlocStatus<void> markEnRouteState;
@override@JsonKey() final  BlocStatus<void> markArrivedState;
@override@JsonKey() final  BlocStatus<void> resendArrivedNotificationState;
@override final  DateTime? lastArrivedResendAt;
@override@JsonKey() final  BlocStatus<void> startTripState;
@override@JsonKey() final  BlocStatus<void> completeTripState;
@override@JsonKey() final  BlocStatus<void> driverCancelState;
@override@JsonKey() final  BlocStatus<void> completeStopState;
@override final  TripEntity? activeTrip;
@override final  TripEntity? completedTrip;
 final  List<TripEntity> _pendingTrips;
@override@JsonKey() List<TripEntity> get pendingTrips {
  if (_pendingTrips is EqualUnmodifiableListView) return _pendingTrips;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pendingTrips);
}

@override final  DateTime? arrivedAt;
 final  Set<int> _completedStops;
@override@JsonKey() Set<int> get completedStops {
  if (_completedStops is EqualUnmodifiableSetView) return _completedStops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_completedStops);
}

@override@JsonKey() final  BlocStatus<void> adminSelfAssignState;
@override@JsonKey() final  BlocStatus<void> adminCancelState;

/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripStateCopyWith<_TripState> get copyWith => __$TripStateCopyWithImpl<_TripState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripState&&(identical(other.getAllState, getAllState) || other.getAllState == getAllState)&&(identical(other.activeTripState, activeTripState) || other.activeTripState == activeTripState)&&(identical(other.markEnRouteState, markEnRouteState) || other.markEnRouteState == markEnRouteState)&&(identical(other.markArrivedState, markArrivedState) || other.markArrivedState == markArrivedState)&&(identical(other.resendArrivedNotificationState, resendArrivedNotificationState) || other.resendArrivedNotificationState == resendArrivedNotificationState)&&(identical(other.lastArrivedResendAt, lastArrivedResendAt) || other.lastArrivedResendAt == lastArrivedResendAt)&&(identical(other.startTripState, startTripState) || other.startTripState == startTripState)&&(identical(other.completeTripState, completeTripState) || other.completeTripState == completeTripState)&&(identical(other.driverCancelState, driverCancelState) || other.driverCancelState == driverCancelState)&&(identical(other.completeStopState, completeStopState) || other.completeStopState == completeStopState)&&(identical(other.activeTrip, activeTrip) || other.activeTrip == activeTrip)&&(identical(other.completedTrip, completedTrip) || other.completedTrip == completedTrip)&&const DeepCollectionEquality().equals(other._pendingTrips, _pendingTrips)&&(identical(other.arrivedAt, arrivedAt) || other.arrivedAt == arrivedAt)&&const DeepCollectionEquality().equals(other._completedStops, _completedStops)&&(identical(other.adminSelfAssignState, adminSelfAssignState) || other.adminSelfAssignState == adminSelfAssignState)&&(identical(other.adminCancelState, adminCancelState) || other.adminCancelState == adminCancelState));
}


@override
int get hashCode => Object.hash(runtimeType,getAllState,activeTripState,markEnRouteState,markArrivedState,resendArrivedNotificationState,lastArrivedResendAt,startTripState,completeTripState,driverCancelState,completeStopState,activeTrip,completedTrip,const DeepCollectionEquality().hash(_pendingTrips),arrivedAt,const DeepCollectionEquality().hash(_completedStops),adminSelfAssignState,adminCancelState);

@override
String toString() {
  return 'TripState(getAllState: $getAllState, activeTripState: $activeTripState, markEnRouteState: $markEnRouteState, markArrivedState: $markArrivedState, resendArrivedNotificationState: $resendArrivedNotificationState, lastArrivedResendAt: $lastArrivedResendAt, startTripState: $startTripState, completeTripState: $completeTripState, driverCancelState: $driverCancelState, completeStopState: $completeStopState, activeTrip: $activeTrip, completedTrip: $completedTrip, pendingTrips: $pendingTrips, arrivedAt: $arrivedAt, completedStops: $completedStops, adminSelfAssignState: $adminSelfAssignState, adminCancelState: $adminCancelState)';
}


}

/// @nodoc
abstract mixin class _$TripStateCopyWith<$Res> implements $TripStateCopyWith<$Res> {
  factory _$TripStateCopyWith(_TripState value, $Res Function(_TripState) _then) = __$TripStateCopyWithImpl;
@override @useResult
$Res call({
 BlocStatus<List<TripEntity>> getAllState, BlocStatus<TripEntity> activeTripState, BlocStatus<void> markEnRouteState, BlocStatus<void> markArrivedState, BlocStatus<void> resendArrivedNotificationState, DateTime? lastArrivedResendAt, BlocStatus<void> startTripState, BlocStatus<void> completeTripState, BlocStatus<void> driverCancelState, BlocStatus<void> completeStopState, TripEntity? activeTrip, TripEntity? completedTrip, List<TripEntity> pendingTrips, DateTime? arrivedAt, Set<int> completedStops, BlocStatus<void> adminSelfAssignState, BlocStatus<void> adminCancelState
});


@override $BlocStatusCopyWith<List<TripEntity>, $Res> get getAllState;@override $BlocStatusCopyWith<TripEntity, $Res> get activeTripState;@override $BlocStatusCopyWith<void, $Res> get markEnRouteState;@override $BlocStatusCopyWith<void, $Res> get markArrivedState;@override $BlocStatusCopyWith<void, $Res> get resendArrivedNotificationState;@override $BlocStatusCopyWith<void, $Res> get startTripState;@override $BlocStatusCopyWith<void, $Res> get completeTripState;@override $BlocStatusCopyWith<void, $Res> get driverCancelState;@override $BlocStatusCopyWith<void, $Res> get completeStopState;@override $BlocStatusCopyWith<void, $Res> get adminSelfAssignState;@override $BlocStatusCopyWith<void, $Res> get adminCancelState;

}
/// @nodoc
class __$TripStateCopyWithImpl<$Res>
    implements _$TripStateCopyWith<$Res> {
  __$TripStateCopyWithImpl(this._self, this._then);

  final _TripState _self;
  final $Res Function(_TripState) _then;

/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? getAllState = null,Object? activeTripState = null,Object? markEnRouteState = null,Object? markArrivedState = null,Object? resendArrivedNotificationState = null,Object? lastArrivedResendAt = freezed,Object? startTripState = null,Object? completeTripState = null,Object? driverCancelState = null,Object? completeStopState = null,Object? activeTrip = freezed,Object? completedTrip = freezed,Object? pendingTrips = null,Object? arrivedAt = freezed,Object? completedStops = null,Object? adminSelfAssignState = null,Object? adminCancelState = null,}) {
  return _then(_TripState(
getAllState: null == getAllState ? _self.getAllState : getAllState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<TripEntity>>,activeTripState: null == activeTripState ? _self.activeTripState : activeTripState // ignore: cast_nullable_to_non_nullable
as BlocStatus<TripEntity>,markEnRouteState: null == markEnRouteState ? _self.markEnRouteState : markEnRouteState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,markArrivedState: null == markArrivedState ? _self.markArrivedState : markArrivedState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,resendArrivedNotificationState: null == resendArrivedNotificationState ? _self.resendArrivedNotificationState : resendArrivedNotificationState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,lastArrivedResendAt: freezed == lastArrivedResendAt ? _self.lastArrivedResendAt : lastArrivedResendAt // ignore: cast_nullable_to_non_nullable
as DateTime?,startTripState: null == startTripState ? _self.startTripState : startTripState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,completeTripState: null == completeTripState ? _self.completeTripState : completeTripState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,driverCancelState: null == driverCancelState ? _self.driverCancelState : driverCancelState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,completeStopState: null == completeStopState ? _self.completeStopState : completeStopState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,activeTrip: freezed == activeTrip ? _self.activeTrip : activeTrip // ignore: cast_nullable_to_non_nullable
as TripEntity?,completedTrip: freezed == completedTrip ? _self.completedTrip : completedTrip // ignore: cast_nullable_to_non_nullable
as TripEntity?,pendingTrips: null == pendingTrips ? _self._pendingTrips : pendingTrips // ignore: cast_nullable_to_non_nullable
as List<TripEntity>,arrivedAt: freezed == arrivedAt ? _self.arrivedAt : arrivedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedStops: null == completedStops ? _self._completedStops : completedStops // ignore: cast_nullable_to_non_nullable
as Set<int>,adminSelfAssignState: null == adminSelfAssignState ? _self.adminSelfAssignState : adminSelfAssignState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,adminCancelState: null == adminCancelState ? _self.adminCancelState : adminCancelState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,
  ));
}

/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<TripEntity>, $Res> get getAllState {
  
  return $BlocStatusCopyWith<List<TripEntity>, $Res>(_self.getAllState, (value) {
    return _then(_self.copyWith(getAllState: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<TripEntity, $Res> get activeTripState {
  
  return $BlocStatusCopyWith<TripEntity, $Res>(_self.activeTripState, (value) {
    return _then(_self.copyWith(activeTripState: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get markEnRouteState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.markEnRouteState, (value) {
    return _then(_self.copyWith(markEnRouteState: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get markArrivedState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.markArrivedState, (value) {
    return _then(_self.copyWith(markArrivedState: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get resendArrivedNotificationState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.resendArrivedNotificationState, (value) {
    return _then(_self.copyWith(resendArrivedNotificationState: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get startTripState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.startTripState, (value) {
    return _then(_self.copyWith(startTripState: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get completeTripState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.completeTripState, (value) {
    return _then(_self.copyWith(completeTripState: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get driverCancelState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.driverCancelState, (value) {
    return _then(_self.copyWith(driverCancelState: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get completeStopState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.completeStopState, (value) {
    return _then(_self.copyWith(completeStopState: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get adminSelfAssignState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.adminSelfAssignState, (value) {
    return _then(_self.copyWith(adminSelfAssignState: value));
  });
}/// Create a copy of TripState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get adminCancelState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.adminCancelState, (value) {
    return _then(_self.copyWith(adminCancelState: value));
  });
}
}

// dart format on
