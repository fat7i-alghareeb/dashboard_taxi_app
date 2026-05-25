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

 String get tripId;
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
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RealtimeTripRequested value)?  tripRequested,TResult Function( RealtimeDriverAssigned value)?  driverAssigned,TResult Function( RealtimeTripStarted value)?  tripStarted,TResult Function( RealtimeTripCompleted value)?  tripCompleted,TResult Function( RealtimeTripCancelled value)?  tripCancelled,TResult Function( RealtimePaymentConfirmed value)?  paymentConfirmed,TResult Function( RealtimePaymentFailed value)?  paymentFailed,TResult Function( RealtimeTripRefunded value)?  tripRefunded,TResult Function( RealtimeDriverEnRoute value)?  driverEnRoute,TResult Function( RealtimeDriverArrived value)?  driverArrived,TResult Function( RealtimeDriverLocationUpdated value)?  driverLocationUpdated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RealtimeTripRequested() when tripRequested != null:
return tripRequested(_that);case RealtimeDriverAssigned() when driverAssigned != null:
return driverAssigned(_that);case RealtimeTripStarted() when tripStarted != null:
return tripStarted(_that);case RealtimeTripCompleted() when tripCompleted != null:
return tripCompleted(_that);case RealtimeTripCancelled() when tripCancelled != null:
return tripCancelled(_that);case RealtimePaymentConfirmed() when paymentConfirmed != null:
return paymentConfirmed(_that);case RealtimePaymentFailed() when paymentFailed != null:
return paymentFailed(_that);case RealtimeTripRefunded() when tripRefunded != null:
return tripRefunded(_that);case RealtimeDriverEnRoute() when driverEnRoute != null:
return driverEnRoute(_that);case RealtimeDriverArrived() when driverArrived != null:
return driverArrived(_that);case RealtimeDriverLocationUpdated() when driverLocationUpdated != null:
return driverLocationUpdated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RealtimeTripRequested value)  tripRequested,required TResult Function( RealtimeDriverAssigned value)  driverAssigned,required TResult Function( RealtimeTripStarted value)  tripStarted,required TResult Function( RealtimeTripCompleted value)  tripCompleted,required TResult Function( RealtimeTripCancelled value)  tripCancelled,required TResult Function( RealtimePaymentConfirmed value)  paymentConfirmed,required TResult Function( RealtimePaymentFailed value)  paymentFailed,required TResult Function( RealtimeTripRefunded value)  tripRefunded,required TResult Function( RealtimeDriverEnRoute value)  driverEnRoute,required TResult Function( RealtimeDriverArrived value)  driverArrived,required TResult Function( RealtimeDriverLocationUpdated value)  driverLocationUpdated,}){
final _that = this;
switch (_that) {
case RealtimeTripRequested():
return tripRequested(_that);case RealtimeDriverAssigned():
return driverAssigned(_that);case RealtimeTripStarted():
return tripStarted(_that);case RealtimeTripCompleted():
return tripCompleted(_that);case RealtimeTripCancelled():
return tripCancelled(_that);case RealtimePaymentConfirmed():
return paymentConfirmed(_that);case RealtimePaymentFailed():
return paymentFailed(_that);case RealtimeTripRefunded():
return tripRefunded(_that);case RealtimeDriverEnRoute():
return driverEnRoute(_that);case RealtimeDriverArrived():
return driverArrived(_that);case RealtimeDriverLocationUpdated():
return driverLocationUpdated(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RealtimeTripRequested value)?  tripRequested,TResult? Function( RealtimeDriverAssigned value)?  driverAssigned,TResult? Function( RealtimeTripStarted value)?  tripStarted,TResult? Function( RealtimeTripCompleted value)?  tripCompleted,TResult? Function( RealtimeTripCancelled value)?  tripCancelled,TResult? Function( RealtimePaymentConfirmed value)?  paymentConfirmed,TResult? Function( RealtimePaymentFailed value)?  paymentFailed,TResult? Function( RealtimeTripRefunded value)?  tripRefunded,TResult? Function( RealtimeDriverEnRoute value)?  driverEnRoute,TResult? Function( RealtimeDriverArrived value)?  driverArrived,TResult? Function( RealtimeDriverLocationUpdated value)?  driverLocationUpdated,}){
final _that = this;
switch (_that) {
case RealtimeTripRequested() when tripRequested != null:
return tripRequested(_that);case RealtimeDriverAssigned() when driverAssigned != null:
return driverAssigned(_that);case RealtimeTripStarted() when tripStarted != null:
return tripStarted(_that);case RealtimeTripCompleted() when tripCompleted != null:
return tripCompleted(_that);case RealtimeTripCancelled() when tripCancelled != null:
return tripCancelled(_that);case RealtimePaymentConfirmed() when paymentConfirmed != null:
return paymentConfirmed(_that);case RealtimePaymentFailed() when paymentFailed != null:
return paymentFailed(_that);case RealtimeTripRefunded() when tripRefunded != null:
return tripRefunded(_that);case RealtimeDriverEnRoute() when driverEnRoute != null:
return driverEnRoute(_that);case RealtimeDriverArrived() when driverArrived != null:
return driverArrived(_that);case RealtimeDriverLocationUpdated() when driverLocationUpdated != null:
return driverLocationUpdated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String tripId,  String vehicleTypeId,  String passengerId)?  tripRequested,TResult Function( String tripId,  String passengerId,  String driverId)?  driverAssigned,TResult Function( String tripId,  String passengerId)?  tripStarted,TResult Function( String tripId,  String passengerId)?  tripCompleted,TResult Function( String tripId,  String passengerId)?  tripCancelled,TResult Function( String tripId,  String passengerId)?  paymentConfirmed,TResult Function( String tripId,  String passengerId,  String reason)?  paymentFailed,TResult Function( String tripId,  String passengerId,  double amount)?  tripRefunded,TResult Function( String tripId,  String passengerId,  String driverId)?  driverEnRoute,TResult Function( String tripId,  String passengerId,  String driverId)?  driverArrived,TResult Function( String tripId,  String driverId,  double latitude,  double longitude)?  driverLocationUpdated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RealtimeTripRequested() when tripRequested != null:
return tripRequested(_that.tripId,_that.vehicleTypeId,_that.passengerId);case RealtimeDriverAssigned() when driverAssigned != null:
return driverAssigned(_that.tripId,_that.passengerId,_that.driverId);case RealtimeTripStarted() when tripStarted != null:
return tripStarted(_that.tripId,_that.passengerId);case RealtimeTripCompleted() when tripCompleted != null:
return tripCompleted(_that.tripId,_that.passengerId);case RealtimeTripCancelled() when tripCancelled != null:
return tripCancelled(_that.tripId,_that.passengerId);case RealtimePaymentConfirmed() when paymentConfirmed != null:
return paymentConfirmed(_that.tripId,_that.passengerId);case RealtimePaymentFailed() when paymentFailed != null:
return paymentFailed(_that.tripId,_that.passengerId,_that.reason);case RealtimeTripRefunded() when tripRefunded != null:
return tripRefunded(_that.tripId,_that.passengerId,_that.amount);case RealtimeDriverEnRoute() when driverEnRoute != null:
return driverEnRoute(_that.tripId,_that.passengerId,_that.driverId);case RealtimeDriverArrived() when driverArrived != null:
return driverArrived(_that.tripId,_that.passengerId,_that.driverId);case RealtimeDriverLocationUpdated() when driverLocationUpdated != null:
return driverLocationUpdated(_that.tripId,_that.driverId,_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String tripId,  String vehicleTypeId,  String passengerId)  tripRequested,required TResult Function( String tripId,  String passengerId,  String driverId)  driverAssigned,required TResult Function( String tripId,  String passengerId)  tripStarted,required TResult Function( String tripId,  String passengerId)  tripCompleted,required TResult Function( String tripId,  String passengerId)  tripCancelled,required TResult Function( String tripId,  String passengerId)  paymentConfirmed,required TResult Function( String tripId,  String passengerId,  String reason)  paymentFailed,required TResult Function( String tripId,  String passengerId,  double amount)  tripRefunded,required TResult Function( String tripId,  String passengerId,  String driverId)  driverEnRoute,required TResult Function( String tripId,  String passengerId,  String driverId)  driverArrived,required TResult Function( String tripId,  String driverId,  double latitude,  double longitude)  driverLocationUpdated,}) {final _that = this;
switch (_that) {
case RealtimeTripRequested():
return tripRequested(_that.tripId,_that.vehicleTypeId,_that.passengerId);case RealtimeDriverAssigned():
return driverAssigned(_that.tripId,_that.passengerId,_that.driverId);case RealtimeTripStarted():
return tripStarted(_that.tripId,_that.passengerId);case RealtimeTripCompleted():
return tripCompleted(_that.tripId,_that.passengerId);case RealtimeTripCancelled():
return tripCancelled(_that.tripId,_that.passengerId);case RealtimePaymentConfirmed():
return paymentConfirmed(_that.tripId,_that.passengerId);case RealtimePaymentFailed():
return paymentFailed(_that.tripId,_that.passengerId,_that.reason);case RealtimeTripRefunded():
return tripRefunded(_that.tripId,_that.passengerId,_that.amount);case RealtimeDriverEnRoute():
return driverEnRoute(_that.tripId,_that.passengerId,_that.driverId);case RealtimeDriverArrived():
return driverArrived(_that.tripId,_that.passengerId,_that.driverId);case RealtimeDriverLocationUpdated():
return driverLocationUpdated(_that.tripId,_that.driverId,_that.latitude,_that.longitude);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String tripId,  String vehicleTypeId,  String passengerId)?  tripRequested,TResult? Function( String tripId,  String passengerId,  String driverId)?  driverAssigned,TResult? Function( String tripId,  String passengerId)?  tripStarted,TResult? Function( String tripId,  String passengerId)?  tripCompleted,TResult? Function( String tripId,  String passengerId)?  tripCancelled,TResult? Function( String tripId,  String passengerId)?  paymentConfirmed,TResult? Function( String tripId,  String passengerId,  String reason)?  paymentFailed,TResult? Function( String tripId,  String passengerId,  double amount)?  tripRefunded,TResult? Function( String tripId,  String passengerId,  String driverId)?  driverEnRoute,TResult? Function( String tripId,  String passengerId,  String driverId)?  driverArrived,TResult? Function( String tripId,  String driverId,  double latitude,  double longitude)?  driverLocationUpdated,}) {final _that = this;
switch (_that) {
case RealtimeTripRequested() when tripRequested != null:
return tripRequested(_that.tripId,_that.vehicleTypeId,_that.passengerId);case RealtimeDriverAssigned() when driverAssigned != null:
return driverAssigned(_that.tripId,_that.passengerId,_that.driverId);case RealtimeTripStarted() when tripStarted != null:
return tripStarted(_that.tripId,_that.passengerId);case RealtimeTripCompleted() when tripCompleted != null:
return tripCompleted(_that.tripId,_that.passengerId);case RealtimeTripCancelled() when tripCancelled != null:
return tripCancelled(_that.tripId,_that.passengerId);case RealtimePaymentConfirmed() when paymentConfirmed != null:
return paymentConfirmed(_that.tripId,_that.passengerId);case RealtimePaymentFailed() when paymentFailed != null:
return paymentFailed(_that.tripId,_that.passengerId,_that.reason);case RealtimeTripRefunded() when tripRefunded != null:
return tripRefunded(_that.tripId,_that.passengerId,_that.amount);case RealtimeDriverEnRoute() when driverEnRoute != null:
return driverEnRoute(_that.tripId,_that.passengerId,_that.driverId);case RealtimeDriverArrived() when driverArrived != null:
return driverArrived(_that.tripId,_that.passengerId,_that.driverId);case RealtimeDriverLocationUpdated() when driverLocationUpdated != null:
return driverLocationUpdated(_that.tripId,_that.driverId,_that.latitude,_that.longitude);case _:
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

// dart format on
