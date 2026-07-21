// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'realtime_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RealtimeEvent {

 String? get tripId;
/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeEventCopyWith<RealtimeEvent> get copyWith => _$RealtimeEventCopyWithImpl<RealtimeEvent>(this as RealtimeEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeEvent&&(identical(other.tripId, tripId) || other.tripId == tripId));
}


@override
int get hashCode => Object.hash(runtimeType,tripId);

@override
String toString() {
  return 'RealtimeEvent(tripId: $tripId)';
}


}

/// @nodoc
abstract mixin class $RealtimeEventCopyWith<$Res>  {
  factory $RealtimeEventCopyWith(RealtimeEvent value, $Res Function(RealtimeEvent) _then) = _$RealtimeEventCopyWithImpl;
@useResult
$Res call({
 String tripId
});




}
/// @nodoc
class _$RealtimeEventCopyWithImpl<$Res>
    implements $RealtimeEventCopyWith<$Res> {
  _$RealtimeEventCopyWithImpl(this._self, this._then);

  final RealtimeEvent _self;
  final $Res Function(RealtimeEvent) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripId = null,}) {
  return _then(_self.copyWith(
tripId: null == tripId ? _self.tripId! : tripId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RealtimeEvent].
extension RealtimeEventPatterns on RealtimeEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RealtimeTripRequested value)?  tripRequested,TResult Function( RealtimeTripAwaitingAdminAcceptance value)?  tripAwaitingAdminAcceptance,TResult Function( RealtimeTripAccepted value)?  tripAccepted,TResult Function( RealtimeDriverAssigned value)?  driverAssigned,TResult Function( RealtimeTripStarted value)?  tripStarted,TResult Function( RealtimeTripCompleted value)?  tripCompleted,TResult Function( RealtimeTripCancelled value)?  tripCancelled,TResult Function( RealtimePaymentConfirmed value)?  paymentConfirmed,TResult Function( RealtimePaymentFailed value)?  paymentFailed,TResult Function( RealtimeTripRefunded value)?  tripRefunded,TResult Function( RealtimeRefundLifecycleChanged value)?  refundLifecycleChanged,TResult Function( RealtimeRefundIssueCreated value)?  refundIssueCreated,TResult Function( RealtimeDriverEnRoute value)?  driverEnRoute,TResult Function( RealtimeDriverArrived value)?  driverArrived,TResult Function( RealtimeDriverLocationUpdated value)?  driverLocationUpdated,TResult Function( RealtimeTripStopCompleted value)?  tripStopCompleted,TResult Function( RealtimeTripMessageReceived value)?  tripMessageReceived,TResult Function( RealtimeChatClosed value)?  chatClosed,TResult Function( RealtimeCustomerIncidentRaised value)?  customerIncidentRaised,TResult Function( RealtimeTripDestinationChanged value)?  tripDestinationChanged,TResult Function( RealtimeTripEditApplied value)?  tripEditApplied,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RealtimeTripRequested() when tripRequested != null:
return tripRequested(_that);case RealtimeTripAwaitingAdminAcceptance() when tripAwaitingAdminAcceptance != null:
return tripAwaitingAdminAcceptance(_that);case RealtimeTripAccepted() when tripAccepted != null:
return tripAccepted(_that);case RealtimeDriverAssigned() when driverAssigned != null:
return driverAssigned(_that);case RealtimeTripStarted() when tripStarted != null:
return tripStarted(_that);case RealtimeTripCompleted() when tripCompleted != null:
return tripCompleted(_that);case RealtimeTripCancelled() when tripCancelled != null:
return tripCancelled(_that);case RealtimePaymentConfirmed() when paymentConfirmed != null:
return paymentConfirmed(_that);case RealtimePaymentFailed() when paymentFailed != null:
return paymentFailed(_that);case RealtimeTripRefunded() when tripRefunded != null:
return tripRefunded(_that);case RealtimeRefundLifecycleChanged() when refundLifecycleChanged != null:
return refundLifecycleChanged(_that);case RealtimeRefundIssueCreated() when refundIssueCreated != null:
return refundIssueCreated(_that);case RealtimeDriverEnRoute() when driverEnRoute != null:
return driverEnRoute(_that);case RealtimeDriverArrived() when driverArrived != null:
return driverArrived(_that);case RealtimeDriverLocationUpdated() when driverLocationUpdated != null:
return driverLocationUpdated(_that);case RealtimeTripStopCompleted() when tripStopCompleted != null:
return tripStopCompleted(_that);case RealtimeTripMessageReceived() when tripMessageReceived != null:
return tripMessageReceived(_that);case RealtimeChatClosed() when chatClosed != null:
return chatClosed(_that);case RealtimeCustomerIncidentRaised() when customerIncidentRaised != null:
return customerIncidentRaised(_that);case RealtimeTripDestinationChanged() when tripDestinationChanged != null:
return tripDestinationChanged(_that);case RealtimeTripEditApplied() when tripEditApplied != null:
return tripEditApplied(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RealtimeTripRequested value)  tripRequested,required TResult Function( RealtimeTripAwaitingAdminAcceptance value)  tripAwaitingAdminAcceptance,required TResult Function( RealtimeTripAccepted value)  tripAccepted,required TResult Function( RealtimeDriverAssigned value)  driverAssigned,required TResult Function( RealtimeTripStarted value)  tripStarted,required TResult Function( RealtimeTripCompleted value)  tripCompleted,required TResult Function( RealtimeTripCancelled value)  tripCancelled,required TResult Function( RealtimePaymentConfirmed value)  paymentConfirmed,required TResult Function( RealtimePaymentFailed value)  paymentFailed,required TResult Function( RealtimeTripRefunded value)  tripRefunded,required TResult Function( RealtimeRefundLifecycleChanged value)  refundLifecycleChanged,required TResult Function( RealtimeRefundIssueCreated value)  refundIssueCreated,required TResult Function( RealtimeDriverEnRoute value)  driverEnRoute,required TResult Function( RealtimeDriverArrived value)  driverArrived,required TResult Function( RealtimeDriverLocationUpdated value)  driverLocationUpdated,required TResult Function( RealtimeTripStopCompleted value)  tripStopCompleted,required TResult Function( RealtimeTripMessageReceived value)  tripMessageReceived,required TResult Function( RealtimeChatClosed value)  chatClosed,required TResult Function( RealtimeCustomerIncidentRaised value)  customerIncidentRaised,required TResult Function( RealtimeTripDestinationChanged value)  tripDestinationChanged,required TResult Function( RealtimeTripEditApplied value)  tripEditApplied,}){
final _that = this;
switch (_that) {
case RealtimeTripRequested():
return tripRequested(_that);case RealtimeTripAwaitingAdminAcceptance():
return tripAwaitingAdminAcceptance(_that);case RealtimeTripAccepted():
return tripAccepted(_that);case RealtimeDriverAssigned():
return driverAssigned(_that);case RealtimeTripStarted():
return tripStarted(_that);case RealtimeTripCompleted():
return tripCompleted(_that);case RealtimeTripCancelled():
return tripCancelled(_that);case RealtimePaymentConfirmed():
return paymentConfirmed(_that);case RealtimePaymentFailed():
return paymentFailed(_that);case RealtimeTripRefunded():
return tripRefunded(_that);case RealtimeRefundLifecycleChanged():
return refundLifecycleChanged(_that);case RealtimeRefundIssueCreated():
return refundIssueCreated(_that);case RealtimeDriverEnRoute():
return driverEnRoute(_that);case RealtimeDriverArrived():
return driverArrived(_that);case RealtimeDriverLocationUpdated():
return driverLocationUpdated(_that);case RealtimeTripStopCompleted():
return tripStopCompleted(_that);case RealtimeTripMessageReceived():
return tripMessageReceived(_that);case RealtimeChatClosed():
return chatClosed(_that);case RealtimeCustomerIncidentRaised():
return customerIncidentRaised(_that);case RealtimeTripDestinationChanged():
return tripDestinationChanged(_that);case RealtimeTripEditApplied():
return tripEditApplied(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RealtimeTripRequested value)?  tripRequested,TResult? Function( RealtimeTripAwaitingAdminAcceptance value)?  tripAwaitingAdminAcceptance,TResult? Function( RealtimeTripAccepted value)?  tripAccepted,TResult? Function( RealtimeDriverAssigned value)?  driverAssigned,TResult? Function( RealtimeTripStarted value)?  tripStarted,TResult? Function( RealtimeTripCompleted value)?  tripCompleted,TResult? Function( RealtimeTripCancelled value)?  tripCancelled,TResult? Function( RealtimePaymentConfirmed value)?  paymentConfirmed,TResult? Function( RealtimePaymentFailed value)?  paymentFailed,TResult? Function( RealtimeTripRefunded value)?  tripRefunded,TResult? Function( RealtimeRefundLifecycleChanged value)?  refundLifecycleChanged,TResult? Function( RealtimeRefundIssueCreated value)?  refundIssueCreated,TResult? Function( RealtimeDriverEnRoute value)?  driverEnRoute,TResult? Function( RealtimeDriverArrived value)?  driverArrived,TResult? Function( RealtimeDriverLocationUpdated value)?  driverLocationUpdated,TResult? Function( RealtimeTripStopCompleted value)?  tripStopCompleted,TResult? Function( RealtimeTripMessageReceived value)?  tripMessageReceived,TResult? Function( RealtimeChatClosed value)?  chatClosed,TResult? Function( RealtimeCustomerIncidentRaised value)?  customerIncidentRaised,TResult? Function( RealtimeTripDestinationChanged value)?  tripDestinationChanged,TResult? Function( RealtimeTripEditApplied value)?  tripEditApplied,}){
final _that = this;
switch (_that) {
case RealtimeTripRequested() when tripRequested != null:
return tripRequested(_that);case RealtimeTripAwaitingAdminAcceptance() when tripAwaitingAdminAcceptance != null:
return tripAwaitingAdminAcceptance(_that);case RealtimeTripAccepted() when tripAccepted != null:
return tripAccepted(_that);case RealtimeDriverAssigned() when driverAssigned != null:
return driverAssigned(_that);case RealtimeTripStarted() when tripStarted != null:
return tripStarted(_that);case RealtimeTripCompleted() when tripCompleted != null:
return tripCompleted(_that);case RealtimeTripCancelled() when tripCancelled != null:
return tripCancelled(_that);case RealtimePaymentConfirmed() when paymentConfirmed != null:
return paymentConfirmed(_that);case RealtimePaymentFailed() when paymentFailed != null:
return paymentFailed(_that);case RealtimeTripRefunded() when tripRefunded != null:
return tripRefunded(_that);case RealtimeRefundLifecycleChanged() when refundLifecycleChanged != null:
return refundLifecycleChanged(_that);case RealtimeRefundIssueCreated() when refundIssueCreated != null:
return refundIssueCreated(_that);case RealtimeDriverEnRoute() when driverEnRoute != null:
return driverEnRoute(_that);case RealtimeDriverArrived() when driverArrived != null:
return driverArrived(_that);case RealtimeDriverLocationUpdated() when driverLocationUpdated != null:
return driverLocationUpdated(_that);case RealtimeTripStopCompleted() when tripStopCompleted != null:
return tripStopCompleted(_that);case RealtimeTripMessageReceived() when tripMessageReceived != null:
return tripMessageReceived(_that);case RealtimeChatClosed() when chatClosed != null:
return chatClosed(_that);case RealtimeCustomerIncidentRaised() when customerIncidentRaised != null:
return customerIncidentRaised(_that);case RealtimeTripDestinationChanged() when tripDestinationChanged != null:
return tripDestinationChanged(_that);case RealtimeTripEditApplied() when tripEditApplied != null:
return tripEditApplied(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String tripId,  String vehicleTypeId,  String passengerId)?  tripRequested,TResult Function( String tripId,  String vehicleTypeId,  String passengerId,  String? scheduledAtUtc)?  tripAwaitingAdminAcceptance,TResult Function( String tripId,  String passengerId,  String adminId)?  tripAccepted,TResult Function( String tripId,  String passengerId,  String driverId)?  driverAssigned,TResult Function( String tripId,  String passengerId)?  tripStarted,TResult Function( String tripId,  String passengerId)?  tripCompleted,TResult Function( String tripId,  String passengerId)?  tripCancelled,TResult Function( String tripId,  String passengerId)?  paymentConfirmed,TResult Function( String tripId,  String passengerId,  String reason)?  paymentFailed,TResult Function( String tripId,  String passengerId,  double amount)?  tripRefunded,TResult Function( String refundId,  String paymentId,  String? tripId,  String? passengerId,  String status,  double amount,  String currency,  bool requiresAdminAction,  bool canRetry,  String sourceType)?  refundLifecycleChanged,TResult Function( String refundIssueId,  String tripId,  String passengerId,  String? paymentId,  String requestType,  String reviewStatus)?  refundIssueCreated,TResult Function( String tripId,  String passengerId,  String driverId)?  driverEnRoute,TResult Function( String tripId,  String passengerId,  String driverId)?  driverArrived,TResult Function( String tripId,  String driverId,  double latitude,  double longitude)?  driverLocationUpdated,TResult Function( String tripId,  String passengerId,  String? driverId,  int sequence)?  tripStopCompleted,TResult Function( String tripId,  String messageId,  String senderId,  String senderRole,  String? content,  String? photoUrl,  String sentAtUtc)?  tripMessageReceived,TResult Function( String tripId)?  chatClosed,TResult Function( String incidentId,  String passengerId,  String tripId,  String type,  String severity)?  customerIncidentRaised,TResult Function( String tripId,  String passengerId,  String? driverId,  double newDropoffLatitude,  double newDropoffLongitude,  String? newDropoffLabel)?  tripDestinationChanged,TResult Function( String tripId,  String passengerId,  double newFare,  String currency,  double delta,  int passengerCount,  String? vehicleTypeName,  String? dropoffLabel)?  tripEditApplied,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RealtimeTripRequested() when tripRequested != null:
return tripRequested(_that.tripId,_that.vehicleTypeId,_that.passengerId);case RealtimeTripAwaitingAdminAcceptance() when tripAwaitingAdminAcceptance != null:
return tripAwaitingAdminAcceptance(_that.tripId,_that.vehicleTypeId,_that.passengerId,_that.scheduledAtUtc);case RealtimeTripAccepted() when tripAccepted != null:
return tripAccepted(_that.tripId,_that.passengerId,_that.adminId);case RealtimeDriverAssigned() when driverAssigned != null:
return driverAssigned(_that.tripId,_that.passengerId,_that.driverId);case RealtimeTripStarted() when tripStarted != null:
return tripStarted(_that.tripId,_that.passengerId);case RealtimeTripCompleted() when tripCompleted != null:
return tripCompleted(_that.tripId,_that.passengerId);case RealtimeTripCancelled() when tripCancelled != null:
return tripCancelled(_that.tripId,_that.passengerId);case RealtimePaymentConfirmed() when paymentConfirmed != null:
return paymentConfirmed(_that.tripId,_that.passengerId);case RealtimePaymentFailed() when paymentFailed != null:
return paymentFailed(_that.tripId,_that.passengerId,_that.reason);case RealtimeTripRefunded() when tripRefunded != null:
return tripRefunded(_that.tripId,_that.passengerId,_that.amount);case RealtimeRefundLifecycleChanged() when refundLifecycleChanged != null:
return refundLifecycleChanged(_that.refundId,_that.paymentId,_that.tripId,_that.passengerId,_that.status,_that.amount,_that.currency,_that.requiresAdminAction,_that.canRetry,_that.sourceType);case RealtimeRefundIssueCreated() when refundIssueCreated != null:
return refundIssueCreated(_that.refundIssueId,_that.tripId,_that.passengerId,_that.paymentId,_that.requestType,_that.reviewStatus);case RealtimeDriverEnRoute() when driverEnRoute != null:
return driverEnRoute(_that.tripId,_that.passengerId,_that.driverId);case RealtimeDriverArrived() when driverArrived != null:
return driverArrived(_that.tripId,_that.passengerId,_that.driverId);case RealtimeDriverLocationUpdated() when driverLocationUpdated != null:
return driverLocationUpdated(_that.tripId,_that.driverId,_that.latitude,_that.longitude);case RealtimeTripStopCompleted() when tripStopCompleted != null:
return tripStopCompleted(_that.tripId,_that.passengerId,_that.driverId,_that.sequence);case RealtimeTripMessageReceived() when tripMessageReceived != null:
return tripMessageReceived(_that.tripId,_that.messageId,_that.senderId,_that.senderRole,_that.content,_that.photoUrl,_that.sentAtUtc);case RealtimeChatClosed() when chatClosed != null:
return chatClosed(_that.tripId);case RealtimeCustomerIncidentRaised() when customerIncidentRaised != null:
return customerIncidentRaised(_that.incidentId,_that.passengerId,_that.tripId,_that.type,_that.severity);case RealtimeTripDestinationChanged() when tripDestinationChanged != null:
return tripDestinationChanged(_that.tripId,_that.passengerId,_that.driverId,_that.newDropoffLatitude,_that.newDropoffLongitude,_that.newDropoffLabel);case RealtimeTripEditApplied() when tripEditApplied != null:
return tripEditApplied(_that.tripId,_that.passengerId,_that.newFare,_that.currency,_that.delta,_that.passengerCount,_that.vehicleTypeName,_that.dropoffLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String tripId,  String vehicleTypeId,  String passengerId)  tripRequested,required TResult Function( String tripId,  String vehicleTypeId,  String passengerId,  String? scheduledAtUtc)  tripAwaitingAdminAcceptance,required TResult Function( String tripId,  String passengerId,  String adminId)  tripAccepted,required TResult Function( String tripId,  String passengerId,  String driverId)  driverAssigned,required TResult Function( String tripId,  String passengerId)  tripStarted,required TResult Function( String tripId,  String passengerId)  tripCompleted,required TResult Function( String tripId,  String passengerId)  tripCancelled,required TResult Function( String tripId,  String passengerId)  paymentConfirmed,required TResult Function( String tripId,  String passengerId,  String reason)  paymentFailed,required TResult Function( String tripId,  String passengerId,  double amount)  tripRefunded,required TResult Function( String refundId,  String paymentId,  String? tripId,  String? passengerId,  String status,  double amount,  String currency,  bool requiresAdminAction,  bool canRetry,  String sourceType)  refundLifecycleChanged,required TResult Function( String refundIssueId,  String tripId,  String passengerId,  String? paymentId,  String requestType,  String reviewStatus)  refundIssueCreated,required TResult Function( String tripId,  String passengerId,  String driverId)  driverEnRoute,required TResult Function( String tripId,  String passengerId,  String driverId)  driverArrived,required TResult Function( String tripId,  String driverId,  double latitude,  double longitude)  driverLocationUpdated,required TResult Function( String tripId,  String passengerId,  String? driverId,  int sequence)  tripStopCompleted,required TResult Function( String tripId,  String messageId,  String senderId,  String senderRole,  String? content,  String? photoUrl,  String sentAtUtc)  tripMessageReceived,required TResult Function( String tripId)  chatClosed,required TResult Function( String incidentId,  String passengerId,  String tripId,  String type,  String severity)  customerIncidentRaised,required TResult Function( String tripId,  String passengerId,  String? driverId,  double newDropoffLatitude,  double newDropoffLongitude,  String? newDropoffLabel)  tripDestinationChanged,required TResult Function( String tripId,  String passengerId,  double newFare,  String currency,  double delta,  int passengerCount,  String? vehicleTypeName,  String? dropoffLabel)  tripEditApplied,}) {final _that = this;
switch (_that) {
case RealtimeTripRequested():
return tripRequested(_that.tripId,_that.vehicleTypeId,_that.passengerId);case RealtimeTripAwaitingAdminAcceptance():
return tripAwaitingAdminAcceptance(_that.tripId,_that.vehicleTypeId,_that.passengerId,_that.scheduledAtUtc);case RealtimeTripAccepted():
return tripAccepted(_that.tripId,_that.passengerId,_that.adminId);case RealtimeDriverAssigned():
return driverAssigned(_that.tripId,_that.passengerId,_that.driverId);case RealtimeTripStarted():
return tripStarted(_that.tripId,_that.passengerId);case RealtimeTripCompleted():
return tripCompleted(_that.tripId,_that.passengerId);case RealtimeTripCancelled():
return tripCancelled(_that.tripId,_that.passengerId);case RealtimePaymentConfirmed():
return paymentConfirmed(_that.tripId,_that.passengerId);case RealtimePaymentFailed():
return paymentFailed(_that.tripId,_that.passengerId,_that.reason);case RealtimeTripRefunded():
return tripRefunded(_that.tripId,_that.passengerId,_that.amount);case RealtimeRefundLifecycleChanged():
return refundLifecycleChanged(_that.refundId,_that.paymentId,_that.tripId,_that.passengerId,_that.status,_that.amount,_that.currency,_that.requiresAdminAction,_that.canRetry,_that.sourceType);case RealtimeRefundIssueCreated():
return refundIssueCreated(_that.refundIssueId,_that.tripId,_that.passengerId,_that.paymentId,_that.requestType,_that.reviewStatus);case RealtimeDriverEnRoute():
return driverEnRoute(_that.tripId,_that.passengerId,_that.driverId);case RealtimeDriverArrived():
return driverArrived(_that.tripId,_that.passengerId,_that.driverId);case RealtimeDriverLocationUpdated():
return driverLocationUpdated(_that.tripId,_that.driverId,_that.latitude,_that.longitude);case RealtimeTripStopCompleted():
return tripStopCompleted(_that.tripId,_that.passengerId,_that.driverId,_that.sequence);case RealtimeTripMessageReceived():
return tripMessageReceived(_that.tripId,_that.messageId,_that.senderId,_that.senderRole,_that.content,_that.photoUrl,_that.sentAtUtc);case RealtimeChatClosed():
return chatClosed(_that.tripId);case RealtimeCustomerIncidentRaised():
return customerIncidentRaised(_that.incidentId,_that.passengerId,_that.tripId,_that.type,_that.severity);case RealtimeTripDestinationChanged():
return tripDestinationChanged(_that.tripId,_that.passengerId,_that.driverId,_that.newDropoffLatitude,_that.newDropoffLongitude,_that.newDropoffLabel);case RealtimeTripEditApplied():
return tripEditApplied(_that.tripId,_that.passengerId,_that.newFare,_that.currency,_that.delta,_that.passengerCount,_that.vehicleTypeName,_that.dropoffLabel);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String tripId,  String vehicleTypeId,  String passengerId)?  tripRequested,TResult? Function( String tripId,  String vehicleTypeId,  String passengerId,  String? scheduledAtUtc)?  tripAwaitingAdminAcceptance,TResult? Function( String tripId,  String passengerId,  String adminId)?  tripAccepted,TResult? Function( String tripId,  String passengerId,  String driverId)?  driverAssigned,TResult? Function( String tripId,  String passengerId)?  tripStarted,TResult? Function( String tripId,  String passengerId)?  tripCompleted,TResult? Function( String tripId,  String passengerId)?  tripCancelled,TResult? Function( String tripId,  String passengerId)?  paymentConfirmed,TResult? Function( String tripId,  String passengerId,  String reason)?  paymentFailed,TResult? Function( String tripId,  String passengerId,  double amount)?  tripRefunded,TResult? Function( String refundId,  String paymentId,  String? tripId,  String? passengerId,  String status,  double amount,  String currency,  bool requiresAdminAction,  bool canRetry,  String sourceType)?  refundLifecycleChanged,TResult? Function( String refundIssueId,  String tripId,  String passengerId,  String? paymentId,  String requestType,  String reviewStatus)?  refundIssueCreated,TResult? Function( String tripId,  String passengerId,  String driverId)?  driverEnRoute,TResult? Function( String tripId,  String passengerId,  String driverId)?  driverArrived,TResult? Function( String tripId,  String driverId,  double latitude,  double longitude)?  driverLocationUpdated,TResult? Function( String tripId,  String passengerId,  String? driverId,  int sequence)?  tripStopCompleted,TResult? Function( String tripId,  String messageId,  String senderId,  String senderRole,  String? content,  String? photoUrl,  String sentAtUtc)?  tripMessageReceived,TResult? Function( String tripId)?  chatClosed,TResult? Function( String incidentId,  String passengerId,  String tripId,  String type,  String severity)?  customerIncidentRaised,TResult? Function( String tripId,  String passengerId,  String? driverId,  double newDropoffLatitude,  double newDropoffLongitude,  String? newDropoffLabel)?  tripDestinationChanged,TResult? Function( String tripId,  String passengerId,  double newFare,  String currency,  double delta,  int passengerCount,  String? vehicleTypeName,  String? dropoffLabel)?  tripEditApplied,}) {final _that = this;
switch (_that) {
case RealtimeTripRequested() when tripRequested != null:
return tripRequested(_that.tripId,_that.vehicleTypeId,_that.passengerId);case RealtimeTripAwaitingAdminAcceptance() when tripAwaitingAdminAcceptance != null:
return tripAwaitingAdminAcceptance(_that.tripId,_that.vehicleTypeId,_that.passengerId,_that.scheduledAtUtc);case RealtimeTripAccepted() when tripAccepted != null:
return tripAccepted(_that.tripId,_that.passengerId,_that.adminId);case RealtimeDriverAssigned() when driverAssigned != null:
return driverAssigned(_that.tripId,_that.passengerId,_that.driverId);case RealtimeTripStarted() when tripStarted != null:
return tripStarted(_that.tripId,_that.passengerId);case RealtimeTripCompleted() when tripCompleted != null:
return tripCompleted(_that.tripId,_that.passengerId);case RealtimeTripCancelled() when tripCancelled != null:
return tripCancelled(_that.tripId,_that.passengerId);case RealtimePaymentConfirmed() when paymentConfirmed != null:
return paymentConfirmed(_that.tripId,_that.passengerId);case RealtimePaymentFailed() when paymentFailed != null:
return paymentFailed(_that.tripId,_that.passengerId,_that.reason);case RealtimeTripRefunded() when tripRefunded != null:
return tripRefunded(_that.tripId,_that.passengerId,_that.amount);case RealtimeRefundLifecycleChanged() when refundLifecycleChanged != null:
return refundLifecycleChanged(_that.refundId,_that.paymentId,_that.tripId,_that.passengerId,_that.status,_that.amount,_that.currency,_that.requiresAdminAction,_that.canRetry,_that.sourceType);case RealtimeRefundIssueCreated() when refundIssueCreated != null:
return refundIssueCreated(_that.refundIssueId,_that.tripId,_that.passengerId,_that.paymentId,_that.requestType,_that.reviewStatus);case RealtimeDriverEnRoute() when driverEnRoute != null:
return driverEnRoute(_that.tripId,_that.passengerId,_that.driverId);case RealtimeDriverArrived() when driverArrived != null:
return driverArrived(_that.tripId,_that.passengerId,_that.driverId);case RealtimeDriverLocationUpdated() when driverLocationUpdated != null:
return driverLocationUpdated(_that.tripId,_that.driverId,_that.latitude,_that.longitude);case RealtimeTripStopCompleted() when tripStopCompleted != null:
return tripStopCompleted(_that.tripId,_that.passengerId,_that.driverId,_that.sequence);case RealtimeTripMessageReceived() when tripMessageReceived != null:
return tripMessageReceived(_that.tripId,_that.messageId,_that.senderId,_that.senderRole,_that.content,_that.photoUrl,_that.sentAtUtc);case RealtimeChatClosed() when chatClosed != null:
return chatClosed(_that.tripId);case RealtimeCustomerIncidentRaised() when customerIncidentRaised != null:
return customerIncidentRaised(_that.incidentId,_that.passengerId,_that.tripId,_that.type,_that.severity);case RealtimeTripDestinationChanged() when tripDestinationChanged != null:
return tripDestinationChanged(_that.tripId,_that.passengerId,_that.driverId,_that.newDropoffLatitude,_that.newDropoffLongitude,_that.newDropoffLabel);case RealtimeTripEditApplied() when tripEditApplied != null:
return tripEditApplied(_that.tripId,_that.passengerId,_that.newFare,_that.currency,_that.delta,_that.passengerCount,_that.vehicleTypeName,_that.dropoffLabel);case _:
  return null;

}
}

}

/// @nodoc


class RealtimeTripRequested implements RealtimeEvent {
  const RealtimeTripRequested({required this.tripId, required this.vehicleTypeId, required this.passengerId});
  

@override final  String tripId;
 final  String vehicleTypeId;
 final  String passengerId;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeTripRequestedCopyWith<RealtimeTripRequested> get copyWith => _$RealtimeTripRequestedCopyWithImpl<RealtimeTripRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeTripRequested&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.vehicleTypeId, vehicleTypeId) || other.vehicleTypeId == vehicleTypeId)&&(identical(other.passengerId, passengerId) || other.passengerId == passengerId));
}


@override
int get hashCode => Object.hash(runtimeType,tripId,vehicleTypeId,passengerId);

@override
String toString() {
  return 'RealtimeEvent.tripRequested(tripId: $tripId, vehicleTypeId: $vehicleTypeId, passengerId: $passengerId)';
}


}

/// @nodoc
abstract mixin class $RealtimeTripRequestedCopyWith<$Res> implements $RealtimeEventCopyWith<$Res> {
  factory $RealtimeTripRequestedCopyWith(RealtimeTripRequested value, $Res Function(RealtimeTripRequested) _then) = _$RealtimeTripRequestedCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String vehicleTypeId, String passengerId
});




}
/// @nodoc
class _$RealtimeTripRequestedCopyWithImpl<$Res>
    implements $RealtimeTripRequestedCopyWith<$Res> {
  _$RealtimeTripRequestedCopyWithImpl(this._self, this._then);

  final RealtimeTripRequested _self;
  final $Res Function(RealtimeTripRequested) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? vehicleTypeId = null,Object? passengerId = null,}) {
  return _then(RealtimeTripRequested(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,vehicleTypeId: null == vehicleTypeId ? _self.vehicleTypeId : vehicleTypeId // ignore: cast_nullable_to_non_nullable
as String,passengerId: null == passengerId ? _self.passengerId : passengerId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RealtimeTripAwaitingAdminAcceptance implements RealtimeEvent {
  const RealtimeTripAwaitingAdminAcceptance({required this.tripId, required this.vehicleTypeId, required this.passengerId, this.scheduledAtUtc});
  

@override final  String tripId;
 final  String vehicleTypeId;
 final  String passengerId;
 final  String? scheduledAtUtc;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeTripAwaitingAdminAcceptanceCopyWith<RealtimeTripAwaitingAdminAcceptance> get copyWith => _$RealtimeTripAwaitingAdminAcceptanceCopyWithImpl<RealtimeTripAwaitingAdminAcceptance>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeTripAwaitingAdminAcceptance&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.vehicleTypeId, vehicleTypeId) || other.vehicleTypeId == vehicleTypeId)&&(identical(other.passengerId, passengerId) || other.passengerId == passengerId)&&(identical(other.scheduledAtUtc, scheduledAtUtc) || other.scheduledAtUtc == scheduledAtUtc));
}


@override
int get hashCode => Object.hash(runtimeType,tripId,vehicleTypeId,passengerId,scheduledAtUtc);

@override
String toString() {
  return 'RealtimeEvent.tripAwaitingAdminAcceptance(tripId: $tripId, vehicleTypeId: $vehicleTypeId, passengerId: $passengerId, scheduledAtUtc: $scheduledAtUtc)';
}


}

/// @nodoc
abstract mixin class $RealtimeTripAwaitingAdminAcceptanceCopyWith<$Res> implements $RealtimeEventCopyWith<$Res> {
  factory $RealtimeTripAwaitingAdminAcceptanceCopyWith(RealtimeTripAwaitingAdminAcceptance value, $Res Function(RealtimeTripAwaitingAdminAcceptance) _then) = _$RealtimeTripAwaitingAdminAcceptanceCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String vehicleTypeId, String passengerId, String? scheduledAtUtc
});




}
/// @nodoc
class _$RealtimeTripAwaitingAdminAcceptanceCopyWithImpl<$Res>
    implements $RealtimeTripAwaitingAdminAcceptanceCopyWith<$Res> {
  _$RealtimeTripAwaitingAdminAcceptanceCopyWithImpl(this._self, this._then);

  final RealtimeTripAwaitingAdminAcceptance _self;
  final $Res Function(RealtimeTripAwaitingAdminAcceptance) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? vehicleTypeId = null,Object? passengerId = null,Object? scheduledAtUtc = freezed,}) {
  return _then(RealtimeTripAwaitingAdminAcceptance(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,vehicleTypeId: null == vehicleTypeId ? _self.vehicleTypeId : vehicleTypeId // ignore: cast_nullable_to_non_nullable
as String,passengerId: null == passengerId ? _self.passengerId : passengerId // ignore: cast_nullable_to_non_nullable
as String,scheduledAtUtc: freezed == scheduledAtUtc ? _self.scheduledAtUtc : scheduledAtUtc // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class RealtimeTripAccepted implements RealtimeEvent {
  const RealtimeTripAccepted({required this.tripId, required this.passengerId, required this.adminId});
  

@override final  String tripId;
 final  String passengerId;
 final  String adminId;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeTripAcceptedCopyWith<RealtimeTripAccepted> get copyWith => _$RealtimeTripAcceptedCopyWithImpl<RealtimeTripAccepted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeTripAccepted&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.passengerId, passengerId) || other.passengerId == passengerId)&&(identical(other.adminId, adminId) || other.adminId == adminId));
}


@override
int get hashCode => Object.hash(runtimeType,tripId,passengerId,adminId);

@override
String toString() {
  return 'RealtimeEvent.tripAccepted(tripId: $tripId, passengerId: $passengerId, adminId: $adminId)';
}


}

/// @nodoc
abstract mixin class $RealtimeTripAcceptedCopyWith<$Res> implements $RealtimeEventCopyWith<$Res> {
  factory $RealtimeTripAcceptedCopyWith(RealtimeTripAccepted value, $Res Function(RealtimeTripAccepted) _then) = _$RealtimeTripAcceptedCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String passengerId, String adminId
});




}
/// @nodoc
class _$RealtimeTripAcceptedCopyWithImpl<$Res>
    implements $RealtimeTripAcceptedCopyWith<$Res> {
  _$RealtimeTripAcceptedCopyWithImpl(this._self, this._then);

  final RealtimeTripAccepted _self;
  final $Res Function(RealtimeTripAccepted) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? passengerId = null,Object? adminId = null,}) {
  return _then(RealtimeTripAccepted(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,passengerId: null == passengerId ? _self.passengerId : passengerId // ignore: cast_nullable_to_non_nullable
as String,adminId: null == adminId ? _self.adminId : adminId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RealtimeDriverAssigned implements RealtimeEvent {
  const RealtimeDriverAssigned({required this.tripId, required this.passengerId, required this.driverId});
  

@override final  String tripId;
 final  String passengerId;
 final  String driverId;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeDriverAssignedCopyWith<RealtimeDriverAssigned> get copyWith => _$RealtimeDriverAssignedCopyWithImpl<RealtimeDriverAssigned>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeDriverAssigned&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.passengerId, passengerId) || other.passengerId == passengerId)&&(identical(other.driverId, driverId) || other.driverId == driverId));
}


@override
int get hashCode => Object.hash(runtimeType,tripId,passengerId,driverId);

@override
String toString() {
  return 'RealtimeEvent.driverAssigned(tripId: $tripId, passengerId: $passengerId, driverId: $driverId)';
}


}

/// @nodoc
abstract mixin class $RealtimeDriverAssignedCopyWith<$Res> implements $RealtimeEventCopyWith<$Res> {
  factory $RealtimeDriverAssignedCopyWith(RealtimeDriverAssigned value, $Res Function(RealtimeDriverAssigned) _then) = _$RealtimeDriverAssignedCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String passengerId, String driverId
});




}
/// @nodoc
class _$RealtimeDriverAssignedCopyWithImpl<$Res>
    implements $RealtimeDriverAssignedCopyWith<$Res> {
  _$RealtimeDriverAssignedCopyWithImpl(this._self, this._then);

  final RealtimeDriverAssigned _self;
  final $Res Function(RealtimeDriverAssigned) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? passengerId = null,Object? driverId = null,}) {
  return _then(RealtimeDriverAssigned(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,passengerId: null == passengerId ? _self.passengerId : passengerId // ignore: cast_nullable_to_non_nullable
as String,driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RealtimeTripStarted implements RealtimeEvent {
  const RealtimeTripStarted({required this.tripId, required this.passengerId});
  

@override final  String tripId;
 final  String passengerId;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeTripStartedCopyWith<RealtimeTripStarted> get copyWith => _$RealtimeTripStartedCopyWithImpl<RealtimeTripStarted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeTripStarted&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.passengerId, passengerId) || other.passengerId == passengerId));
}


@override
int get hashCode => Object.hash(runtimeType,tripId,passengerId);

@override
String toString() {
  return 'RealtimeEvent.tripStarted(tripId: $tripId, passengerId: $passengerId)';
}


}

/// @nodoc
abstract mixin class $RealtimeTripStartedCopyWith<$Res> implements $RealtimeEventCopyWith<$Res> {
  factory $RealtimeTripStartedCopyWith(RealtimeTripStarted value, $Res Function(RealtimeTripStarted) _then) = _$RealtimeTripStartedCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String passengerId
});




}
/// @nodoc
class _$RealtimeTripStartedCopyWithImpl<$Res>
    implements $RealtimeTripStartedCopyWith<$Res> {
  _$RealtimeTripStartedCopyWithImpl(this._self, this._then);

  final RealtimeTripStarted _self;
  final $Res Function(RealtimeTripStarted) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? passengerId = null,}) {
  return _then(RealtimeTripStarted(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,passengerId: null == passengerId ? _self.passengerId : passengerId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RealtimeTripCompleted implements RealtimeEvent {
  const RealtimeTripCompleted({required this.tripId, required this.passengerId});
  

@override final  String tripId;
 final  String passengerId;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeTripCompletedCopyWith<RealtimeTripCompleted> get copyWith => _$RealtimeTripCompletedCopyWithImpl<RealtimeTripCompleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeTripCompleted&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.passengerId, passengerId) || other.passengerId == passengerId));
}


@override
int get hashCode => Object.hash(runtimeType,tripId,passengerId);

@override
String toString() {
  return 'RealtimeEvent.tripCompleted(tripId: $tripId, passengerId: $passengerId)';
}


}

/// @nodoc
abstract mixin class $RealtimeTripCompletedCopyWith<$Res> implements $RealtimeEventCopyWith<$Res> {
  factory $RealtimeTripCompletedCopyWith(RealtimeTripCompleted value, $Res Function(RealtimeTripCompleted) _then) = _$RealtimeTripCompletedCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String passengerId
});




}
/// @nodoc
class _$RealtimeTripCompletedCopyWithImpl<$Res>
    implements $RealtimeTripCompletedCopyWith<$Res> {
  _$RealtimeTripCompletedCopyWithImpl(this._self, this._then);

  final RealtimeTripCompleted _self;
  final $Res Function(RealtimeTripCompleted) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? passengerId = null,}) {
  return _then(RealtimeTripCompleted(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,passengerId: null == passengerId ? _self.passengerId : passengerId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RealtimeTripCancelled implements RealtimeEvent {
  const RealtimeTripCancelled({required this.tripId, required this.passengerId});
  

@override final  String tripId;
 final  String passengerId;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeTripCancelledCopyWith<RealtimeTripCancelled> get copyWith => _$RealtimeTripCancelledCopyWithImpl<RealtimeTripCancelled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeTripCancelled&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.passengerId, passengerId) || other.passengerId == passengerId));
}


@override
int get hashCode => Object.hash(runtimeType,tripId,passengerId);

@override
String toString() {
  return 'RealtimeEvent.tripCancelled(tripId: $tripId, passengerId: $passengerId)';
}


}

/// @nodoc
abstract mixin class $RealtimeTripCancelledCopyWith<$Res> implements $RealtimeEventCopyWith<$Res> {
  factory $RealtimeTripCancelledCopyWith(RealtimeTripCancelled value, $Res Function(RealtimeTripCancelled) _then) = _$RealtimeTripCancelledCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String passengerId
});




}
/// @nodoc
class _$RealtimeTripCancelledCopyWithImpl<$Res>
    implements $RealtimeTripCancelledCopyWith<$Res> {
  _$RealtimeTripCancelledCopyWithImpl(this._self, this._then);

  final RealtimeTripCancelled _self;
  final $Res Function(RealtimeTripCancelled) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? passengerId = null,}) {
  return _then(RealtimeTripCancelled(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,passengerId: null == passengerId ? _self.passengerId : passengerId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RealtimePaymentConfirmed implements RealtimeEvent {
  const RealtimePaymentConfirmed({required this.tripId, required this.passengerId});
  

@override final  String tripId;
 final  String passengerId;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimePaymentConfirmedCopyWith<RealtimePaymentConfirmed> get copyWith => _$RealtimePaymentConfirmedCopyWithImpl<RealtimePaymentConfirmed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimePaymentConfirmed&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.passengerId, passengerId) || other.passengerId == passengerId));
}


@override
int get hashCode => Object.hash(runtimeType,tripId,passengerId);

@override
String toString() {
  return 'RealtimeEvent.paymentConfirmed(tripId: $tripId, passengerId: $passengerId)';
}


}

/// @nodoc
abstract mixin class $RealtimePaymentConfirmedCopyWith<$Res> implements $RealtimeEventCopyWith<$Res> {
  factory $RealtimePaymentConfirmedCopyWith(RealtimePaymentConfirmed value, $Res Function(RealtimePaymentConfirmed) _then) = _$RealtimePaymentConfirmedCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String passengerId
});




}
/// @nodoc
class _$RealtimePaymentConfirmedCopyWithImpl<$Res>
    implements $RealtimePaymentConfirmedCopyWith<$Res> {
  _$RealtimePaymentConfirmedCopyWithImpl(this._self, this._then);

  final RealtimePaymentConfirmed _self;
  final $Res Function(RealtimePaymentConfirmed) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? passengerId = null,}) {
  return _then(RealtimePaymentConfirmed(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,passengerId: null == passengerId ? _self.passengerId : passengerId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RealtimePaymentFailed implements RealtimeEvent {
  const RealtimePaymentFailed({required this.tripId, required this.passengerId, required this.reason});
  

@override final  String tripId;
 final  String passengerId;
 final  String reason;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimePaymentFailedCopyWith<RealtimePaymentFailed> get copyWith => _$RealtimePaymentFailedCopyWithImpl<RealtimePaymentFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimePaymentFailed&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.passengerId, passengerId) || other.passengerId == passengerId)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,tripId,passengerId,reason);

@override
String toString() {
  return 'RealtimeEvent.paymentFailed(tripId: $tripId, passengerId: $passengerId, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $RealtimePaymentFailedCopyWith<$Res> implements $RealtimeEventCopyWith<$Res> {
  factory $RealtimePaymentFailedCopyWith(RealtimePaymentFailed value, $Res Function(RealtimePaymentFailed) _then) = _$RealtimePaymentFailedCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String passengerId, String reason
});




}
/// @nodoc
class _$RealtimePaymentFailedCopyWithImpl<$Res>
    implements $RealtimePaymentFailedCopyWith<$Res> {
  _$RealtimePaymentFailedCopyWithImpl(this._self, this._then);

  final RealtimePaymentFailed _self;
  final $Res Function(RealtimePaymentFailed) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? passengerId = null,Object? reason = null,}) {
  return _then(RealtimePaymentFailed(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,passengerId: null == passengerId ? _self.passengerId : passengerId // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RealtimeTripRefunded implements RealtimeEvent {
  const RealtimeTripRefunded({required this.tripId, required this.passengerId, required this.amount});
  

@override final  String tripId;
 final  String passengerId;
 final  double amount;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeTripRefundedCopyWith<RealtimeTripRefunded> get copyWith => _$RealtimeTripRefundedCopyWithImpl<RealtimeTripRefunded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeTripRefunded&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.passengerId, passengerId) || other.passengerId == passengerId)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,tripId,passengerId,amount);

@override
String toString() {
  return 'RealtimeEvent.tripRefunded(tripId: $tripId, passengerId: $passengerId, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $RealtimeTripRefundedCopyWith<$Res> implements $RealtimeEventCopyWith<$Res> {
  factory $RealtimeTripRefundedCopyWith(RealtimeTripRefunded value, $Res Function(RealtimeTripRefunded) _then) = _$RealtimeTripRefundedCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String passengerId, double amount
});




}
/// @nodoc
class _$RealtimeTripRefundedCopyWithImpl<$Res>
    implements $RealtimeTripRefundedCopyWith<$Res> {
  _$RealtimeTripRefundedCopyWithImpl(this._self, this._then);

  final RealtimeTripRefunded _self;
  final $Res Function(RealtimeTripRefunded) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? passengerId = null,Object? amount = null,}) {
  return _then(RealtimeTripRefunded(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,passengerId: null == passengerId ? _self.passengerId : passengerId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class RealtimeRefundLifecycleChanged implements RealtimeEvent {
  const RealtimeRefundLifecycleChanged({required this.refundId, required this.paymentId, this.tripId, this.passengerId, required this.status, required this.amount, required this.currency, required this.requiresAdminAction, required this.canRetry, required this.sourceType});
  

 final  String refundId;
 final  String paymentId;
@override final  String? tripId;
 final  String? passengerId;
 final  String status;
 final  double amount;
 final  String currency;
 final  bool requiresAdminAction;
 final  bool canRetry;
 final  String sourceType;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeRefundLifecycleChangedCopyWith<RealtimeRefundLifecycleChanged> get copyWith => _$RealtimeRefundLifecycleChangedCopyWithImpl<RealtimeRefundLifecycleChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeRefundLifecycleChanged&&(identical(other.refundId, refundId) || other.refundId == refundId)&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.passengerId, passengerId) || other.passengerId == passengerId)&&(identical(other.status, status) || other.status == status)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.requiresAdminAction, requiresAdminAction) || other.requiresAdminAction == requiresAdminAction)&&(identical(other.canRetry, canRetry) || other.canRetry == canRetry)&&(identical(other.sourceType, sourceType) || other.sourceType == sourceType));
}


@override
int get hashCode => Object.hash(runtimeType,refundId,paymentId,tripId,passengerId,status,amount,currency,requiresAdminAction,canRetry,sourceType);

@override
String toString() {
  return 'RealtimeEvent.refundLifecycleChanged(refundId: $refundId, paymentId: $paymentId, tripId: $tripId, passengerId: $passengerId, status: $status, amount: $amount, currency: $currency, requiresAdminAction: $requiresAdminAction, canRetry: $canRetry, sourceType: $sourceType)';
}


}

/// @nodoc
abstract mixin class $RealtimeRefundLifecycleChangedCopyWith<$Res> implements $RealtimeEventCopyWith<$Res> {
  factory $RealtimeRefundLifecycleChangedCopyWith(RealtimeRefundLifecycleChanged value, $Res Function(RealtimeRefundLifecycleChanged) _then) = _$RealtimeRefundLifecycleChangedCopyWithImpl;
@override @useResult
$Res call({
 String refundId, String paymentId, String? tripId, String? passengerId, String status, double amount, String currency, bool requiresAdminAction, bool canRetry, String sourceType
});




}
/// @nodoc
class _$RealtimeRefundLifecycleChangedCopyWithImpl<$Res>
    implements $RealtimeRefundLifecycleChangedCopyWith<$Res> {
  _$RealtimeRefundLifecycleChangedCopyWithImpl(this._self, this._then);

  final RealtimeRefundLifecycleChanged _self;
  final $Res Function(RealtimeRefundLifecycleChanged) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? refundId = null,Object? paymentId = null,Object? tripId = freezed,Object? passengerId = freezed,Object? status = null,Object? amount = null,Object? currency = null,Object? requiresAdminAction = null,Object? canRetry = null,Object? sourceType = null,}) {
  return _then(RealtimeRefundLifecycleChanged(
refundId: null == refundId ? _self.refundId : refundId // ignore: cast_nullable_to_non_nullable
as String,paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String,tripId: freezed == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String?,passengerId: freezed == passengerId ? _self.passengerId : passengerId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,requiresAdminAction: null == requiresAdminAction ? _self.requiresAdminAction : requiresAdminAction // ignore: cast_nullable_to_non_nullable
as bool,canRetry: null == canRetry ? _self.canRetry : canRetry // ignore: cast_nullable_to_non_nullable
as bool,sourceType: null == sourceType ? _self.sourceType : sourceType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RealtimeRefundIssueCreated implements RealtimeEvent {
  const RealtimeRefundIssueCreated({required this.refundIssueId, required this.tripId, required this.passengerId, this.paymentId, required this.requestType, required this.reviewStatus});
  

 final  String refundIssueId;
@override final  String tripId;
 final  String passengerId;
 final  String? paymentId;
 final  String requestType;
 final  String reviewStatus;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeRefundIssueCreatedCopyWith<RealtimeRefundIssueCreated> get copyWith => _$RealtimeRefundIssueCreatedCopyWithImpl<RealtimeRefundIssueCreated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeRefundIssueCreated&&(identical(other.refundIssueId, refundIssueId) || other.refundIssueId == refundIssueId)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.passengerId, passengerId) || other.passengerId == passengerId)&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.requestType, requestType) || other.requestType == requestType)&&(identical(other.reviewStatus, reviewStatus) || other.reviewStatus == reviewStatus));
}


@override
int get hashCode => Object.hash(runtimeType,refundIssueId,tripId,passengerId,paymentId,requestType,reviewStatus);

@override
String toString() {
  return 'RealtimeEvent.refundIssueCreated(refundIssueId: $refundIssueId, tripId: $tripId, passengerId: $passengerId, paymentId: $paymentId, requestType: $requestType, reviewStatus: $reviewStatus)';
}


}

/// @nodoc
abstract mixin class $RealtimeRefundIssueCreatedCopyWith<$Res> implements $RealtimeEventCopyWith<$Res> {
  factory $RealtimeRefundIssueCreatedCopyWith(RealtimeRefundIssueCreated value, $Res Function(RealtimeRefundIssueCreated) _then) = _$RealtimeRefundIssueCreatedCopyWithImpl;
@override @useResult
$Res call({
 String refundIssueId, String tripId, String passengerId, String? paymentId, String requestType, String reviewStatus
});




}
/// @nodoc
class _$RealtimeRefundIssueCreatedCopyWithImpl<$Res>
    implements $RealtimeRefundIssueCreatedCopyWith<$Res> {
  _$RealtimeRefundIssueCreatedCopyWithImpl(this._self, this._then);

  final RealtimeRefundIssueCreated _self;
  final $Res Function(RealtimeRefundIssueCreated) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? refundIssueId = null,Object? tripId = null,Object? passengerId = null,Object? paymentId = freezed,Object? requestType = null,Object? reviewStatus = null,}) {
  return _then(RealtimeRefundIssueCreated(
refundIssueId: null == refundIssueId ? _self.refundIssueId : refundIssueId // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,passengerId: null == passengerId ? _self.passengerId : passengerId // ignore: cast_nullable_to_non_nullable
as String,paymentId: freezed == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String?,requestType: null == requestType ? _self.requestType : requestType // ignore: cast_nullable_to_non_nullable
as String,reviewStatus: null == reviewStatus ? _self.reviewStatus : reviewStatus // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RealtimeDriverEnRoute implements RealtimeEvent {
  const RealtimeDriverEnRoute({required this.tripId, required this.passengerId, required this.driverId});
  

@override final  String tripId;
 final  String passengerId;
 final  String driverId;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeDriverEnRouteCopyWith<RealtimeDriverEnRoute> get copyWith => _$RealtimeDriverEnRouteCopyWithImpl<RealtimeDriverEnRoute>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeDriverEnRoute&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.passengerId, passengerId) || other.passengerId == passengerId)&&(identical(other.driverId, driverId) || other.driverId == driverId));
}


@override
int get hashCode => Object.hash(runtimeType,tripId,passengerId,driverId);

@override
String toString() {
  return 'RealtimeEvent.driverEnRoute(tripId: $tripId, passengerId: $passengerId, driverId: $driverId)';
}


}

/// @nodoc
abstract mixin class $RealtimeDriverEnRouteCopyWith<$Res> implements $RealtimeEventCopyWith<$Res> {
  factory $RealtimeDriverEnRouteCopyWith(RealtimeDriverEnRoute value, $Res Function(RealtimeDriverEnRoute) _then) = _$RealtimeDriverEnRouteCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String passengerId, String driverId
});




}
/// @nodoc
class _$RealtimeDriverEnRouteCopyWithImpl<$Res>
    implements $RealtimeDriverEnRouteCopyWith<$Res> {
  _$RealtimeDriverEnRouteCopyWithImpl(this._self, this._then);

  final RealtimeDriverEnRoute _self;
  final $Res Function(RealtimeDriverEnRoute) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? passengerId = null,Object? driverId = null,}) {
  return _then(RealtimeDriverEnRoute(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,passengerId: null == passengerId ? _self.passengerId : passengerId // ignore: cast_nullable_to_non_nullable
as String,driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RealtimeDriverArrived implements RealtimeEvent {
  const RealtimeDriverArrived({required this.tripId, required this.passengerId, required this.driverId});
  

@override final  String tripId;
 final  String passengerId;
 final  String driverId;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeDriverArrivedCopyWith<RealtimeDriverArrived> get copyWith => _$RealtimeDriverArrivedCopyWithImpl<RealtimeDriverArrived>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeDriverArrived&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.passengerId, passengerId) || other.passengerId == passengerId)&&(identical(other.driverId, driverId) || other.driverId == driverId));
}


@override
int get hashCode => Object.hash(runtimeType,tripId,passengerId,driverId);

@override
String toString() {
  return 'RealtimeEvent.driverArrived(tripId: $tripId, passengerId: $passengerId, driverId: $driverId)';
}


}

/// @nodoc
abstract mixin class $RealtimeDriverArrivedCopyWith<$Res> implements $RealtimeEventCopyWith<$Res> {
  factory $RealtimeDriverArrivedCopyWith(RealtimeDriverArrived value, $Res Function(RealtimeDriverArrived) _then) = _$RealtimeDriverArrivedCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String passengerId, String driverId
});




}
/// @nodoc
class _$RealtimeDriverArrivedCopyWithImpl<$Res>
    implements $RealtimeDriverArrivedCopyWith<$Res> {
  _$RealtimeDriverArrivedCopyWithImpl(this._self, this._then);

  final RealtimeDriverArrived _self;
  final $Res Function(RealtimeDriverArrived) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? passengerId = null,Object? driverId = null,}) {
  return _then(RealtimeDriverArrived(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,passengerId: null == passengerId ? _self.passengerId : passengerId // ignore: cast_nullable_to_non_nullable
as String,driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RealtimeDriverLocationUpdated implements RealtimeEvent {
  const RealtimeDriverLocationUpdated({required this.tripId, required this.driverId, required this.latitude, required this.longitude});
  

@override final  String tripId;
 final  String driverId;
 final  double latitude;
 final  double longitude;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeDriverLocationUpdatedCopyWith<RealtimeDriverLocationUpdated> get copyWith => _$RealtimeDriverLocationUpdatedCopyWithImpl<RealtimeDriverLocationUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeDriverLocationUpdated&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}


@override
int get hashCode => Object.hash(runtimeType,tripId,driverId,latitude,longitude);

@override
String toString() {
  return 'RealtimeEvent.driverLocationUpdated(tripId: $tripId, driverId: $driverId, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $RealtimeDriverLocationUpdatedCopyWith<$Res> implements $RealtimeEventCopyWith<$Res> {
  factory $RealtimeDriverLocationUpdatedCopyWith(RealtimeDriverLocationUpdated value, $Res Function(RealtimeDriverLocationUpdated) _then) = _$RealtimeDriverLocationUpdatedCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String driverId, double latitude, double longitude
});




}
/// @nodoc
class _$RealtimeDriverLocationUpdatedCopyWithImpl<$Res>
    implements $RealtimeDriverLocationUpdatedCopyWith<$Res> {
  _$RealtimeDriverLocationUpdatedCopyWithImpl(this._self, this._then);

  final RealtimeDriverLocationUpdated _self;
  final $Res Function(RealtimeDriverLocationUpdated) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? driverId = null,Object? latitude = null,Object? longitude = null,}) {
  return _then(RealtimeDriverLocationUpdated(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class RealtimeTripStopCompleted implements RealtimeEvent {
  const RealtimeTripStopCompleted({required this.tripId, required this.passengerId, this.driverId, required this.sequence});
  

@override final  String tripId;
 final  String passengerId;
 final  String? driverId;
 final  int sequence;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeTripStopCompletedCopyWith<RealtimeTripStopCompleted> get copyWith => _$RealtimeTripStopCompletedCopyWithImpl<RealtimeTripStopCompleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeTripStopCompleted&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.passengerId, passengerId) || other.passengerId == passengerId)&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.sequence, sequence) || other.sequence == sequence));
}


@override
int get hashCode => Object.hash(runtimeType,tripId,passengerId,driverId,sequence);

@override
String toString() {
  return 'RealtimeEvent.tripStopCompleted(tripId: $tripId, passengerId: $passengerId, driverId: $driverId, sequence: $sequence)';
}


}

/// @nodoc
abstract mixin class $RealtimeTripStopCompletedCopyWith<$Res> implements $RealtimeEventCopyWith<$Res> {
  factory $RealtimeTripStopCompletedCopyWith(RealtimeTripStopCompleted value, $Res Function(RealtimeTripStopCompleted) _then) = _$RealtimeTripStopCompletedCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String passengerId, String? driverId, int sequence
});




}
/// @nodoc
class _$RealtimeTripStopCompletedCopyWithImpl<$Res>
    implements $RealtimeTripStopCompletedCopyWith<$Res> {
  _$RealtimeTripStopCompletedCopyWithImpl(this._self, this._then);

  final RealtimeTripStopCompleted _self;
  final $Res Function(RealtimeTripStopCompleted) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? passengerId = null,Object? driverId = freezed,Object? sequence = null,}) {
  return _then(RealtimeTripStopCompleted(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,passengerId: null == passengerId ? _self.passengerId : passengerId // ignore: cast_nullable_to_non_nullable
as String,driverId: freezed == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String?,sequence: null == sequence ? _self.sequence : sequence // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class RealtimeTripMessageReceived implements RealtimeEvent {
  const RealtimeTripMessageReceived({required this.tripId, required this.messageId, required this.senderId, required this.senderRole, this.content, this.photoUrl, required this.sentAtUtc});
  

@override final  String tripId;
 final  String messageId;
 final  String senderId;
 final  String senderRole;
 final  String? content;
 final  String? photoUrl;
 final  String sentAtUtc;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeTripMessageReceivedCopyWith<RealtimeTripMessageReceived> get copyWith => _$RealtimeTripMessageReceivedCopyWithImpl<RealtimeTripMessageReceived>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeTripMessageReceived&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderRole, senderRole) || other.senderRole == senderRole)&&(identical(other.content, content) || other.content == content)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.sentAtUtc, sentAtUtc) || other.sentAtUtc == sentAtUtc));
}


@override
int get hashCode => Object.hash(runtimeType,tripId,messageId,senderId,senderRole,content,photoUrl,sentAtUtc);

@override
String toString() {
  return 'RealtimeEvent.tripMessageReceived(tripId: $tripId, messageId: $messageId, senderId: $senderId, senderRole: $senderRole, content: $content, photoUrl: $photoUrl, sentAtUtc: $sentAtUtc)';
}


}

/// @nodoc
abstract mixin class $RealtimeTripMessageReceivedCopyWith<$Res> implements $RealtimeEventCopyWith<$Res> {
  factory $RealtimeTripMessageReceivedCopyWith(RealtimeTripMessageReceived value, $Res Function(RealtimeTripMessageReceived) _then) = _$RealtimeTripMessageReceivedCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String messageId, String senderId, String senderRole, String? content, String? photoUrl, String sentAtUtc
});




}
/// @nodoc
class _$RealtimeTripMessageReceivedCopyWithImpl<$Res>
    implements $RealtimeTripMessageReceivedCopyWith<$Res> {
  _$RealtimeTripMessageReceivedCopyWithImpl(this._self, this._then);

  final RealtimeTripMessageReceived _self;
  final $Res Function(RealtimeTripMessageReceived) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? messageId = null,Object? senderId = null,Object? senderRole = null,Object? content = freezed,Object? photoUrl = freezed,Object? sentAtUtc = null,}) {
  return _then(RealtimeTripMessageReceived(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,senderRole: null == senderRole ? _self.senderRole : senderRole // ignore: cast_nullable_to_non_nullable
as String,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,sentAtUtc: null == sentAtUtc ? _self.sentAtUtc : sentAtUtc // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RealtimeChatClosed implements RealtimeEvent {
  const RealtimeChatClosed({required this.tripId});
  

@override final  String tripId;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeChatClosedCopyWith<RealtimeChatClosed> get copyWith => _$RealtimeChatClosedCopyWithImpl<RealtimeChatClosed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeChatClosed&&(identical(other.tripId, tripId) || other.tripId == tripId));
}


@override
int get hashCode => Object.hash(runtimeType,tripId);

@override
String toString() {
  return 'RealtimeEvent.chatClosed(tripId: $tripId)';
}


}

/// @nodoc
abstract mixin class $RealtimeChatClosedCopyWith<$Res> implements $RealtimeEventCopyWith<$Res> {
  factory $RealtimeChatClosedCopyWith(RealtimeChatClosed value, $Res Function(RealtimeChatClosed) _then) = _$RealtimeChatClosedCopyWithImpl;
@override @useResult
$Res call({
 String tripId
});




}
/// @nodoc
class _$RealtimeChatClosedCopyWithImpl<$Res>
    implements $RealtimeChatClosedCopyWith<$Res> {
  _$RealtimeChatClosedCopyWithImpl(this._self, this._then);

  final RealtimeChatClosed _self;
  final $Res Function(RealtimeChatClosed) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,}) {
  return _then(RealtimeChatClosed(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RealtimeCustomerIncidentRaised implements RealtimeEvent {
  const RealtimeCustomerIncidentRaised({required this.incidentId, required this.passengerId, required this.tripId, required this.type, required this.severity});
  

 final  String incidentId;
 final  String passengerId;
@override final  String tripId;
 final  String type;
 final  String severity;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeCustomerIncidentRaisedCopyWith<RealtimeCustomerIncidentRaised> get copyWith => _$RealtimeCustomerIncidentRaisedCopyWithImpl<RealtimeCustomerIncidentRaised>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeCustomerIncidentRaised&&(identical(other.incidentId, incidentId) || other.incidentId == incidentId)&&(identical(other.passengerId, passengerId) || other.passengerId == passengerId)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.type, type) || other.type == type)&&(identical(other.severity, severity) || other.severity == severity));
}


@override
int get hashCode => Object.hash(runtimeType,incidentId,passengerId,tripId,type,severity);

@override
String toString() {
  return 'RealtimeEvent.customerIncidentRaised(incidentId: $incidentId, passengerId: $passengerId, tripId: $tripId, type: $type, severity: $severity)';
}


}

/// @nodoc
abstract mixin class $RealtimeCustomerIncidentRaisedCopyWith<$Res> implements $RealtimeEventCopyWith<$Res> {
  factory $RealtimeCustomerIncidentRaisedCopyWith(RealtimeCustomerIncidentRaised value, $Res Function(RealtimeCustomerIncidentRaised) _then) = _$RealtimeCustomerIncidentRaisedCopyWithImpl;
@override @useResult
$Res call({
 String incidentId, String passengerId, String tripId, String type, String severity
});




}
/// @nodoc
class _$RealtimeCustomerIncidentRaisedCopyWithImpl<$Res>
    implements $RealtimeCustomerIncidentRaisedCopyWith<$Res> {
  _$RealtimeCustomerIncidentRaisedCopyWithImpl(this._self, this._then);

  final RealtimeCustomerIncidentRaised _self;
  final $Res Function(RealtimeCustomerIncidentRaised) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? incidentId = null,Object? passengerId = null,Object? tripId = null,Object? type = null,Object? severity = null,}) {
  return _then(RealtimeCustomerIncidentRaised(
incidentId: null == incidentId ? _self.incidentId : incidentId // ignore: cast_nullable_to_non_nullable
as String,passengerId: null == passengerId ? _self.passengerId : passengerId // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RealtimeTripDestinationChanged implements RealtimeEvent {
  const RealtimeTripDestinationChanged({required this.tripId, required this.passengerId, this.driverId, required this.newDropoffLatitude, required this.newDropoffLongitude, this.newDropoffLabel});
  

@override final  String tripId;
 final  String passengerId;
 final  String? driverId;
 final  double newDropoffLatitude;
 final  double newDropoffLongitude;
 final  String? newDropoffLabel;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeTripDestinationChangedCopyWith<RealtimeTripDestinationChanged> get copyWith => _$RealtimeTripDestinationChangedCopyWithImpl<RealtimeTripDestinationChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeTripDestinationChanged&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.passengerId, passengerId) || other.passengerId == passengerId)&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.newDropoffLatitude, newDropoffLatitude) || other.newDropoffLatitude == newDropoffLatitude)&&(identical(other.newDropoffLongitude, newDropoffLongitude) || other.newDropoffLongitude == newDropoffLongitude)&&(identical(other.newDropoffLabel, newDropoffLabel) || other.newDropoffLabel == newDropoffLabel));
}


@override
int get hashCode => Object.hash(runtimeType,tripId,passengerId,driverId,newDropoffLatitude,newDropoffLongitude,newDropoffLabel);

@override
String toString() {
  return 'RealtimeEvent.tripDestinationChanged(tripId: $tripId, passengerId: $passengerId, driverId: $driverId, newDropoffLatitude: $newDropoffLatitude, newDropoffLongitude: $newDropoffLongitude, newDropoffLabel: $newDropoffLabel)';
}


}

/// @nodoc
abstract mixin class $RealtimeTripDestinationChangedCopyWith<$Res> implements $RealtimeEventCopyWith<$Res> {
  factory $RealtimeTripDestinationChangedCopyWith(RealtimeTripDestinationChanged value, $Res Function(RealtimeTripDestinationChanged) _then) = _$RealtimeTripDestinationChangedCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String passengerId, String? driverId, double newDropoffLatitude, double newDropoffLongitude, String? newDropoffLabel
});




}
/// @nodoc
class _$RealtimeTripDestinationChangedCopyWithImpl<$Res>
    implements $RealtimeTripDestinationChangedCopyWith<$Res> {
  _$RealtimeTripDestinationChangedCopyWithImpl(this._self, this._then);

  final RealtimeTripDestinationChanged _self;
  final $Res Function(RealtimeTripDestinationChanged) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? passengerId = null,Object? driverId = freezed,Object? newDropoffLatitude = null,Object? newDropoffLongitude = null,Object? newDropoffLabel = freezed,}) {
  return _then(RealtimeTripDestinationChanged(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,passengerId: null == passengerId ? _self.passengerId : passengerId // ignore: cast_nullable_to_non_nullable
as String,driverId: freezed == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String?,newDropoffLatitude: null == newDropoffLatitude ? _self.newDropoffLatitude : newDropoffLatitude // ignore: cast_nullable_to_non_nullable
as double,newDropoffLongitude: null == newDropoffLongitude ? _self.newDropoffLongitude : newDropoffLongitude // ignore: cast_nullable_to_non_nullable
as double,newDropoffLabel: freezed == newDropoffLabel ? _self.newDropoffLabel : newDropoffLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class RealtimeTripEditApplied implements RealtimeEvent {
  const RealtimeTripEditApplied({required this.tripId, required this.passengerId, required this.newFare, required this.currency, required this.delta, required this.passengerCount, this.vehicleTypeName, this.dropoffLabel});
  

@override final  String tripId;
 final  String passengerId;
 final  double newFare;
 final  String currency;
 final  double delta;
 final  int passengerCount;
 final  String? vehicleTypeName;
 final  String? dropoffLabel;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeTripEditAppliedCopyWith<RealtimeTripEditApplied> get copyWith => _$RealtimeTripEditAppliedCopyWithImpl<RealtimeTripEditApplied>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeTripEditApplied&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.passengerId, passengerId) || other.passengerId == passengerId)&&(identical(other.newFare, newFare) || other.newFare == newFare)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.delta, delta) || other.delta == delta)&&(identical(other.passengerCount, passengerCount) || other.passengerCount == passengerCount)&&(identical(other.vehicleTypeName, vehicleTypeName) || other.vehicleTypeName == vehicleTypeName)&&(identical(other.dropoffLabel, dropoffLabel) || other.dropoffLabel == dropoffLabel));
}


@override
int get hashCode => Object.hash(runtimeType,tripId,passengerId,newFare,currency,delta,passengerCount,vehicleTypeName,dropoffLabel);

@override
String toString() {
  return 'RealtimeEvent.tripEditApplied(tripId: $tripId, passengerId: $passengerId, newFare: $newFare, currency: $currency, delta: $delta, passengerCount: $passengerCount, vehicleTypeName: $vehicleTypeName, dropoffLabel: $dropoffLabel)';
}


}

/// @nodoc
abstract mixin class $RealtimeTripEditAppliedCopyWith<$Res> implements $RealtimeEventCopyWith<$Res> {
  factory $RealtimeTripEditAppliedCopyWith(RealtimeTripEditApplied value, $Res Function(RealtimeTripEditApplied) _then) = _$RealtimeTripEditAppliedCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String passengerId, double newFare, String currency, double delta, int passengerCount, String? vehicleTypeName, String? dropoffLabel
});




}
/// @nodoc
class _$RealtimeTripEditAppliedCopyWithImpl<$Res>
    implements $RealtimeTripEditAppliedCopyWith<$Res> {
  _$RealtimeTripEditAppliedCopyWithImpl(this._self, this._then);

  final RealtimeTripEditApplied _self;
  final $Res Function(RealtimeTripEditApplied) _then;

/// Create a copy of RealtimeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? passengerId = null,Object? newFare = null,Object? currency = null,Object? delta = null,Object? passengerCount = null,Object? vehicleTypeName = freezed,Object? dropoffLabel = freezed,}) {
  return _then(RealtimeTripEditApplied(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,passengerId: null == passengerId ? _self.passengerId : passengerId // ignore: cast_nullable_to_non_nullable
as String,newFare: null == newFare ? _self.newFare : newFare // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,delta: null == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as double,passengerCount: null == passengerCount ? _self.passengerCount : passengerCount // ignore: cast_nullable_to_non_nullable
as int,vehicleTypeName: freezed == vehicleTypeName ? _self.vehicleTypeName : vehicleTypeName // ignore: cast_nullable_to_non_nullable
as String?,dropoffLabel: freezed == dropoffLabel ? _self.dropoffLabel : dropoffLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
