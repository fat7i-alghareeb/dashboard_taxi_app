// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DashboardEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardEvent()';
}


}

/// @nodoc
class $DashboardEventCopyWith<$Res>  {
$DashboardEventCopyWith(DashboardEvent _, $Res Function(DashboardEvent) __);
}


/// Adds pattern-matching-related methods to [DashboardEvent].
extension DashboardEventPatterns on DashboardEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _OverviewRequested value)?  overviewRequested,TResult Function( _DriverDocumentsRequested value)?  driverDocumentsRequested,TResult Function( _DocumentReviewRequested value)?  documentReviewRequested,TResult Function( _DriverApprovalRequested value)?  driverApprovalRequested,TResult Function( _TripAssignmentRequested value)?  tripAssignmentRequested,TResult Function( _DriverLocationsRequested value)?  driverLocationsRequested,TResult Function( _DriverLocationReceived value)?  driverLocationReceived,TResult Function( _AdminTripsRequested value)?  adminTripsRequested,TResult Function( _TripDetailsRequested value)?  tripDetailsRequested,TResult Function( _AdminOperationsRequested value)?  adminOperationsRequested,TResult Function( _DriverSuspensionRequested value)?  driverSuspensionRequested,TResult Function( _DriverVehicleTypeAssignmentRequested value)?  driverVehicleTypeAssignmentRequested,TResult Function( _VehicleTypeStatusToggleRequested value)?  vehicleTypeStatusToggleRequested,TResult Function( _VehicleTypeRemovalRequested value)?  vehicleTypeRemovalRequested,TResult Function( _TripDiscountUpdateRequested value)?  tripDiscountUpdateRequested,TResult Function( _CurrencyUpdateRequested value)?  currencyUpdateRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _OverviewRequested() when overviewRequested != null:
return overviewRequested(_that);case _DriverDocumentsRequested() when driverDocumentsRequested != null:
return driverDocumentsRequested(_that);case _DocumentReviewRequested() when documentReviewRequested != null:
return documentReviewRequested(_that);case _DriverApprovalRequested() when driverApprovalRequested != null:
return driverApprovalRequested(_that);case _TripAssignmentRequested() when tripAssignmentRequested != null:
return tripAssignmentRequested(_that);case _DriverLocationsRequested() when driverLocationsRequested != null:
return driverLocationsRequested(_that);case _DriverLocationReceived() when driverLocationReceived != null:
return driverLocationReceived(_that);case _AdminTripsRequested() when adminTripsRequested != null:
return adminTripsRequested(_that);case _TripDetailsRequested() when tripDetailsRequested != null:
return tripDetailsRequested(_that);case _AdminOperationsRequested() when adminOperationsRequested != null:
return adminOperationsRequested(_that);case _DriverSuspensionRequested() when driverSuspensionRequested != null:
return driverSuspensionRequested(_that);case _DriverVehicleTypeAssignmentRequested() when driverVehicleTypeAssignmentRequested != null:
return driverVehicleTypeAssignmentRequested(_that);case _VehicleTypeStatusToggleRequested() when vehicleTypeStatusToggleRequested != null:
return vehicleTypeStatusToggleRequested(_that);case _VehicleTypeRemovalRequested() when vehicleTypeRemovalRequested != null:
return vehicleTypeRemovalRequested(_that);case _TripDiscountUpdateRequested() when tripDiscountUpdateRequested != null:
return tripDiscountUpdateRequested(_that);case _CurrencyUpdateRequested() when currencyUpdateRequested != null:
return currencyUpdateRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _OverviewRequested value)  overviewRequested,required TResult Function( _DriverDocumentsRequested value)  driverDocumentsRequested,required TResult Function( _DocumentReviewRequested value)  documentReviewRequested,required TResult Function( _DriverApprovalRequested value)  driverApprovalRequested,required TResult Function( _TripAssignmentRequested value)  tripAssignmentRequested,required TResult Function( _DriverLocationsRequested value)  driverLocationsRequested,required TResult Function( _DriverLocationReceived value)  driverLocationReceived,required TResult Function( _AdminTripsRequested value)  adminTripsRequested,required TResult Function( _TripDetailsRequested value)  tripDetailsRequested,required TResult Function( _AdminOperationsRequested value)  adminOperationsRequested,required TResult Function( _DriverSuspensionRequested value)  driverSuspensionRequested,required TResult Function( _DriverVehicleTypeAssignmentRequested value)  driverVehicleTypeAssignmentRequested,required TResult Function( _VehicleTypeStatusToggleRequested value)  vehicleTypeStatusToggleRequested,required TResult Function( _VehicleTypeRemovalRequested value)  vehicleTypeRemovalRequested,required TResult Function( _TripDiscountUpdateRequested value)  tripDiscountUpdateRequested,required TResult Function( _CurrencyUpdateRequested value)  currencyUpdateRequested,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _OverviewRequested():
return overviewRequested(_that);case _DriverDocumentsRequested():
return driverDocumentsRequested(_that);case _DocumentReviewRequested():
return documentReviewRequested(_that);case _DriverApprovalRequested():
return driverApprovalRequested(_that);case _TripAssignmentRequested():
return tripAssignmentRequested(_that);case _DriverLocationsRequested():
return driverLocationsRequested(_that);case _DriverLocationReceived():
return driverLocationReceived(_that);case _AdminTripsRequested():
return adminTripsRequested(_that);case _TripDetailsRequested():
return tripDetailsRequested(_that);case _AdminOperationsRequested():
return adminOperationsRequested(_that);case _DriverSuspensionRequested():
return driverSuspensionRequested(_that);case _DriverVehicleTypeAssignmentRequested():
return driverVehicleTypeAssignmentRequested(_that);case _VehicleTypeStatusToggleRequested():
return vehicleTypeStatusToggleRequested(_that);case _VehicleTypeRemovalRequested():
return vehicleTypeRemovalRequested(_that);case _TripDiscountUpdateRequested():
return tripDiscountUpdateRequested(_that);case _CurrencyUpdateRequested():
return currencyUpdateRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _OverviewRequested value)?  overviewRequested,TResult? Function( _DriverDocumentsRequested value)?  driverDocumentsRequested,TResult? Function( _DocumentReviewRequested value)?  documentReviewRequested,TResult? Function( _DriverApprovalRequested value)?  driverApprovalRequested,TResult? Function( _TripAssignmentRequested value)?  tripAssignmentRequested,TResult? Function( _DriverLocationsRequested value)?  driverLocationsRequested,TResult? Function( _DriverLocationReceived value)?  driverLocationReceived,TResult? Function( _AdminTripsRequested value)?  adminTripsRequested,TResult? Function( _TripDetailsRequested value)?  tripDetailsRequested,TResult? Function( _AdminOperationsRequested value)?  adminOperationsRequested,TResult? Function( _DriverSuspensionRequested value)?  driverSuspensionRequested,TResult? Function( _DriverVehicleTypeAssignmentRequested value)?  driverVehicleTypeAssignmentRequested,TResult? Function( _VehicleTypeStatusToggleRequested value)?  vehicleTypeStatusToggleRequested,TResult? Function( _VehicleTypeRemovalRequested value)?  vehicleTypeRemovalRequested,TResult? Function( _TripDiscountUpdateRequested value)?  tripDiscountUpdateRequested,TResult? Function( _CurrencyUpdateRequested value)?  currencyUpdateRequested,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _OverviewRequested() when overviewRequested != null:
return overviewRequested(_that);case _DriverDocumentsRequested() when driverDocumentsRequested != null:
return driverDocumentsRequested(_that);case _DocumentReviewRequested() when documentReviewRequested != null:
return documentReviewRequested(_that);case _DriverApprovalRequested() when driverApprovalRequested != null:
return driverApprovalRequested(_that);case _TripAssignmentRequested() when tripAssignmentRequested != null:
return tripAssignmentRequested(_that);case _DriverLocationsRequested() when driverLocationsRequested != null:
return driverLocationsRequested(_that);case _DriverLocationReceived() when driverLocationReceived != null:
return driverLocationReceived(_that);case _AdminTripsRequested() when adminTripsRequested != null:
return adminTripsRequested(_that);case _TripDetailsRequested() when tripDetailsRequested != null:
return tripDetailsRequested(_that);case _AdminOperationsRequested() when adminOperationsRequested != null:
return adminOperationsRequested(_that);case _DriverSuspensionRequested() when driverSuspensionRequested != null:
return driverSuspensionRequested(_that);case _DriverVehicleTypeAssignmentRequested() when driverVehicleTypeAssignmentRequested != null:
return driverVehicleTypeAssignmentRequested(_that);case _VehicleTypeStatusToggleRequested() when vehicleTypeStatusToggleRequested != null:
return vehicleTypeStatusToggleRequested(_that);case _VehicleTypeRemovalRequested() when vehicleTypeRemovalRequested != null:
return vehicleTypeRemovalRequested(_that);case _TripDiscountUpdateRequested() when tripDiscountUpdateRequested != null:
return tripDiscountUpdateRequested(_that);case _CurrencyUpdateRequested() when currencyUpdateRequested != null:
return currencyUpdateRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  overviewRequested,TResult Function( String driverId)?  driverDocumentsRequested,TResult Function( String driverId,  String documentId,  bool approved,  String? notes)?  documentReviewRequested,TResult Function( String driverId)?  driverApprovalRequested,TResult Function( String tripId,  String driverId,  bool enterDriverMode)?  tripAssignmentRequested,TResult Function()?  driverLocationsRequested,TResult Function( String driverId,  double latitude,  double longitude)?  driverLocationReceived,TResult Function( String? status)?  adminTripsRequested,TResult Function( String tripId)?  tripDetailsRequested,TResult Function()?  adminOperationsRequested,TResult Function( String driverId)?  driverSuspensionRequested,TResult Function( String driverId,  String vehicleTypeId)?  driverVehicleTypeAssignmentRequested,TResult Function( DashboardVehicleTypeEntity vehicleType)?  vehicleTypeStatusToggleRequested,TResult Function( String vehicleTypeId)?  vehicleTypeRemovalRequested,TResult Function( num discountPercent)?  tripDiscountUpdateRequested,TResult Function( String currencyCode)?  currencyUpdateRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _OverviewRequested() when overviewRequested != null:
return overviewRequested();case _DriverDocumentsRequested() when driverDocumentsRequested != null:
return driverDocumentsRequested(_that.driverId);case _DocumentReviewRequested() when documentReviewRequested != null:
return documentReviewRequested(_that.driverId,_that.documentId,_that.approved,_that.notes);case _DriverApprovalRequested() when driverApprovalRequested != null:
return driverApprovalRequested(_that.driverId);case _TripAssignmentRequested() when tripAssignmentRequested != null:
return tripAssignmentRequested(_that.tripId,_that.driverId,_that.enterDriverMode);case _DriverLocationsRequested() when driverLocationsRequested != null:
return driverLocationsRequested();case _DriverLocationReceived() when driverLocationReceived != null:
return driverLocationReceived(_that.driverId,_that.latitude,_that.longitude);case _AdminTripsRequested() when adminTripsRequested != null:
return adminTripsRequested(_that.status);case _TripDetailsRequested() when tripDetailsRequested != null:
return tripDetailsRequested(_that.tripId);case _AdminOperationsRequested() when adminOperationsRequested != null:
return adminOperationsRequested();case _DriverSuspensionRequested() when driverSuspensionRequested != null:
return driverSuspensionRequested(_that.driverId);case _DriverVehicleTypeAssignmentRequested() when driverVehicleTypeAssignmentRequested != null:
return driverVehicleTypeAssignmentRequested(_that.driverId,_that.vehicleTypeId);case _VehicleTypeStatusToggleRequested() when vehicleTypeStatusToggleRequested != null:
return vehicleTypeStatusToggleRequested(_that.vehicleType);case _VehicleTypeRemovalRequested() when vehicleTypeRemovalRequested != null:
return vehicleTypeRemovalRequested(_that.vehicleTypeId);case _TripDiscountUpdateRequested() when tripDiscountUpdateRequested != null:
return tripDiscountUpdateRequested(_that.discountPercent);case _CurrencyUpdateRequested() when currencyUpdateRequested != null:
return currencyUpdateRequested(_that.currencyCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  overviewRequested,required TResult Function( String driverId)  driverDocumentsRequested,required TResult Function( String driverId,  String documentId,  bool approved,  String? notes)  documentReviewRequested,required TResult Function( String driverId)  driverApprovalRequested,required TResult Function( String tripId,  String driverId,  bool enterDriverMode)  tripAssignmentRequested,required TResult Function()  driverLocationsRequested,required TResult Function( String driverId,  double latitude,  double longitude)  driverLocationReceived,required TResult Function( String? status)  adminTripsRequested,required TResult Function( String tripId)  tripDetailsRequested,required TResult Function()  adminOperationsRequested,required TResult Function( String driverId)  driverSuspensionRequested,required TResult Function( String driverId,  String vehicleTypeId)  driverVehicleTypeAssignmentRequested,required TResult Function( DashboardVehicleTypeEntity vehicleType)  vehicleTypeStatusToggleRequested,required TResult Function( String vehicleTypeId)  vehicleTypeRemovalRequested,required TResult Function( num discountPercent)  tripDiscountUpdateRequested,required TResult Function( String currencyCode)  currencyUpdateRequested,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _OverviewRequested():
return overviewRequested();case _DriverDocumentsRequested():
return driverDocumentsRequested(_that.driverId);case _DocumentReviewRequested():
return documentReviewRequested(_that.driverId,_that.documentId,_that.approved,_that.notes);case _DriverApprovalRequested():
return driverApprovalRequested(_that.driverId);case _TripAssignmentRequested():
return tripAssignmentRequested(_that.tripId,_that.driverId,_that.enterDriverMode);case _DriverLocationsRequested():
return driverLocationsRequested();case _DriverLocationReceived():
return driverLocationReceived(_that.driverId,_that.latitude,_that.longitude);case _AdminTripsRequested():
return adminTripsRequested(_that.status);case _TripDetailsRequested():
return tripDetailsRequested(_that.tripId);case _AdminOperationsRequested():
return adminOperationsRequested();case _DriverSuspensionRequested():
return driverSuspensionRequested(_that.driverId);case _DriverVehicleTypeAssignmentRequested():
return driverVehicleTypeAssignmentRequested(_that.driverId,_that.vehicleTypeId);case _VehicleTypeStatusToggleRequested():
return vehicleTypeStatusToggleRequested(_that.vehicleType);case _VehicleTypeRemovalRequested():
return vehicleTypeRemovalRequested(_that.vehicleTypeId);case _TripDiscountUpdateRequested():
return tripDiscountUpdateRequested(_that.discountPercent);case _CurrencyUpdateRequested():
return currencyUpdateRequested(_that.currencyCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  overviewRequested,TResult? Function( String driverId)?  driverDocumentsRequested,TResult? Function( String driverId,  String documentId,  bool approved,  String? notes)?  documentReviewRequested,TResult? Function( String driverId)?  driverApprovalRequested,TResult? Function( String tripId,  String driverId,  bool enterDriverMode)?  tripAssignmentRequested,TResult? Function()?  driverLocationsRequested,TResult? Function( String driverId,  double latitude,  double longitude)?  driverLocationReceived,TResult? Function( String? status)?  adminTripsRequested,TResult? Function( String tripId)?  tripDetailsRequested,TResult? Function()?  adminOperationsRequested,TResult? Function( String driverId)?  driverSuspensionRequested,TResult? Function( String driverId,  String vehicleTypeId)?  driverVehicleTypeAssignmentRequested,TResult? Function( DashboardVehicleTypeEntity vehicleType)?  vehicleTypeStatusToggleRequested,TResult? Function( String vehicleTypeId)?  vehicleTypeRemovalRequested,TResult? Function( num discountPercent)?  tripDiscountUpdateRequested,TResult? Function( String currencyCode)?  currencyUpdateRequested,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _OverviewRequested() when overviewRequested != null:
return overviewRequested();case _DriverDocumentsRequested() when driverDocumentsRequested != null:
return driverDocumentsRequested(_that.driverId);case _DocumentReviewRequested() when documentReviewRequested != null:
return documentReviewRequested(_that.driverId,_that.documentId,_that.approved,_that.notes);case _DriverApprovalRequested() when driverApprovalRequested != null:
return driverApprovalRequested(_that.driverId);case _TripAssignmentRequested() when tripAssignmentRequested != null:
return tripAssignmentRequested(_that.tripId,_that.driverId,_that.enterDriverMode);case _DriverLocationsRequested() when driverLocationsRequested != null:
return driverLocationsRequested();case _DriverLocationReceived() when driverLocationReceived != null:
return driverLocationReceived(_that.driverId,_that.latitude,_that.longitude);case _AdminTripsRequested() when adminTripsRequested != null:
return adminTripsRequested(_that.status);case _TripDetailsRequested() when tripDetailsRequested != null:
return tripDetailsRequested(_that.tripId);case _AdminOperationsRequested() when adminOperationsRequested != null:
return adminOperationsRequested();case _DriverSuspensionRequested() when driverSuspensionRequested != null:
return driverSuspensionRequested(_that.driverId);case _DriverVehicleTypeAssignmentRequested() when driverVehicleTypeAssignmentRequested != null:
return driverVehicleTypeAssignmentRequested(_that.driverId,_that.vehicleTypeId);case _VehicleTypeStatusToggleRequested() when vehicleTypeStatusToggleRequested != null:
return vehicleTypeStatusToggleRequested(_that.vehicleType);case _VehicleTypeRemovalRequested() when vehicleTypeRemovalRequested != null:
return vehicleTypeRemovalRequested(_that.vehicleTypeId);case _TripDiscountUpdateRequested() when tripDiscountUpdateRequested != null:
return tripDiscountUpdateRequested(_that.discountPercent);case _CurrencyUpdateRequested() when currencyUpdateRequested != null:
return currencyUpdateRequested(_that.currencyCode);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements DashboardEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardEvent.started()';
}


}




/// @nodoc


class _OverviewRequested implements DashboardEvent {
  const _OverviewRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OverviewRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardEvent.overviewRequested()';
}


}




/// @nodoc


class _DriverDocumentsRequested implements DashboardEvent {
  const _DriverDocumentsRequested(this.driverId);
  

 final  String driverId;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriverDocumentsRequestedCopyWith<_DriverDocumentsRequested> get copyWith => __$DriverDocumentsRequestedCopyWithImpl<_DriverDocumentsRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriverDocumentsRequested&&(identical(other.driverId, driverId) || other.driverId == driverId));
}


@override
int get hashCode => Object.hash(runtimeType,driverId);

@override
String toString() {
  return 'DashboardEvent.driverDocumentsRequested(driverId: $driverId)';
}


}

/// @nodoc
abstract mixin class _$DriverDocumentsRequestedCopyWith<$Res> implements $DashboardEventCopyWith<$Res> {
  factory _$DriverDocumentsRequestedCopyWith(_DriverDocumentsRequested value, $Res Function(_DriverDocumentsRequested) _then) = __$DriverDocumentsRequestedCopyWithImpl;
@useResult
$Res call({
 String driverId
});




}
/// @nodoc
class __$DriverDocumentsRequestedCopyWithImpl<$Res>
    implements _$DriverDocumentsRequestedCopyWith<$Res> {
  __$DriverDocumentsRequestedCopyWithImpl(this._self, this._then);

  final _DriverDocumentsRequested _self;
  final $Res Function(_DriverDocumentsRequested) _then;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? driverId = null,}) {
  return _then(_DriverDocumentsRequested(
null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _DocumentReviewRequested implements DashboardEvent {
  const _DocumentReviewRequested({required this.driverId, required this.documentId, required this.approved, this.notes});
  

 final  String driverId;
 final  String documentId;
 final  bool approved;
 final  String? notes;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentReviewRequestedCopyWith<_DocumentReviewRequested> get copyWith => __$DocumentReviewRequestedCopyWithImpl<_DocumentReviewRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocumentReviewRequested&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.documentId, documentId) || other.documentId == documentId)&&(identical(other.approved, approved) || other.approved == approved)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode => Object.hash(runtimeType,driverId,documentId,approved,notes);

@override
String toString() {
  return 'DashboardEvent.documentReviewRequested(driverId: $driverId, documentId: $documentId, approved: $approved, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$DocumentReviewRequestedCopyWith<$Res> implements $DashboardEventCopyWith<$Res> {
  factory _$DocumentReviewRequestedCopyWith(_DocumentReviewRequested value, $Res Function(_DocumentReviewRequested) _then) = __$DocumentReviewRequestedCopyWithImpl;
@useResult
$Res call({
 String driverId, String documentId, bool approved, String? notes
});




}
/// @nodoc
class __$DocumentReviewRequestedCopyWithImpl<$Res>
    implements _$DocumentReviewRequestedCopyWith<$Res> {
  __$DocumentReviewRequestedCopyWithImpl(this._self, this._then);

  final _DocumentReviewRequested _self;
  final $Res Function(_DocumentReviewRequested) _then;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? driverId = null,Object? documentId = null,Object? approved = null,Object? notes = freezed,}) {
  return _then(_DocumentReviewRequested(
driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,documentId: null == documentId ? _self.documentId : documentId // ignore: cast_nullable_to_non_nullable
as String,approved: null == approved ? _self.approved : approved // ignore: cast_nullable_to_non_nullable
as bool,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _DriverApprovalRequested implements DashboardEvent {
  const _DriverApprovalRequested(this.driverId);
  

 final  String driverId;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriverApprovalRequestedCopyWith<_DriverApprovalRequested> get copyWith => __$DriverApprovalRequestedCopyWithImpl<_DriverApprovalRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriverApprovalRequested&&(identical(other.driverId, driverId) || other.driverId == driverId));
}


@override
int get hashCode => Object.hash(runtimeType,driverId);

@override
String toString() {
  return 'DashboardEvent.driverApprovalRequested(driverId: $driverId)';
}


}

/// @nodoc
abstract mixin class _$DriverApprovalRequestedCopyWith<$Res> implements $DashboardEventCopyWith<$Res> {
  factory _$DriverApprovalRequestedCopyWith(_DriverApprovalRequested value, $Res Function(_DriverApprovalRequested) _then) = __$DriverApprovalRequestedCopyWithImpl;
@useResult
$Res call({
 String driverId
});




}
/// @nodoc
class __$DriverApprovalRequestedCopyWithImpl<$Res>
    implements _$DriverApprovalRequestedCopyWith<$Res> {
  __$DriverApprovalRequestedCopyWithImpl(this._self, this._then);

  final _DriverApprovalRequested _self;
  final $Res Function(_DriverApprovalRequested) _then;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? driverId = null,}) {
  return _then(_DriverApprovalRequested(
null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _TripAssignmentRequested implements DashboardEvent {
  const _TripAssignmentRequested({required this.tripId, required this.driverId, this.enterDriverMode = false});
  

 final  String tripId;
 final  String driverId;
@JsonKey() final  bool enterDriverMode;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripAssignmentRequestedCopyWith<_TripAssignmentRequested> get copyWith => __$TripAssignmentRequestedCopyWithImpl<_TripAssignmentRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripAssignmentRequested&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.enterDriverMode, enterDriverMode) || other.enterDriverMode == enterDriverMode));
}


@override
int get hashCode => Object.hash(runtimeType,tripId,driverId,enterDriverMode);

@override
String toString() {
  return 'DashboardEvent.tripAssignmentRequested(tripId: $tripId, driverId: $driverId, enterDriverMode: $enterDriverMode)';
}


}

/// @nodoc
abstract mixin class _$TripAssignmentRequestedCopyWith<$Res> implements $DashboardEventCopyWith<$Res> {
  factory _$TripAssignmentRequestedCopyWith(_TripAssignmentRequested value, $Res Function(_TripAssignmentRequested) _then) = __$TripAssignmentRequestedCopyWithImpl;
@useResult
$Res call({
 String tripId, String driverId, bool enterDriverMode
});




}
/// @nodoc
class __$TripAssignmentRequestedCopyWithImpl<$Res>
    implements _$TripAssignmentRequestedCopyWith<$Res> {
  __$TripAssignmentRequestedCopyWithImpl(this._self, this._then);

  final _TripAssignmentRequested _self;
  final $Res Function(_TripAssignmentRequested) _then;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? driverId = null,Object? enterDriverMode = null,}) {
  return _then(_TripAssignmentRequested(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,enterDriverMode: null == enterDriverMode ? _self.enterDriverMode : enterDriverMode // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _DriverLocationsRequested implements DashboardEvent {
  const _DriverLocationsRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriverLocationsRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardEvent.driverLocationsRequested()';
}


}




/// @nodoc


class _DriverLocationReceived implements DashboardEvent {
  const _DriverLocationReceived({required this.driverId, required this.latitude, required this.longitude});
  

 final  String driverId;
 final  double latitude;
 final  double longitude;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriverLocationReceivedCopyWith<_DriverLocationReceived> get copyWith => __$DriverLocationReceivedCopyWithImpl<_DriverLocationReceived>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriverLocationReceived&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}


@override
int get hashCode => Object.hash(runtimeType,driverId,latitude,longitude);

@override
String toString() {
  return 'DashboardEvent.driverLocationReceived(driverId: $driverId, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$DriverLocationReceivedCopyWith<$Res> implements $DashboardEventCopyWith<$Res> {
  factory _$DriverLocationReceivedCopyWith(_DriverLocationReceived value, $Res Function(_DriverLocationReceived) _then) = __$DriverLocationReceivedCopyWithImpl;
@useResult
$Res call({
 String driverId, double latitude, double longitude
});




}
/// @nodoc
class __$DriverLocationReceivedCopyWithImpl<$Res>
    implements _$DriverLocationReceivedCopyWith<$Res> {
  __$DriverLocationReceivedCopyWithImpl(this._self, this._then);

  final _DriverLocationReceived _self;
  final $Res Function(_DriverLocationReceived) _then;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? driverId = null,Object? latitude = null,Object? longitude = null,}) {
  return _then(_DriverLocationReceived(
driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class _AdminTripsRequested implements DashboardEvent {
  const _AdminTripsRequested({this.status});
  

 final  String? status;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminTripsRequestedCopyWith<_AdminTripsRequested> get copyWith => __$AdminTripsRequestedCopyWithImpl<_AdminTripsRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminTripsRequested&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'DashboardEvent.adminTripsRequested(status: $status)';
}


}

/// @nodoc
abstract mixin class _$AdminTripsRequestedCopyWith<$Res> implements $DashboardEventCopyWith<$Res> {
  factory _$AdminTripsRequestedCopyWith(_AdminTripsRequested value, $Res Function(_AdminTripsRequested) _then) = __$AdminTripsRequestedCopyWithImpl;
@useResult
$Res call({
 String? status
});




}
/// @nodoc
class __$AdminTripsRequestedCopyWithImpl<$Res>
    implements _$AdminTripsRequestedCopyWith<$Res> {
  __$AdminTripsRequestedCopyWithImpl(this._self, this._then);

  final _AdminTripsRequested _self;
  final $Res Function(_AdminTripsRequested) _then;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? status = freezed,}) {
  return _then(_AdminTripsRequested(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _TripDetailsRequested implements DashboardEvent {
  const _TripDetailsRequested(this.tripId);
  

 final  String tripId;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripDetailsRequestedCopyWith<_TripDetailsRequested> get copyWith => __$TripDetailsRequestedCopyWithImpl<_TripDetailsRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripDetailsRequested&&(identical(other.tripId, tripId) || other.tripId == tripId));
}


@override
int get hashCode => Object.hash(runtimeType,tripId);

@override
String toString() {
  return 'DashboardEvent.tripDetailsRequested(tripId: $tripId)';
}


}

/// @nodoc
abstract mixin class _$TripDetailsRequestedCopyWith<$Res> implements $DashboardEventCopyWith<$Res> {
  factory _$TripDetailsRequestedCopyWith(_TripDetailsRequested value, $Res Function(_TripDetailsRequested) _then) = __$TripDetailsRequestedCopyWithImpl;
@useResult
$Res call({
 String tripId
});




}
/// @nodoc
class __$TripDetailsRequestedCopyWithImpl<$Res>
    implements _$TripDetailsRequestedCopyWith<$Res> {
  __$TripDetailsRequestedCopyWithImpl(this._self, this._then);

  final _TripDetailsRequested _self;
  final $Res Function(_TripDetailsRequested) _then;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tripId = null,}) {
  return _then(_TripDetailsRequested(
null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _AdminOperationsRequested implements DashboardEvent {
  const _AdminOperationsRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminOperationsRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardEvent.adminOperationsRequested()';
}


}




/// @nodoc


class _DriverSuspensionRequested implements DashboardEvent {
  const _DriverSuspensionRequested(this.driverId);
  

 final  String driverId;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriverSuspensionRequestedCopyWith<_DriverSuspensionRequested> get copyWith => __$DriverSuspensionRequestedCopyWithImpl<_DriverSuspensionRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriverSuspensionRequested&&(identical(other.driverId, driverId) || other.driverId == driverId));
}


@override
int get hashCode => Object.hash(runtimeType,driverId);

@override
String toString() {
  return 'DashboardEvent.driverSuspensionRequested(driverId: $driverId)';
}


}

/// @nodoc
abstract mixin class _$DriverSuspensionRequestedCopyWith<$Res> implements $DashboardEventCopyWith<$Res> {
  factory _$DriverSuspensionRequestedCopyWith(_DriverSuspensionRequested value, $Res Function(_DriverSuspensionRequested) _then) = __$DriverSuspensionRequestedCopyWithImpl;
@useResult
$Res call({
 String driverId
});




}
/// @nodoc
class __$DriverSuspensionRequestedCopyWithImpl<$Res>
    implements _$DriverSuspensionRequestedCopyWith<$Res> {
  __$DriverSuspensionRequestedCopyWithImpl(this._self, this._then);

  final _DriverSuspensionRequested _self;
  final $Res Function(_DriverSuspensionRequested) _then;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? driverId = null,}) {
  return _then(_DriverSuspensionRequested(
null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _DriverVehicleTypeAssignmentRequested implements DashboardEvent {
  const _DriverVehicleTypeAssignmentRequested({required this.driverId, required this.vehicleTypeId});
  

 final  String driverId;
 final  String vehicleTypeId;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriverVehicleTypeAssignmentRequestedCopyWith<_DriverVehicleTypeAssignmentRequested> get copyWith => __$DriverVehicleTypeAssignmentRequestedCopyWithImpl<_DriverVehicleTypeAssignmentRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriverVehicleTypeAssignmentRequested&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.vehicleTypeId, vehicleTypeId) || other.vehicleTypeId == vehicleTypeId));
}


@override
int get hashCode => Object.hash(runtimeType,driverId,vehicleTypeId);

@override
String toString() {
  return 'DashboardEvent.driverVehicleTypeAssignmentRequested(driverId: $driverId, vehicleTypeId: $vehicleTypeId)';
}


}

/// @nodoc
abstract mixin class _$DriverVehicleTypeAssignmentRequestedCopyWith<$Res> implements $DashboardEventCopyWith<$Res> {
  factory _$DriverVehicleTypeAssignmentRequestedCopyWith(_DriverVehicleTypeAssignmentRequested value, $Res Function(_DriverVehicleTypeAssignmentRequested) _then) = __$DriverVehicleTypeAssignmentRequestedCopyWithImpl;
@useResult
$Res call({
 String driverId, String vehicleTypeId
});




}
/// @nodoc
class __$DriverVehicleTypeAssignmentRequestedCopyWithImpl<$Res>
    implements _$DriverVehicleTypeAssignmentRequestedCopyWith<$Res> {
  __$DriverVehicleTypeAssignmentRequestedCopyWithImpl(this._self, this._then);

  final _DriverVehicleTypeAssignmentRequested _self;
  final $Res Function(_DriverVehicleTypeAssignmentRequested) _then;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? driverId = null,Object? vehicleTypeId = null,}) {
  return _then(_DriverVehicleTypeAssignmentRequested(
driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,vehicleTypeId: null == vehicleTypeId ? _self.vehicleTypeId : vehicleTypeId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _VehicleTypeStatusToggleRequested implements DashboardEvent {
  const _VehicleTypeStatusToggleRequested(this.vehicleType);
  

 final  DashboardVehicleTypeEntity vehicleType;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VehicleTypeStatusToggleRequestedCopyWith<_VehicleTypeStatusToggleRequested> get copyWith => __$VehicleTypeStatusToggleRequestedCopyWithImpl<_VehicleTypeStatusToggleRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VehicleTypeStatusToggleRequested&&(identical(other.vehicleType, vehicleType) || other.vehicleType == vehicleType));
}


@override
int get hashCode => Object.hash(runtimeType,vehicleType);

@override
String toString() {
  return 'DashboardEvent.vehicleTypeStatusToggleRequested(vehicleType: $vehicleType)';
}


}

/// @nodoc
abstract mixin class _$VehicleTypeStatusToggleRequestedCopyWith<$Res> implements $DashboardEventCopyWith<$Res> {
  factory _$VehicleTypeStatusToggleRequestedCopyWith(_VehicleTypeStatusToggleRequested value, $Res Function(_VehicleTypeStatusToggleRequested) _then) = __$VehicleTypeStatusToggleRequestedCopyWithImpl;
@useResult
$Res call({
 DashboardVehicleTypeEntity vehicleType
});




}
/// @nodoc
class __$VehicleTypeStatusToggleRequestedCopyWithImpl<$Res>
    implements _$VehicleTypeStatusToggleRequestedCopyWith<$Res> {
  __$VehicleTypeStatusToggleRequestedCopyWithImpl(this._self, this._then);

  final _VehicleTypeStatusToggleRequested _self;
  final $Res Function(_VehicleTypeStatusToggleRequested) _then;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? vehicleType = null,}) {
  return _then(_VehicleTypeStatusToggleRequested(
null == vehicleType ? _self.vehicleType : vehicleType // ignore: cast_nullable_to_non_nullable
as DashboardVehicleTypeEntity,
  ));
}


}

/// @nodoc


class _VehicleTypeRemovalRequested implements DashboardEvent {
  const _VehicleTypeRemovalRequested(this.vehicleTypeId);
  

 final  String vehicleTypeId;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VehicleTypeRemovalRequestedCopyWith<_VehicleTypeRemovalRequested> get copyWith => __$VehicleTypeRemovalRequestedCopyWithImpl<_VehicleTypeRemovalRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VehicleTypeRemovalRequested&&(identical(other.vehicleTypeId, vehicleTypeId) || other.vehicleTypeId == vehicleTypeId));
}


@override
int get hashCode => Object.hash(runtimeType,vehicleTypeId);

@override
String toString() {
  return 'DashboardEvent.vehicleTypeRemovalRequested(vehicleTypeId: $vehicleTypeId)';
}


}

/// @nodoc
abstract mixin class _$VehicleTypeRemovalRequestedCopyWith<$Res> implements $DashboardEventCopyWith<$Res> {
  factory _$VehicleTypeRemovalRequestedCopyWith(_VehicleTypeRemovalRequested value, $Res Function(_VehicleTypeRemovalRequested) _then) = __$VehicleTypeRemovalRequestedCopyWithImpl;
@useResult
$Res call({
 String vehicleTypeId
});




}
/// @nodoc
class __$VehicleTypeRemovalRequestedCopyWithImpl<$Res>
    implements _$VehicleTypeRemovalRequestedCopyWith<$Res> {
  __$VehicleTypeRemovalRequestedCopyWithImpl(this._self, this._then);

  final _VehicleTypeRemovalRequested _self;
  final $Res Function(_VehicleTypeRemovalRequested) _then;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? vehicleTypeId = null,}) {
  return _then(_VehicleTypeRemovalRequested(
null == vehicleTypeId ? _self.vehicleTypeId : vehicleTypeId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _TripDiscountUpdateRequested implements DashboardEvent {
  const _TripDiscountUpdateRequested(this.discountPercent);
  

 final  num discountPercent;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripDiscountUpdateRequestedCopyWith<_TripDiscountUpdateRequested> get copyWith => __$TripDiscountUpdateRequestedCopyWithImpl<_TripDiscountUpdateRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripDiscountUpdateRequested&&(identical(other.discountPercent, discountPercent) || other.discountPercent == discountPercent));
}


@override
int get hashCode => Object.hash(runtimeType,discountPercent);

@override
String toString() {
  return 'DashboardEvent.tripDiscountUpdateRequested(discountPercent: $discountPercent)';
}


}

/// @nodoc
abstract mixin class _$TripDiscountUpdateRequestedCopyWith<$Res> implements $DashboardEventCopyWith<$Res> {
  factory _$TripDiscountUpdateRequestedCopyWith(_TripDiscountUpdateRequested value, $Res Function(_TripDiscountUpdateRequested) _then) = __$TripDiscountUpdateRequestedCopyWithImpl;
@useResult
$Res call({
 num discountPercent
});




}
/// @nodoc
class __$TripDiscountUpdateRequestedCopyWithImpl<$Res>
    implements _$TripDiscountUpdateRequestedCopyWith<$Res> {
  __$TripDiscountUpdateRequestedCopyWithImpl(this._self, this._then);

  final _TripDiscountUpdateRequested _self;
  final $Res Function(_TripDiscountUpdateRequested) _then;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? discountPercent = null,}) {
  return _then(_TripDiscountUpdateRequested(
null == discountPercent ? _self.discountPercent : discountPercent // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}

/// @nodoc


class _CurrencyUpdateRequested implements DashboardEvent {
  const _CurrencyUpdateRequested(this.currencyCode);
  

 final  String currencyCode;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrencyUpdateRequestedCopyWith<_CurrencyUpdateRequested> get copyWith => __$CurrencyUpdateRequestedCopyWithImpl<_CurrencyUpdateRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrencyUpdateRequested&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode));
}


@override
int get hashCode => Object.hash(runtimeType,currencyCode);

@override
String toString() {
  return 'DashboardEvent.currencyUpdateRequested(currencyCode: $currencyCode)';
}


}

/// @nodoc
abstract mixin class _$CurrencyUpdateRequestedCopyWith<$Res> implements $DashboardEventCopyWith<$Res> {
  factory _$CurrencyUpdateRequestedCopyWith(_CurrencyUpdateRequested value, $Res Function(_CurrencyUpdateRequested) _then) = __$CurrencyUpdateRequestedCopyWithImpl;
@useResult
$Res call({
 String currencyCode
});




}
/// @nodoc
class __$CurrencyUpdateRequestedCopyWithImpl<$Res>
    implements _$CurrencyUpdateRequestedCopyWith<$Res> {
  __$CurrencyUpdateRequestedCopyWithImpl(this._self, this._then);

  final _CurrencyUpdateRequested _self;
  final $Res Function(_CurrencyUpdateRequested) _then;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? currencyCode = null,}) {
  return _then(_CurrencyUpdateRequested(
null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$DashboardState {

 BlocStatus<DashboardEntity> get overviewState; BlocStatus<List<DashboardDriverDocumentEntity>> get driverDocumentsState; BlocStatus<void> get documentReviewState; BlocStatus<void> get driverApprovalState; BlocStatus<void> get tripAssignmentState; BlocStatus<List<DashboardDriverLocationEntity>> get driverLocationsState; BlocStatus<List<DashboardTripEntity>> get adminTripsState; BlocStatus<DashboardTripDetailsEntity> get tripDetailsState; BlocStatus<DashboardAdminOperationsEntity> get adminOperationsState; BlocStatus<void> get adminActionState; String? get selectedDriverId; String? get selectedTripId;
/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardStateCopyWith<DashboardState> get copyWith => _$DashboardStateCopyWithImpl<DashboardState>(this as DashboardState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardState&&(identical(other.overviewState, overviewState) || other.overviewState == overviewState)&&(identical(other.driverDocumentsState, driverDocumentsState) || other.driverDocumentsState == driverDocumentsState)&&(identical(other.documentReviewState, documentReviewState) || other.documentReviewState == documentReviewState)&&(identical(other.driverApprovalState, driverApprovalState) || other.driverApprovalState == driverApprovalState)&&(identical(other.tripAssignmentState, tripAssignmentState) || other.tripAssignmentState == tripAssignmentState)&&(identical(other.driverLocationsState, driverLocationsState) || other.driverLocationsState == driverLocationsState)&&(identical(other.adminTripsState, adminTripsState) || other.adminTripsState == adminTripsState)&&(identical(other.tripDetailsState, tripDetailsState) || other.tripDetailsState == tripDetailsState)&&(identical(other.adminOperationsState, adminOperationsState) || other.adminOperationsState == adminOperationsState)&&(identical(other.adminActionState, adminActionState) || other.adminActionState == adminActionState)&&(identical(other.selectedDriverId, selectedDriverId) || other.selectedDriverId == selectedDriverId)&&(identical(other.selectedTripId, selectedTripId) || other.selectedTripId == selectedTripId));
}


@override
int get hashCode => Object.hash(runtimeType,overviewState,driverDocumentsState,documentReviewState,driverApprovalState,tripAssignmentState,driverLocationsState,adminTripsState,tripDetailsState,adminOperationsState,adminActionState,selectedDriverId,selectedTripId);

@override
String toString() {
  return 'DashboardState(overviewState: $overviewState, driverDocumentsState: $driverDocumentsState, documentReviewState: $documentReviewState, driverApprovalState: $driverApprovalState, tripAssignmentState: $tripAssignmentState, driverLocationsState: $driverLocationsState, adminTripsState: $adminTripsState, tripDetailsState: $tripDetailsState, adminOperationsState: $adminOperationsState, adminActionState: $adminActionState, selectedDriverId: $selectedDriverId, selectedTripId: $selectedTripId)';
}


}

/// @nodoc
abstract mixin class $DashboardStateCopyWith<$Res>  {
  factory $DashboardStateCopyWith(DashboardState value, $Res Function(DashboardState) _then) = _$DashboardStateCopyWithImpl;
@useResult
$Res call({
 BlocStatus<DashboardEntity> overviewState, BlocStatus<List<DashboardDriverDocumentEntity>> driverDocumentsState, BlocStatus<void> documentReviewState, BlocStatus<void> driverApprovalState, BlocStatus<void> tripAssignmentState, BlocStatus<List<DashboardDriverLocationEntity>> driverLocationsState, BlocStatus<List<DashboardTripEntity>> adminTripsState, BlocStatus<DashboardTripDetailsEntity> tripDetailsState, BlocStatus<DashboardAdminOperationsEntity> adminOperationsState, BlocStatus<void> adminActionState, String? selectedDriverId, String? selectedTripId
});


$BlocStatusCopyWith<DashboardEntity, $Res> get overviewState;$BlocStatusCopyWith<List<DashboardDriverDocumentEntity>, $Res> get driverDocumentsState;$BlocStatusCopyWith<void, $Res> get documentReviewState;$BlocStatusCopyWith<void, $Res> get driverApprovalState;$BlocStatusCopyWith<void, $Res> get tripAssignmentState;$BlocStatusCopyWith<List<DashboardDriverLocationEntity>, $Res> get driverLocationsState;$BlocStatusCopyWith<List<DashboardTripEntity>, $Res> get adminTripsState;$BlocStatusCopyWith<DashboardTripDetailsEntity, $Res> get tripDetailsState;$BlocStatusCopyWith<DashboardAdminOperationsEntity, $Res> get adminOperationsState;$BlocStatusCopyWith<void, $Res> get adminActionState;

}
/// @nodoc
class _$DashboardStateCopyWithImpl<$Res>
    implements $DashboardStateCopyWith<$Res> {
  _$DashboardStateCopyWithImpl(this._self, this._then);

  final DashboardState _self;
  final $Res Function(DashboardState) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? overviewState = null,Object? driverDocumentsState = null,Object? documentReviewState = null,Object? driverApprovalState = null,Object? tripAssignmentState = null,Object? driverLocationsState = null,Object? adminTripsState = null,Object? tripDetailsState = null,Object? adminOperationsState = null,Object? adminActionState = null,Object? selectedDriverId = freezed,Object? selectedTripId = freezed,}) {
  return _then(_self.copyWith(
overviewState: null == overviewState ? _self.overviewState : overviewState // ignore: cast_nullable_to_non_nullable
as BlocStatus<DashboardEntity>,driverDocumentsState: null == driverDocumentsState ? _self.driverDocumentsState : driverDocumentsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<DashboardDriverDocumentEntity>>,documentReviewState: null == documentReviewState ? _self.documentReviewState : documentReviewState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,driverApprovalState: null == driverApprovalState ? _self.driverApprovalState : driverApprovalState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,tripAssignmentState: null == tripAssignmentState ? _self.tripAssignmentState : tripAssignmentState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,driverLocationsState: null == driverLocationsState ? _self.driverLocationsState : driverLocationsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<DashboardDriverLocationEntity>>,adminTripsState: null == adminTripsState ? _self.adminTripsState : adminTripsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<DashboardTripEntity>>,tripDetailsState: null == tripDetailsState ? _self.tripDetailsState : tripDetailsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<DashboardTripDetailsEntity>,adminOperationsState: null == adminOperationsState ? _self.adminOperationsState : adminOperationsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<DashboardAdminOperationsEntity>,adminActionState: null == adminActionState ? _self.adminActionState : adminActionState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,selectedDriverId: freezed == selectedDriverId ? _self.selectedDriverId : selectedDriverId // ignore: cast_nullable_to_non_nullable
as String?,selectedTripId: freezed == selectedTripId ? _self.selectedTripId : selectedTripId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<DashboardEntity, $Res> get overviewState {
  
  return $BlocStatusCopyWith<DashboardEntity, $Res>(_self.overviewState, (value) {
    return _then(_self.copyWith(overviewState: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<DashboardDriverDocumentEntity>, $Res> get driverDocumentsState {
  
  return $BlocStatusCopyWith<List<DashboardDriverDocumentEntity>, $Res>(_self.driverDocumentsState, (value) {
    return _then(_self.copyWith(driverDocumentsState: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get documentReviewState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.documentReviewState, (value) {
    return _then(_self.copyWith(documentReviewState: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get driverApprovalState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.driverApprovalState, (value) {
    return _then(_self.copyWith(driverApprovalState: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get tripAssignmentState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.tripAssignmentState, (value) {
    return _then(_self.copyWith(tripAssignmentState: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<DashboardDriverLocationEntity>, $Res> get driverLocationsState {
  
  return $BlocStatusCopyWith<List<DashboardDriverLocationEntity>, $Res>(_self.driverLocationsState, (value) {
    return _then(_self.copyWith(driverLocationsState: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<DashboardTripEntity>, $Res> get adminTripsState {
  
  return $BlocStatusCopyWith<List<DashboardTripEntity>, $Res>(_self.adminTripsState, (value) {
    return _then(_self.copyWith(adminTripsState: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<DashboardTripDetailsEntity, $Res> get tripDetailsState {
  
  return $BlocStatusCopyWith<DashboardTripDetailsEntity, $Res>(_self.tripDetailsState, (value) {
    return _then(_self.copyWith(tripDetailsState: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<DashboardAdminOperationsEntity, $Res> get adminOperationsState {
  
  return $BlocStatusCopyWith<DashboardAdminOperationsEntity, $Res>(_self.adminOperationsState, (value) {
    return _then(_self.copyWith(adminOperationsState: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get adminActionState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.adminActionState, (value) {
    return _then(_self.copyWith(adminActionState: value));
  });
}
}


/// Adds pattern-matching-related methods to [DashboardState].
extension DashboardStatePatterns on DashboardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardState value)  $default,){
final _that = this;
switch (_that) {
case _DashboardState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardState value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BlocStatus<DashboardEntity> overviewState,  BlocStatus<List<DashboardDriverDocumentEntity>> driverDocumentsState,  BlocStatus<void> documentReviewState,  BlocStatus<void> driverApprovalState,  BlocStatus<void> tripAssignmentState,  BlocStatus<List<DashboardDriverLocationEntity>> driverLocationsState,  BlocStatus<List<DashboardTripEntity>> adminTripsState,  BlocStatus<DashboardTripDetailsEntity> tripDetailsState,  BlocStatus<DashboardAdminOperationsEntity> adminOperationsState,  BlocStatus<void> adminActionState,  String? selectedDriverId,  String? selectedTripId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
return $default(_that.overviewState,_that.driverDocumentsState,_that.documentReviewState,_that.driverApprovalState,_that.tripAssignmentState,_that.driverLocationsState,_that.adminTripsState,_that.tripDetailsState,_that.adminOperationsState,_that.adminActionState,_that.selectedDriverId,_that.selectedTripId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BlocStatus<DashboardEntity> overviewState,  BlocStatus<List<DashboardDriverDocumentEntity>> driverDocumentsState,  BlocStatus<void> documentReviewState,  BlocStatus<void> driverApprovalState,  BlocStatus<void> tripAssignmentState,  BlocStatus<List<DashboardDriverLocationEntity>> driverLocationsState,  BlocStatus<List<DashboardTripEntity>> adminTripsState,  BlocStatus<DashboardTripDetailsEntity> tripDetailsState,  BlocStatus<DashboardAdminOperationsEntity> adminOperationsState,  BlocStatus<void> adminActionState,  String? selectedDriverId,  String? selectedTripId)  $default,) {final _that = this;
switch (_that) {
case _DashboardState():
return $default(_that.overviewState,_that.driverDocumentsState,_that.documentReviewState,_that.driverApprovalState,_that.tripAssignmentState,_that.driverLocationsState,_that.adminTripsState,_that.tripDetailsState,_that.adminOperationsState,_that.adminActionState,_that.selectedDriverId,_that.selectedTripId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BlocStatus<DashboardEntity> overviewState,  BlocStatus<List<DashboardDriverDocumentEntity>> driverDocumentsState,  BlocStatus<void> documentReviewState,  BlocStatus<void> driverApprovalState,  BlocStatus<void> tripAssignmentState,  BlocStatus<List<DashboardDriverLocationEntity>> driverLocationsState,  BlocStatus<List<DashboardTripEntity>> adminTripsState,  BlocStatus<DashboardTripDetailsEntity> tripDetailsState,  BlocStatus<DashboardAdminOperationsEntity> adminOperationsState,  BlocStatus<void> adminActionState,  String? selectedDriverId,  String? selectedTripId)?  $default,) {final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
return $default(_that.overviewState,_that.driverDocumentsState,_that.documentReviewState,_that.driverApprovalState,_that.tripAssignmentState,_that.driverLocationsState,_that.adminTripsState,_that.tripDetailsState,_that.adminOperationsState,_that.adminActionState,_that.selectedDriverId,_that.selectedTripId);case _:
  return null;

}
}

}

/// @nodoc


class _DashboardState implements DashboardState {
  const _DashboardState({this.overviewState = const BlocStatus<DashboardEntity>.initial(), this.driverDocumentsState = const BlocStatus<List<DashboardDriverDocumentEntity>>.initial(), this.documentReviewState = const BlocStatus<void>.initial(), this.driverApprovalState = const BlocStatus<void>.initial(), this.tripAssignmentState = const BlocStatus<void>.initial(), this.driverLocationsState = const BlocStatus<List<DashboardDriverLocationEntity>>.initial(), this.adminTripsState = const BlocStatus<List<DashboardTripEntity>>.initial(), this.tripDetailsState = const BlocStatus<DashboardTripDetailsEntity>.initial(), this.adminOperationsState = const BlocStatus<DashboardAdminOperationsEntity>.initial(), this.adminActionState = const BlocStatus<void>.initial(), this.selectedDriverId, this.selectedTripId});
  

@override@JsonKey() final  BlocStatus<DashboardEntity> overviewState;
@override@JsonKey() final  BlocStatus<List<DashboardDriverDocumentEntity>> driverDocumentsState;
@override@JsonKey() final  BlocStatus<void> documentReviewState;
@override@JsonKey() final  BlocStatus<void> driverApprovalState;
@override@JsonKey() final  BlocStatus<void> tripAssignmentState;
@override@JsonKey() final  BlocStatus<List<DashboardDriverLocationEntity>> driverLocationsState;
@override@JsonKey() final  BlocStatus<List<DashboardTripEntity>> adminTripsState;
@override@JsonKey() final  BlocStatus<DashboardTripDetailsEntity> tripDetailsState;
@override@JsonKey() final  BlocStatus<DashboardAdminOperationsEntity> adminOperationsState;
@override@JsonKey() final  BlocStatus<void> adminActionState;
@override final  String? selectedDriverId;
@override final  String? selectedTripId;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardStateCopyWith<_DashboardState> get copyWith => __$DashboardStateCopyWithImpl<_DashboardState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardState&&(identical(other.overviewState, overviewState) || other.overviewState == overviewState)&&(identical(other.driverDocumentsState, driverDocumentsState) || other.driverDocumentsState == driverDocumentsState)&&(identical(other.documentReviewState, documentReviewState) || other.documentReviewState == documentReviewState)&&(identical(other.driverApprovalState, driverApprovalState) || other.driverApprovalState == driverApprovalState)&&(identical(other.tripAssignmentState, tripAssignmentState) || other.tripAssignmentState == tripAssignmentState)&&(identical(other.driverLocationsState, driverLocationsState) || other.driverLocationsState == driverLocationsState)&&(identical(other.adminTripsState, adminTripsState) || other.adminTripsState == adminTripsState)&&(identical(other.tripDetailsState, tripDetailsState) || other.tripDetailsState == tripDetailsState)&&(identical(other.adminOperationsState, adminOperationsState) || other.adminOperationsState == adminOperationsState)&&(identical(other.adminActionState, adminActionState) || other.adminActionState == adminActionState)&&(identical(other.selectedDriverId, selectedDriverId) || other.selectedDriverId == selectedDriverId)&&(identical(other.selectedTripId, selectedTripId) || other.selectedTripId == selectedTripId));
}


@override
int get hashCode => Object.hash(runtimeType,overviewState,driverDocumentsState,documentReviewState,driverApprovalState,tripAssignmentState,driverLocationsState,adminTripsState,tripDetailsState,adminOperationsState,adminActionState,selectedDriverId,selectedTripId);

@override
String toString() {
  return 'DashboardState(overviewState: $overviewState, driverDocumentsState: $driverDocumentsState, documentReviewState: $documentReviewState, driverApprovalState: $driverApprovalState, tripAssignmentState: $tripAssignmentState, driverLocationsState: $driverLocationsState, adminTripsState: $adminTripsState, tripDetailsState: $tripDetailsState, adminOperationsState: $adminOperationsState, adminActionState: $adminActionState, selectedDriverId: $selectedDriverId, selectedTripId: $selectedTripId)';
}


}

/// @nodoc
abstract mixin class _$DashboardStateCopyWith<$Res> implements $DashboardStateCopyWith<$Res> {
  factory _$DashboardStateCopyWith(_DashboardState value, $Res Function(_DashboardState) _then) = __$DashboardStateCopyWithImpl;
@override @useResult
$Res call({
 BlocStatus<DashboardEntity> overviewState, BlocStatus<List<DashboardDriverDocumentEntity>> driverDocumentsState, BlocStatus<void> documentReviewState, BlocStatus<void> driverApprovalState, BlocStatus<void> tripAssignmentState, BlocStatus<List<DashboardDriverLocationEntity>> driverLocationsState, BlocStatus<List<DashboardTripEntity>> adminTripsState, BlocStatus<DashboardTripDetailsEntity> tripDetailsState, BlocStatus<DashboardAdminOperationsEntity> adminOperationsState, BlocStatus<void> adminActionState, String? selectedDriverId, String? selectedTripId
});


@override $BlocStatusCopyWith<DashboardEntity, $Res> get overviewState;@override $BlocStatusCopyWith<List<DashboardDriverDocumentEntity>, $Res> get driverDocumentsState;@override $BlocStatusCopyWith<void, $Res> get documentReviewState;@override $BlocStatusCopyWith<void, $Res> get driverApprovalState;@override $BlocStatusCopyWith<void, $Res> get tripAssignmentState;@override $BlocStatusCopyWith<List<DashboardDriverLocationEntity>, $Res> get driverLocationsState;@override $BlocStatusCopyWith<List<DashboardTripEntity>, $Res> get adminTripsState;@override $BlocStatusCopyWith<DashboardTripDetailsEntity, $Res> get tripDetailsState;@override $BlocStatusCopyWith<DashboardAdminOperationsEntity, $Res> get adminOperationsState;@override $BlocStatusCopyWith<void, $Res> get adminActionState;

}
/// @nodoc
class __$DashboardStateCopyWithImpl<$Res>
    implements _$DashboardStateCopyWith<$Res> {
  __$DashboardStateCopyWithImpl(this._self, this._then);

  final _DashboardState _self;
  final $Res Function(_DashboardState) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? overviewState = null,Object? driverDocumentsState = null,Object? documentReviewState = null,Object? driverApprovalState = null,Object? tripAssignmentState = null,Object? driverLocationsState = null,Object? adminTripsState = null,Object? tripDetailsState = null,Object? adminOperationsState = null,Object? adminActionState = null,Object? selectedDriverId = freezed,Object? selectedTripId = freezed,}) {
  return _then(_DashboardState(
overviewState: null == overviewState ? _self.overviewState : overviewState // ignore: cast_nullable_to_non_nullable
as BlocStatus<DashboardEntity>,driverDocumentsState: null == driverDocumentsState ? _self.driverDocumentsState : driverDocumentsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<DashboardDriverDocumentEntity>>,documentReviewState: null == documentReviewState ? _self.documentReviewState : documentReviewState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,driverApprovalState: null == driverApprovalState ? _self.driverApprovalState : driverApprovalState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,tripAssignmentState: null == tripAssignmentState ? _self.tripAssignmentState : tripAssignmentState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,driverLocationsState: null == driverLocationsState ? _self.driverLocationsState : driverLocationsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<DashboardDriverLocationEntity>>,adminTripsState: null == adminTripsState ? _self.adminTripsState : adminTripsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<DashboardTripEntity>>,tripDetailsState: null == tripDetailsState ? _self.tripDetailsState : tripDetailsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<DashboardTripDetailsEntity>,adminOperationsState: null == adminOperationsState ? _self.adminOperationsState : adminOperationsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<DashboardAdminOperationsEntity>,adminActionState: null == adminActionState ? _self.adminActionState : adminActionState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,selectedDriverId: freezed == selectedDriverId ? _self.selectedDriverId : selectedDriverId // ignore: cast_nullable_to_non_nullable
as String?,selectedTripId: freezed == selectedTripId ? _self.selectedTripId : selectedTripId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<DashboardEntity, $Res> get overviewState {
  
  return $BlocStatusCopyWith<DashboardEntity, $Res>(_self.overviewState, (value) {
    return _then(_self.copyWith(overviewState: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<DashboardDriverDocumentEntity>, $Res> get driverDocumentsState {
  
  return $BlocStatusCopyWith<List<DashboardDriverDocumentEntity>, $Res>(_self.driverDocumentsState, (value) {
    return _then(_self.copyWith(driverDocumentsState: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get documentReviewState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.documentReviewState, (value) {
    return _then(_self.copyWith(documentReviewState: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get driverApprovalState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.driverApprovalState, (value) {
    return _then(_self.copyWith(driverApprovalState: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get tripAssignmentState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.tripAssignmentState, (value) {
    return _then(_self.copyWith(tripAssignmentState: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<DashboardDriverLocationEntity>, $Res> get driverLocationsState {
  
  return $BlocStatusCopyWith<List<DashboardDriverLocationEntity>, $Res>(_self.driverLocationsState, (value) {
    return _then(_self.copyWith(driverLocationsState: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<DashboardTripEntity>, $Res> get adminTripsState {
  
  return $BlocStatusCopyWith<List<DashboardTripEntity>, $Res>(_self.adminTripsState, (value) {
    return _then(_self.copyWith(adminTripsState: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<DashboardTripDetailsEntity, $Res> get tripDetailsState {
  
  return $BlocStatusCopyWith<DashboardTripDetailsEntity, $Res>(_self.tripDetailsState, (value) {
    return _then(_self.copyWith(tripDetailsState: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<DashboardAdminOperationsEntity, $Res> get adminOperationsState {
  
  return $BlocStatusCopyWith<DashboardAdminOperationsEntity, $Res>(_self.adminOperationsState, (value) {
    return _then(_self.copyWith(adminOperationsState: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get adminActionState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.adminActionState, (value) {
    return _then(_self.copyWith(adminActionState: value));
  });
}
}

// dart format on
