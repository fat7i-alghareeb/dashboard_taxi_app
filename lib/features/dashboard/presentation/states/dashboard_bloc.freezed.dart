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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _OverviewRequested value)?  overviewRequested,TResult Function( _DriverDocumentsRequested value)?  driverDocumentsRequested,TResult Function( _DocumentReviewRequested value)?  documentReviewRequested,TResult Function( _DriverApprovalRequested value)?  driverApprovalRequested,TResult Function( _TripAssignmentRequested value)?  tripAssignmentRequested,TResult Function( _DriverLocationsRequested value)?  driverLocationsRequested,TResult Function( _DriverLocationReceived value)?  driverLocationReceived,TResult Function( _AdminTripsRequested value)?  adminTripsRequested,TResult Function( _AdminTripsNextPageRequested value)?  adminTripsNextPageRequested,TResult Function( _AdminTripsSearchChanged value)?  adminTripsSearchChanged,TResult Function( _AdminTripsCustomerChanged value)?  adminTripsCustomerChanged,TResult Function( _AdminTripStatusPatched value)?  adminTripStatusPatched,TResult Function( _TripDetailsRequested value)?  tripDetailsRequested,TResult Function( _TripFinancialsRequested value)?  tripFinancialsRequested,TResult Function( _UserWalletRequested value)?  userWalletRequested,TResult Function( _AdminConfigRequested value)?  adminConfigRequested,TResult Function( _AdminVehicleTypesRequested value)?  adminVehicleTypesRequested,TResult Function( _VehicleTypeStatusToggleRequested value)?  vehicleTypeStatusToggleRequested,TResult Function( _VehicleTypeRemovalRequested value)?  vehicleTypeRemovalRequested,TResult Function( _VehicleTypeCreateRequested value)?  vehicleTypeCreateRequested,TResult Function( _VehicleTypeUpdateRequested value)?  vehicleTypeUpdateRequested,TResult Function( _TripDiscountUpdateRequested value)?  tripDiscountUpdateRequested,TResult Function( _CurrencyUpdateRequested value)?  currencyUpdateRequested,required TResult orElse(),}){
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
return adminTripsRequested(_that);case _AdminTripsNextPageRequested() when adminTripsNextPageRequested != null:
return adminTripsNextPageRequested(_that);case _AdminTripsSearchChanged() when adminTripsSearchChanged != null:
return adminTripsSearchChanged(_that);case _AdminTripsCustomerChanged() when adminTripsCustomerChanged != null:
return adminTripsCustomerChanged(_that);case _AdminTripStatusPatched() when adminTripStatusPatched != null:
return adminTripStatusPatched(_that);case _TripDetailsRequested() when tripDetailsRequested != null:
return tripDetailsRequested(_that);case _TripFinancialsRequested() when tripFinancialsRequested != null:
return tripFinancialsRequested(_that);case _UserWalletRequested() when userWalletRequested != null:
return userWalletRequested(_that);case _AdminConfigRequested() when adminConfigRequested != null:
return adminConfigRequested(_that);case _AdminVehicleTypesRequested() when adminVehicleTypesRequested != null:
return adminVehicleTypesRequested(_that);case _VehicleTypeStatusToggleRequested() when vehicleTypeStatusToggleRequested != null:
return vehicleTypeStatusToggleRequested(_that);case _VehicleTypeRemovalRequested() when vehicleTypeRemovalRequested != null:
return vehicleTypeRemovalRequested(_that);case _VehicleTypeCreateRequested() when vehicleTypeCreateRequested != null:
return vehicleTypeCreateRequested(_that);case _VehicleTypeUpdateRequested() when vehicleTypeUpdateRequested != null:
return vehicleTypeUpdateRequested(_that);case _TripDiscountUpdateRequested() when tripDiscountUpdateRequested != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _OverviewRequested value)  overviewRequested,required TResult Function( _DriverDocumentsRequested value)  driverDocumentsRequested,required TResult Function( _DocumentReviewRequested value)  documentReviewRequested,required TResult Function( _DriverApprovalRequested value)  driverApprovalRequested,required TResult Function( _TripAssignmentRequested value)  tripAssignmentRequested,required TResult Function( _DriverLocationsRequested value)  driverLocationsRequested,required TResult Function( _DriverLocationReceived value)  driverLocationReceived,required TResult Function( _AdminTripsRequested value)  adminTripsRequested,required TResult Function( _AdminTripsNextPageRequested value)  adminTripsNextPageRequested,required TResult Function( _AdminTripsSearchChanged value)  adminTripsSearchChanged,required TResult Function( _AdminTripsCustomerChanged value)  adminTripsCustomerChanged,required TResult Function( _AdminTripStatusPatched value)  adminTripStatusPatched,required TResult Function( _TripDetailsRequested value)  tripDetailsRequested,required TResult Function( _TripFinancialsRequested value)  tripFinancialsRequested,required TResult Function( _UserWalletRequested value)  userWalletRequested,required TResult Function( _AdminConfigRequested value)  adminConfigRequested,required TResult Function( _AdminVehicleTypesRequested value)  adminVehicleTypesRequested,required TResult Function( _VehicleTypeStatusToggleRequested value)  vehicleTypeStatusToggleRequested,required TResult Function( _VehicleTypeRemovalRequested value)  vehicleTypeRemovalRequested,required TResult Function( _VehicleTypeCreateRequested value)  vehicleTypeCreateRequested,required TResult Function( _VehicleTypeUpdateRequested value)  vehicleTypeUpdateRequested,required TResult Function( _TripDiscountUpdateRequested value)  tripDiscountUpdateRequested,required TResult Function( _CurrencyUpdateRequested value)  currencyUpdateRequested,}){
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
return adminTripsRequested(_that);case _AdminTripsNextPageRequested():
return adminTripsNextPageRequested(_that);case _AdminTripsSearchChanged():
return adminTripsSearchChanged(_that);case _AdminTripsCustomerChanged():
return adminTripsCustomerChanged(_that);case _AdminTripStatusPatched():
return adminTripStatusPatched(_that);case _TripDetailsRequested():
return tripDetailsRequested(_that);case _TripFinancialsRequested():
return tripFinancialsRequested(_that);case _UserWalletRequested():
return userWalletRequested(_that);case _AdminConfigRequested():
return adminConfigRequested(_that);case _AdminVehicleTypesRequested():
return adminVehicleTypesRequested(_that);case _VehicleTypeStatusToggleRequested():
return vehicleTypeStatusToggleRequested(_that);case _VehicleTypeRemovalRequested():
return vehicleTypeRemovalRequested(_that);case _VehicleTypeCreateRequested():
return vehicleTypeCreateRequested(_that);case _VehicleTypeUpdateRequested():
return vehicleTypeUpdateRequested(_that);case _TripDiscountUpdateRequested():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _OverviewRequested value)?  overviewRequested,TResult? Function( _DriverDocumentsRequested value)?  driverDocumentsRequested,TResult? Function( _DocumentReviewRequested value)?  documentReviewRequested,TResult? Function( _DriverApprovalRequested value)?  driverApprovalRequested,TResult? Function( _TripAssignmentRequested value)?  tripAssignmentRequested,TResult? Function( _DriverLocationsRequested value)?  driverLocationsRequested,TResult? Function( _DriverLocationReceived value)?  driverLocationReceived,TResult? Function( _AdminTripsRequested value)?  adminTripsRequested,TResult? Function( _AdminTripsNextPageRequested value)?  adminTripsNextPageRequested,TResult? Function( _AdminTripsSearchChanged value)?  adminTripsSearchChanged,TResult? Function( _AdminTripsCustomerChanged value)?  adminTripsCustomerChanged,TResult? Function( _AdminTripStatusPatched value)?  adminTripStatusPatched,TResult? Function( _TripDetailsRequested value)?  tripDetailsRequested,TResult? Function( _TripFinancialsRequested value)?  tripFinancialsRequested,TResult? Function( _UserWalletRequested value)?  userWalletRequested,TResult? Function( _AdminConfigRequested value)?  adminConfigRequested,TResult? Function( _AdminVehicleTypesRequested value)?  adminVehicleTypesRequested,TResult? Function( _VehicleTypeStatusToggleRequested value)?  vehicleTypeStatusToggleRequested,TResult? Function( _VehicleTypeRemovalRequested value)?  vehicleTypeRemovalRequested,TResult? Function( _VehicleTypeCreateRequested value)?  vehicleTypeCreateRequested,TResult? Function( _VehicleTypeUpdateRequested value)?  vehicleTypeUpdateRequested,TResult? Function( _TripDiscountUpdateRequested value)?  tripDiscountUpdateRequested,TResult? Function( _CurrencyUpdateRequested value)?  currencyUpdateRequested,}){
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
return adminTripsRequested(_that);case _AdminTripsNextPageRequested() when adminTripsNextPageRequested != null:
return adminTripsNextPageRequested(_that);case _AdminTripsSearchChanged() when adminTripsSearchChanged != null:
return adminTripsSearchChanged(_that);case _AdminTripsCustomerChanged() when adminTripsCustomerChanged != null:
return adminTripsCustomerChanged(_that);case _AdminTripStatusPatched() when adminTripStatusPatched != null:
return adminTripStatusPatched(_that);case _TripDetailsRequested() when tripDetailsRequested != null:
return tripDetailsRequested(_that);case _TripFinancialsRequested() when tripFinancialsRequested != null:
return tripFinancialsRequested(_that);case _UserWalletRequested() when userWalletRequested != null:
return userWalletRequested(_that);case _AdminConfigRequested() when adminConfigRequested != null:
return adminConfigRequested(_that);case _AdminVehicleTypesRequested() when adminVehicleTypesRequested != null:
return adminVehicleTypesRequested(_that);case _VehicleTypeStatusToggleRequested() when vehicleTypeStatusToggleRequested != null:
return vehicleTypeStatusToggleRequested(_that);case _VehicleTypeRemovalRequested() when vehicleTypeRemovalRequested != null:
return vehicleTypeRemovalRequested(_that);case _VehicleTypeCreateRequested() when vehicleTypeCreateRequested != null:
return vehicleTypeCreateRequested(_that);case _VehicleTypeUpdateRequested() when vehicleTypeUpdateRequested != null:
return vehicleTypeUpdateRequested(_that);case _TripDiscountUpdateRequested() when tripDiscountUpdateRequested != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  overviewRequested,TResult Function( String driverId)?  driverDocumentsRequested,TResult Function( String driverId,  String documentId,  bool approved,  String? notes)?  documentReviewRequested,TResult Function( String driverId)?  driverApprovalRequested,TResult Function( String tripId,  String driverId,  bool enterDriverMode)?  tripAssignmentRequested,TResult Function()?  driverLocationsRequested,TResult Function( String driverId,  double latitude,  double longitude)?  driverLocationReceived,TResult Function( String? status,  bool preservePagination)?  adminTripsRequested,TResult Function()?  adminTripsNextPageRequested,TResult Function( String query)?  adminTripsSearchChanged,TResult Function( String? passengerId,  String? name)?  adminTripsCustomerChanged,TResult Function( String tripId,  String newStatus)?  adminTripStatusPatched,TResult Function( String tripId)?  tripDetailsRequested,TResult Function( String tripId)?  tripFinancialsRequested,TResult Function( String userId)?  userWalletRequested,TResult Function()?  adminConfigRequested,TResult Function()?  adminVehicleTypesRequested,TResult Function( DashboardVehicleTypeEntity vehicleType)?  vehicleTypeStatusToggleRequested,TResult Function( String vehicleTypeId)?  vehicleTypeRemovalRequested,TResult Function( String code,  String name,  int capacity,  num ratePerKm,  num ratePerMin,  num minFare,  int sortOrder)?  vehicleTypeCreateRequested,TResult Function( DashboardVehicleTypeEntity vehicleType)?  vehicleTypeUpdateRequested,TResult Function( num discountPercent)?  tripDiscountUpdateRequested,TResult Function( String currencyCode)?  currencyUpdateRequested,required TResult orElse(),}) {final _that = this;
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
return adminTripsRequested(_that.status,_that.preservePagination);case _AdminTripsNextPageRequested() when adminTripsNextPageRequested != null:
return adminTripsNextPageRequested();case _AdminTripsSearchChanged() when adminTripsSearchChanged != null:
return adminTripsSearchChanged(_that.query);case _AdminTripsCustomerChanged() when adminTripsCustomerChanged != null:
return adminTripsCustomerChanged(_that.passengerId,_that.name);case _AdminTripStatusPatched() when adminTripStatusPatched != null:
return adminTripStatusPatched(_that.tripId,_that.newStatus);case _TripDetailsRequested() when tripDetailsRequested != null:
return tripDetailsRequested(_that.tripId);case _TripFinancialsRequested() when tripFinancialsRequested != null:
return tripFinancialsRequested(_that.tripId);case _UserWalletRequested() when userWalletRequested != null:
return userWalletRequested(_that.userId);case _AdminConfigRequested() when adminConfigRequested != null:
return adminConfigRequested();case _AdminVehicleTypesRequested() when adminVehicleTypesRequested != null:
return adminVehicleTypesRequested();case _VehicleTypeStatusToggleRequested() when vehicleTypeStatusToggleRequested != null:
return vehicleTypeStatusToggleRequested(_that.vehicleType);case _VehicleTypeRemovalRequested() when vehicleTypeRemovalRequested != null:
return vehicleTypeRemovalRequested(_that.vehicleTypeId);case _VehicleTypeCreateRequested() when vehicleTypeCreateRequested != null:
return vehicleTypeCreateRequested(_that.code,_that.name,_that.capacity,_that.ratePerKm,_that.ratePerMin,_that.minFare,_that.sortOrder);case _VehicleTypeUpdateRequested() when vehicleTypeUpdateRequested != null:
return vehicleTypeUpdateRequested(_that.vehicleType);case _TripDiscountUpdateRequested() when tripDiscountUpdateRequested != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  overviewRequested,required TResult Function( String driverId)  driverDocumentsRequested,required TResult Function( String driverId,  String documentId,  bool approved,  String? notes)  documentReviewRequested,required TResult Function( String driverId)  driverApprovalRequested,required TResult Function( String tripId,  String driverId,  bool enterDriverMode)  tripAssignmentRequested,required TResult Function()  driverLocationsRequested,required TResult Function( String driverId,  double latitude,  double longitude)  driverLocationReceived,required TResult Function( String? status,  bool preservePagination)  adminTripsRequested,required TResult Function()  adminTripsNextPageRequested,required TResult Function( String query)  adminTripsSearchChanged,required TResult Function( String? passengerId,  String? name)  adminTripsCustomerChanged,required TResult Function( String tripId,  String newStatus)  adminTripStatusPatched,required TResult Function( String tripId)  tripDetailsRequested,required TResult Function( String tripId)  tripFinancialsRequested,required TResult Function( String userId)  userWalletRequested,required TResult Function()  adminConfigRequested,required TResult Function()  adminVehicleTypesRequested,required TResult Function( DashboardVehicleTypeEntity vehicleType)  vehicleTypeStatusToggleRequested,required TResult Function( String vehicleTypeId)  vehicleTypeRemovalRequested,required TResult Function( String code,  String name,  int capacity,  num ratePerKm,  num ratePerMin,  num minFare,  int sortOrder)  vehicleTypeCreateRequested,required TResult Function( DashboardVehicleTypeEntity vehicleType)  vehicleTypeUpdateRequested,required TResult Function( num discountPercent)  tripDiscountUpdateRequested,required TResult Function( String currencyCode)  currencyUpdateRequested,}) {final _that = this;
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
return adminTripsRequested(_that.status,_that.preservePagination);case _AdminTripsNextPageRequested():
return adminTripsNextPageRequested();case _AdminTripsSearchChanged():
return adminTripsSearchChanged(_that.query);case _AdminTripsCustomerChanged():
return adminTripsCustomerChanged(_that.passengerId,_that.name);case _AdminTripStatusPatched():
return adminTripStatusPatched(_that.tripId,_that.newStatus);case _TripDetailsRequested():
return tripDetailsRequested(_that.tripId);case _TripFinancialsRequested():
return tripFinancialsRequested(_that.tripId);case _UserWalletRequested():
return userWalletRequested(_that.userId);case _AdminConfigRequested():
return adminConfigRequested();case _AdminVehicleTypesRequested():
return adminVehicleTypesRequested();case _VehicleTypeStatusToggleRequested():
return vehicleTypeStatusToggleRequested(_that.vehicleType);case _VehicleTypeRemovalRequested():
return vehicleTypeRemovalRequested(_that.vehicleTypeId);case _VehicleTypeCreateRequested():
return vehicleTypeCreateRequested(_that.code,_that.name,_that.capacity,_that.ratePerKm,_that.ratePerMin,_that.minFare,_that.sortOrder);case _VehicleTypeUpdateRequested():
return vehicleTypeUpdateRequested(_that.vehicleType);case _TripDiscountUpdateRequested():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  overviewRequested,TResult? Function( String driverId)?  driverDocumentsRequested,TResult? Function( String driverId,  String documentId,  bool approved,  String? notes)?  documentReviewRequested,TResult? Function( String driverId)?  driverApprovalRequested,TResult? Function( String tripId,  String driverId,  bool enterDriverMode)?  tripAssignmentRequested,TResult? Function()?  driverLocationsRequested,TResult? Function( String driverId,  double latitude,  double longitude)?  driverLocationReceived,TResult? Function( String? status,  bool preservePagination)?  adminTripsRequested,TResult? Function()?  adminTripsNextPageRequested,TResult? Function( String query)?  adminTripsSearchChanged,TResult? Function( String? passengerId,  String? name)?  adminTripsCustomerChanged,TResult? Function( String tripId,  String newStatus)?  adminTripStatusPatched,TResult? Function( String tripId)?  tripDetailsRequested,TResult? Function( String tripId)?  tripFinancialsRequested,TResult? Function( String userId)?  userWalletRequested,TResult? Function()?  adminConfigRequested,TResult? Function()?  adminVehicleTypesRequested,TResult? Function( DashboardVehicleTypeEntity vehicleType)?  vehicleTypeStatusToggleRequested,TResult? Function( String vehicleTypeId)?  vehicleTypeRemovalRequested,TResult? Function( String code,  String name,  int capacity,  num ratePerKm,  num ratePerMin,  num minFare,  int sortOrder)?  vehicleTypeCreateRequested,TResult? Function( DashboardVehicleTypeEntity vehicleType)?  vehicleTypeUpdateRequested,TResult? Function( num discountPercent)?  tripDiscountUpdateRequested,TResult? Function( String currencyCode)?  currencyUpdateRequested,}) {final _that = this;
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
return adminTripsRequested(_that.status,_that.preservePagination);case _AdminTripsNextPageRequested() when adminTripsNextPageRequested != null:
return adminTripsNextPageRequested();case _AdminTripsSearchChanged() when adminTripsSearchChanged != null:
return adminTripsSearchChanged(_that.query);case _AdminTripsCustomerChanged() when adminTripsCustomerChanged != null:
return adminTripsCustomerChanged(_that.passengerId,_that.name);case _AdminTripStatusPatched() when adminTripStatusPatched != null:
return adminTripStatusPatched(_that.tripId,_that.newStatus);case _TripDetailsRequested() when tripDetailsRequested != null:
return tripDetailsRequested(_that.tripId);case _TripFinancialsRequested() when tripFinancialsRequested != null:
return tripFinancialsRequested(_that.tripId);case _UserWalletRequested() when userWalletRequested != null:
return userWalletRequested(_that.userId);case _AdminConfigRequested() when adminConfigRequested != null:
return adminConfigRequested();case _AdminVehicleTypesRequested() when adminVehicleTypesRequested != null:
return adminVehicleTypesRequested();case _VehicleTypeStatusToggleRequested() when vehicleTypeStatusToggleRequested != null:
return vehicleTypeStatusToggleRequested(_that.vehicleType);case _VehicleTypeRemovalRequested() when vehicleTypeRemovalRequested != null:
return vehicleTypeRemovalRequested(_that.vehicleTypeId);case _VehicleTypeCreateRequested() when vehicleTypeCreateRequested != null:
return vehicleTypeCreateRequested(_that.code,_that.name,_that.capacity,_that.ratePerKm,_that.ratePerMin,_that.minFare,_that.sortOrder);case _VehicleTypeUpdateRequested() when vehicleTypeUpdateRequested != null:
return vehicleTypeUpdateRequested(_that.vehicleType);case _TripDiscountUpdateRequested() when tripDiscountUpdateRequested != null:
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
  const _AdminTripsRequested({this.status, this.preservePagination = false});
  

 final  String? status;
@JsonKey() final  bool preservePagination;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminTripsRequestedCopyWith<_AdminTripsRequested> get copyWith => __$AdminTripsRequestedCopyWithImpl<_AdminTripsRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminTripsRequested&&(identical(other.status, status) || other.status == status)&&(identical(other.preservePagination, preservePagination) || other.preservePagination == preservePagination));
}


@override
int get hashCode => Object.hash(runtimeType,status,preservePagination);

@override
String toString() {
  return 'DashboardEvent.adminTripsRequested(status: $status, preservePagination: $preservePagination)';
}


}

/// @nodoc
abstract mixin class _$AdminTripsRequestedCopyWith<$Res> implements $DashboardEventCopyWith<$Res> {
  factory _$AdminTripsRequestedCopyWith(_AdminTripsRequested value, $Res Function(_AdminTripsRequested) _then) = __$AdminTripsRequestedCopyWithImpl;
@useResult
$Res call({
 String? status, bool preservePagination
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
@pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? preservePagination = null,}) {
  return _then(_AdminTripsRequested(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,preservePagination: null == preservePagination ? _self.preservePagination : preservePagination // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _AdminTripsNextPageRequested implements DashboardEvent {
  const _AdminTripsNextPageRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminTripsNextPageRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardEvent.adminTripsNextPageRequested()';
}


}




/// @nodoc


class _AdminTripsSearchChanged implements DashboardEvent {
  const _AdminTripsSearchChanged(this.query);
  

 final  String query;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminTripsSearchChangedCopyWith<_AdminTripsSearchChanged> get copyWith => __$AdminTripsSearchChangedCopyWithImpl<_AdminTripsSearchChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminTripsSearchChanged&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'DashboardEvent.adminTripsSearchChanged(query: $query)';
}


}

/// @nodoc
abstract mixin class _$AdminTripsSearchChangedCopyWith<$Res> implements $DashboardEventCopyWith<$Res> {
  factory _$AdminTripsSearchChangedCopyWith(_AdminTripsSearchChanged value, $Res Function(_AdminTripsSearchChanged) _then) = __$AdminTripsSearchChangedCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class __$AdminTripsSearchChangedCopyWithImpl<$Res>
    implements _$AdminTripsSearchChangedCopyWith<$Res> {
  __$AdminTripsSearchChangedCopyWithImpl(this._self, this._then);

  final _AdminTripsSearchChanged _self;
  final $Res Function(_AdminTripsSearchChanged) _then;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_AdminTripsSearchChanged(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _AdminTripsCustomerChanged implements DashboardEvent {
  const _AdminTripsCustomerChanged({this.passengerId, this.name});
  

 final  String? passengerId;
 final  String? name;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminTripsCustomerChangedCopyWith<_AdminTripsCustomerChanged> get copyWith => __$AdminTripsCustomerChangedCopyWithImpl<_AdminTripsCustomerChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminTripsCustomerChanged&&(identical(other.passengerId, passengerId) || other.passengerId == passengerId)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,passengerId,name);

@override
String toString() {
  return 'DashboardEvent.adminTripsCustomerChanged(passengerId: $passengerId, name: $name)';
}


}

/// @nodoc
abstract mixin class _$AdminTripsCustomerChangedCopyWith<$Res> implements $DashboardEventCopyWith<$Res> {
  factory _$AdminTripsCustomerChangedCopyWith(_AdminTripsCustomerChanged value, $Res Function(_AdminTripsCustomerChanged) _then) = __$AdminTripsCustomerChangedCopyWithImpl;
@useResult
$Res call({
 String? passengerId, String? name
});




}
/// @nodoc
class __$AdminTripsCustomerChangedCopyWithImpl<$Res>
    implements _$AdminTripsCustomerChangedCopyWith<$Res> {
  __$AdminTripsCustomerChangedCopyWithImpl(this._self, this._then);

  final _AdminTripsCustomerChanged _self;
  final $Res Function(_AdminTripsCustomerChanged) _then;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? passengerId = freezed,Object? name = freezed,}) {
  return _then(_AdminTripsCustomerChanged(
passengerId: freezed == passengerId ? _self.passengerId : passengerId // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _AdminTripStatusPatched implements DashboardEvent {
  const _AdminTripStatusPatched({required this.tripId, required this.newStatus});
  

 final  String tripId;
 final  String newStatus;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminTripStatusPatchedCopyWith<_AdminTripStatusPatched> get copyWith => __$AdminTripStatusPatchedCopyWithImpl<_AdminTripStatusPatched>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminTripStatusPatched&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.newStatus, newStatus) || other.newStatus == newStatus));
}


@override
int get hashCode => Object.hash(runtimeType,tripId,newStatus);

@override
String toString() {
  return 'DashboardEvent.adminTripStatusPatched(tripId: $tripId, newStatus: $newStatus)';
}


}

/// @nodoc
abstract mixin class _$AdminTripStatusPatchedCopyWith<$Res> implements $DashboardEventCopyWith<$Res> {
  factory _$AdminTripStatusPatchedCopyWith(_AdminTripStatusPatched value, $Res Function(_AdminTripStatusPatched) _then) = __$AdminTripStatusPatchedCopyWithImpl;
@useResult
$Res call({
 String tripId, String newStatus
});




}
/// @nodoc
class __$AdminTripStatusPatchedCopyWithImpl<$Res>
    implements _$AdminTripStatusPatchedCopyWith<$Res> {
  __$AdminTripStatusPatchedCopyWithImpl(this._self, this._then);

  final _AdminTripStatusPatched _self;
  final $Res Function(_AdminTripStatusPatched) _then;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? newStatus = null,}) {
  return _then(_AdminTripStatusPatched(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,newStatus: null == newStatus ? _self.newStatus : newStatus // ignore: cast_nullable_to_non_nullable
as String,
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


class _TripFinancialsRequested implements DashboardEvent {
  const _TripFinancialsRequested(this.tripId);
  

 final  String tripId;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripFinancialsRequestedCopyWith<_TripFinancialsRequested> get copyWith => __$TripFinancialsRequestedCopyWithImpl<_TripFinancialsRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripFinancialsRequested&&(identical(other.tripId, tripId) || other.tripId == tripId));
}


@override
int get hashCode => Object.hash(runtimeType,tripId);

@override
String toString() {
  return 'DashboardEvent.tripFinancialsRequested(tripId: $tripId)';
}


}

/// @nodoc
abstract mixin class _$TripFinancialsRequestedCopyWith<$Res> implements $DashboardEventCopyWith<$Res> {
  factory _$TripFinancialsRequestedCopyWith(_TripFinancialsRequested value, $Res Function(_TripFinancialsRequested) _then) = __$TripFinancialsRequestedCopyWithImpl;
@useResult
$Res call({
 String tripId
});




}
/// @nodoc
class __$TripFinancialsRequestedCopyWithImpl<$Res>
    implements _$TripFinancialsRequestedCopyWith<$Res> {
  __$TripFinancialsRequestedCopyWithImpl(this._self, this._then);

  final _TripFinancialsRequested _self;
  final $Res Function(_TripFinancialsRequested) _then;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tripId = null,}) {
  return _then(_TripFinancialsRequested(
null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _UserWalletRequested implements DashboardEvent {
  const _UserWalletRequested(this.userId);
  

 final  String userId;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserWalletRequestedCopyWith<_UserWalletRequested> get copyWith => __$UserWalletRequestedCopyWithImpl<_UserWalletRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserWalletRequested&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,userId);

@override
String toString() {
  return 'DashboardEvent.userWalletRequested(userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$UserWalletRequestedCopyWith<$Res> implements $DashboardEventCopyWith<$Res> {
  factory _$UserWalletRequestedCopyWith(_UserWalletRequested value, $Res Function(_UserWalletRequested) _then) = __$UserWalletRequestedCopyWithImpl;
@useResult
$Res call({
 String userId
});




}
/// @nodoc
class __$UserWalletRequestedCopyWithImpl<$Res>
    implements _$UserWalletRequestedCopyWith<$Res> {
  __$UserWalletRequestedCopyWithImpl(this._self, this._then);

  final _UserWalletRequested _self;
  final $Res Function(_UserWalletRequested) _then;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userId = null,}) {
  return _then(_UserWalletRequested(
null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _AdminConfigRequested implements DashboardEvent {
  const _AdminConfigRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminConfigRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardEvent.adminConfigRequested()';
}


}




/// @nodoc


class _AdminVehicleTypesRequested implements DashboardEvent {
  const _AdminVehicleTypesRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminVehicleTypesRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardEvent.adminVehicleTypesRequested()';
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


class _VehicleTypeCreateRequested implements DashboardEvent {
  const _VehicleTypeCreateRequested({required this.code, required this.name, required this.capacity, required this.ratePerKm, required this.ratePerMin, required this.minFare, required this.sortOrder});
  

 final  String code;
 final  String name;
 final  int capacity;
 final  num ratePerKm;
 final  num ratePerMin;
 final  num minFare;
 final  int sortOrder;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VehicleTypeCreateRequestedCopyWith<_VehicleTypeCreateRequested> get copyWith => __$VehicleTypeCreateRequestedCopyWithImpl<_VehicleTypeCreateRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VehicleTypeCreateRequested&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.capacity, capacity) || other.capacity == capacity)&&(identical(other.ratePerKm, ratePerKm) || other.ratePerKm == ratePerKm)&&(identical(other.ratePerMin, ratePerMin) || other.ratePerMin == ratePerMin)&&(identical(other.minFare, minFare) || other.minFare == minFare)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,code,name,capacity,ratePerKm,ratePerMin,minFare,sortOrder);

@override
String toString() {
  return 'DashboardEvent.vehicleTypeCreateRequested(code: $code, name: $name, capacity: $capacity, ratePerKm: $ratePerKm, ratePerMin: $ratePerMin, minFare: $minFare, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$VehicleTypeCreateRequestedCopyWith<$Res> implements $DashboardEventCopyWith<$Res> {
  factory _$VehicleTypeCreateRequestedCopyWith(_VehicleTypeCreateRequested value, $Res Function(_VehicleTypeCreateRequested) _then) = __$VehicleTypeCreateRequestedCopyWithImpl;
@useResult
$Res call({
 String code, String name, int capacity, num ratePerKm, num ratePerMin, num minFare, int sortOrder
});




}
/// @nodoc
class __$VehicleTypeCreateRequestedCopyWithImpl<$Res>
    implements _$VehicleTypeCreateRequestedCopyWith<$Res> {
  __$VehicleTypeCreateRequestedCopyWithImpl(this._self, this._then);

  final _VehicleTypeCreateRequested _self;
  final $Res Function(_VehicleTypeCreateRequested) _then;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? capacity = null,Object? ratePerKm = null,Object? ratePerMin = null,Object? minFare = null,Object? sortOrder = null,}) {
  return _then(_VehicleTypeCreateRequested(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,ratePerKm: null == ratePerKm ? _self.ratePerKm : ratePerKm // ignore: cast_nullable_to_non_nullable
as num,ratePerMin: null == ratePerMin ? _self.ratePerMin : ratePerMin // ignore: cast_nullable_to_non_nullable
as num,minFare: null == minFare ? _self.minFare : minFare // ignore: cast_nullable_to_non_nullable
as num,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _VehicleTypeUpdateRequested implements DashboardEvent {
  const _VehicleTypeUpdateRequested(this.vehicleType);
  

 final  DashboardVehicleTypeEntity vehicleType;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VehicleTypeUpdateRequestedCopyWith<_VehicleTypeUpdateRequested> get copyWith => __$VehicleTypeUpdateRequestedCopyWithImpl<_VehicleTypeUpdateRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VehicleTypeUpdateRequested&&(identical(other.vehicleType, vehicleType) || other.vehicleType == vehicleType));
}


@override
int get hashCode => Object.hash(runtimeType,vehicleType);

@override
String toString() {
  return 'DashboardEvent.vehicleTypeUpdateRequested(vehicleType: $vehicleType)';
}


}

/// @nodoc
abstract mixin class _$VehicleTypeUpdateRequestedCopyWith<$Res> implements $DashboardEventCopyWith<$Res> {
  factory _$VehicleTypeUpdateRequestedCopyWith(_VehicleTypeUpdateRequested value, $Res Function(_VehicleTypeUpdateRequested) _then) = __$VehicleTypeUpdateRequestedCopyWithImpl;
@useResult
$Res call({
 DashboardVehicleTypeEntity vehicleType
});




}
/// @nodoc
class __$VehicleTypeUpdateRequestedCopyWithImpl<$Res>
    implements _$VehicleTypeUpdateRequestedCopyWith<$Res> {
  __$VehicleTypeUpdateRequestedCopyWithImpl(this._self, this._then);

  final _VehicleTypeUpdateRequested _self;
  final $Res Function(_VehicleTypeUpdateRequested) _then;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? vehicleType = null,}) {
  return _then(_VehicleTypeUpdateRequested(
null == vehicleType ? _self.vehicleType : vehicleType // ignore: cast_nullable_to_non_nullable
as DashboardVehicleTypeEntity,
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

 BlocStatus<DashboardEntity> get overviewState; BlocStatus<List<DashboardDriverDocumentEntity>> get driverDocumentsState; BlocStatus<void> get documentReviewState; BlocStatus<void> get driverApprovalState; BlocStatus<void> get tripAssignmentState; BlocStatus<List<DashboardDriverLocationEntity>> get driverLocationsState; BlocStatus<List<DashboardTripEntity>> get adminTripsState; int get adminTripsPage; bool get adminTripsHasMore; bool get adminTripsLoadingMore; String get adminTripsSearch; String get adminTripsPassengerId; String get adminTripsPassengerName; BlocStatus<DashboardTripDetailsEntity> get tripDetailsState; BlocStatus<DashboardTripFinancialsEntity> get tripFinancialsState; BlocStatus<DashboardUserWalletEntity> get userWalletState;// --- Control Center admin states ---
 BlocStatus<DashboardSystemConfigEntity> get adminConfigState; BlocStatus<List<DashboardVehicleTypeEntity>> get adminVehicleTypesState;// Per-section action loading (scoped instead of shared)
 BlocStatus<void> get configActionState; BlocStatus<void> get vehicleTypeActionState; String? get selectedDriverId; String? get selectedTripId;
/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardStateCopyWith<DashboardState> get copyWith => _$DashboardStateCopyWithImpl<DashboardState>(this as DashboardState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardState&&(identical(other.overviewState, overviewState) || other.overviewState == overviewState)&&(identical(other.driverDocumentsState, driverDocumentsState) || other.driverDocumentsState == driverDocumentsState)&&(identical(other.documentReviewState, documentReviewState) || other.documentReviewState == documentReviewState)&&(identical(other.driverApprovalState, driverApprovalState) || other.driverApprovalState == driverApprovalState)&&(identical(other.tripAssignmentState, tripAssignmentState) || other.tripAssignmentState == tripAssignmentState)&&(identical(other.driverLocationsState, driverLocationsState) || other.driverLocationsState == driverLocationsState)&&(identical(other.adminTripsState, adminTripsState) || other.adminTripsState == adminTripsState)&&(identical(other.adminTripsPage, adminTripsPage) || other.adminTripsPage == adminTripsPage)&&(identical(other.adminTripsHasMore, adminTripsHasMore) || other.adminTripsHasMore == adminTripsHasMore)&&(identical(other.adminTripsLoadingMore, adminTripsLoadingMore) || other.adminTripsLoadingMore == adminTripsLoadingMore)&&(identical(other.adminTripsSearch, adminTripsSearch) || other.adminTripsSearch == adminTripsSearch)&&(identical(other.adminTripsPassengerId, adminTripsPassengerId) || other.adminTripsPassengerId == adminTripsPassengerId)&&(identical(other.adminTripsPassengerName, adminTripsPassengerName) || other.adminTripsPassengerName == adminTripsPassengerName)&&(identical(other.tripDetailsState, tripDetailsState) || other.tripDetailsState == tripDetailsState)&&(identical(other.tripFinancialsState, tripFinancialsState) || other.tripFinancialsState == tripFinancialsState)&&(identical(other.userWalletState, userWalletState) || other.userWalletState == userWalletState)&&(identical(other.adminConfigState, adminConfigState) || other.adminConfigState == adminConfigState)&&(identical(other.adminVehicleTypesState, adminVehicleTypesState) || other.adminVehicleTypesState == adminVehicleTypesState)&&(identical(other.configActionState, configActionState) || other.configActionState == configActionState)&&(identical(other.vehicleTypeActionState, vehicleTypeActionState) || other.vehicleTypeActionState == vehicleTypeActionState)&&(identical(other.selectedDriverId, selectedDriverId) || other.selectedDriverId == selectedDriverId)&&(identical(other.selectedTripId, selectedTripId) || other.selectedTripId == selectedTripId));
}


@override
int get hashCode => Object.hashAll([runtimeType,overviewState,driverDocumentsState,documentReviewState,driverApprovalState,tripAssignmentState,driverLocationsState,adminTripsState,adminTripsPage,adminTripsHasMore,adminTripsLoadingMore,adminTripsSearch,adminTripsPassengerId,adminTripsPassengerName,tripDetailsState,tripFinancialsState,userWalletState,adminConfigState,adminVehicleTypesState,configActionState,vehicleTypeActionState,selectedDriverId,selectedTripId]);

@override
String toString() {
  return 'DashboardState(overviewState: $overviewState, driverDocumentsState: $driverDocumentsState, documentReviewState: $documentReviewState, driverApprovalState: $driverApprovalState, tripAssignmentState: $tripAssignmentState, driverLocationsState: $driverLocationsState, adminTripsState: $adminTripsState, adminTripsPage: $adminTripsPage, adminTripsHasMore: $adminTripsHasMore, adminTripsLoadingMore: $adminTripsLoadingMore, adminTripsSearch: $adminTripsSearch, adminTripsPassengerId: $adminTripsPassengerId, adminTripsPassengerName: $adminTripsPassengerName, tripDetailsState: $tripDetailsState, tripFinancialsState: $tripFinancialsState, userWalletState: $userWalletState, adminConfigState: $adminConfigState, adminVehicleTypesState: $adminVehicleTypesState, configActionState: $configActionState, vehicleTypeActionState: $vehicleTypeActionState, selectedDriverId: $selectedDriverId, selectedTripId: $selectedTripId)';
}


}

/// @nodoc
abstract mixin class $DashboardStateCopyWith<$Res>  {
  factory $DashboardStateCopyWith(DashboardState value, $Res Function(DashboardState) _then) = _$DashboardStateCopyWithImpl;
@useResult
$Res call({
 BlocStatus<DashboardEntity> overviewState, BlocStatus<List<DashboardDriverDocumentEntity>> driverDocumentsState, BlocStatus<void> documentReviewState, BlocStatus<void> driverApprovalState, BlocStatus<void> tripAssignmentState, BlocStatus<List<DashboardDriverLocationEntity>> driverLocationsState, BlocStatus<List<DashboardTripEntity>> adminTripsState, int adminTripsPage, bool adminTripsHasMore, bool adminTripsLoadingMore, String adminTripsSearch, String adminTripsPassengerId, String adminTripsPassengerName, BlocStatus<DashboardTripDetailsEntity> tripDetailsState, BlocStatus<DashboardTripFinancialsEntity> tripFinancialsState, BlocStatus<DashboardUserWalletEntity> userWalletState, BlocStatus<DashboardSystemConfigEntity> adminConfigState, BlocStatus<List<DashboardVehicleTypeEntity>> adminVehicleTypesState, BlocStatus<void> configActionState, BlocStatus<void> vehicleTypeActionState, String? selectedDriverId, String? selectedTripId
});


$BlocStatusCopyWith<DashboardEntity, $Res> get overviewState;$BlocStatusCopyWith<List<DashboardDriverDocumentEntity>, $Res> get driverDocumentsState;$BlocStatusCopyWith<void, $Res> get documentReviewState;$BlocStatusCopyWith<void, $Res> get driverApprovalState;$BlocStatusCopyWith<void, $Res> get tripAssignmentState;$BlocStatusCopyWith<List<DashboardDriverLocationEntity>, $Res> get driverLocationsState;$BlocStatusCopyWith<List<DashboardTripEntity>, $Res> get adminTripsState;$BlocStatusCopyWith<DashboardTripDetailsEntity, $Res> get tripDetailsState;$BlocStatusCopyWith<DashboardTripFinancialsEntity, $Res> get tripFinancialsState;$BlocStatusCopyWith<DashboardUserWalletEntity, $Res> get userWalletState;$BlocStatusCopyWith<DashboardSystemConfigEntity, $Res> get adminConfigState;$BlocStatusCopyWith<List<DashboardVehicleTypeEntity>, $Res> get adminVehicleTypesState;$BlocStatusCopyWith<void, $Res> get configActionState;$BlocStatusCopyWith<void, $Res> get vehicleTypeActionState;

}
/// @nodoc
class _$DashboardStateCopyWithImpl<$Res>
    implements $DashboardStateCopyWith<$Res> {
  _$DashboardStateCopyWithImpl(this._self, this._then);

  final DashboardState _self;
  final $Res Function(DashboardState) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? overviewState = null,Object? driverDocumentsState = null,Object? documentReviewState = null,Object? driverApprovalState = null,Object? tripAssignmentState = null,Object? driverLocationsState = null,Object? adminTripsState = null,Object? adminTripsPage = null,Object? adminTripsHasMore = null,Object? adminTripsLoadingMore = null,Object? adminTripsSearch = null,Object? adminTripsPassengerId = null,Object? adminTripsPassengerName = null,Object? tripDetailsState = null,Object? tripFinancialsState = null,Object? userWalletState = null,Object? adminConfigState = null,Object? adminVehicleTypesState = null,Object? configActionState = null,Object? vehicleTypeActionState = null,Object? selectedDriverId = freezed,Object? selectedTripId = freezed,}) {
  return _then(_self.copyWith(
overviewState: null == overviewState ? _self.overviewState : overviewState // ignore: cast_nullable_to_non_nullable
as BlocStatus<DashboardEntity>,driverDocumentsState: null == driverDocumentsState ? _self.driverDocumentsState : driverDocumentsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<DashboardDriverDocumentEntity>>,documentReviewState: null == documentReviewState ? _self.documentReviewState : documentReviewState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,driverApprovalState: null == driverApprovalState ? _self.driverApprovalState : driverApprovalState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,tripAssignmentState: null == tripAssignmentState ? _self.tripAssignmentState : tripAssignmentState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,driverLocationsState: null == driverLocationsState ? _self.driverLocationsState : driverLocationsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<DashboardDriverLocationEntity>>,adminTripsState: null == adminTripsState ? _self.adminTripsState : adminTripsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<DashboardTripEntity>>,adminTripsPage: null == adminTripsPage ? _self.adminTripsPage : adminTripsPage // ignore: cast_nullable_to_non_nullable
as int,adminTripsHasMore: null == adminTripsHasMore ? _self.adminTripsHasMore : adminTripsHasMore // ignore: cast_nullable_to_non_nullable
as bool,adminTripsLoadingMore: null == adminTripsLoadingMore ? _self.adminTripsLoadingMore : adminTripsLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,adminTripsSearch: null == adminTripsSearch ? _self.adminTripsSearch : adminTripsSearch // ignore: cast_nullable_to_non_nullable
as String,adminTripsPassengerId: null == adminTripsPassengerId ? _self.adminTripsPassengerId : adminTripsPassengerId // ignore: cast_nullable_to_non_nullable
as String,adminTripsPassengerName: null == adminTripsPassengerName ? _self.adminTripsPassengerName : adminTripsPassengerName // ignore: cast_nullable_to_non_nullable
as String,tripDetailsState: null == tripDetailsState ? _self.tripDetailsState : tripDetailsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<DashboardTripDetailsEntity>,tripFinancialsState: null == tripFinancialsState ? _self.tripFinancialsState : tripFinancialsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<DashboardTripFinancialsEntity>,userWalletState: null == userWalletState ? _self.userWalletState : userWalletState // ignore: cast_nullable_to_non_nullable
as BlocStatus<DashboardUserWalletEntity>,adminConfigState: null == adminConfigState ? _self.adminConfigState : adminConfigState // ignore: cast_nullable_to_non_nullable
as BlocStatus<DashboardSystemConfigEntity>,adminVehicleTypesState: null == adminVehicleTypesState ? _self.adminVehicleTypesState : adminVehicleTypesState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<DashboardVehicleTypeEntity>>,configActionState: null == configActionState ? _self.configActionState : configActionState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,vehicleTypeActionState: null == vehicleTypeActionState ? _self.vehicleTypeActionState : vehicleTypeActionState // ignore: cast_nullable_to_non_nullable
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
$BlocStatusCopyWith<DashboardTripFinancialsEntity, $Res> get tripFinancialsState {
  
  return $BlocStatusCopyWith<DashboardTripFinancialsEntity, $Res>(_self.tripFinancialsState, (value) {
    return _then(_self.copyWith(tripFinancialsState: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<DashboardUserWalletEntity, $Res> get userWalletState {
  
  return $BlocStatusCopyWith<DashboardUserWalletEntity, $Res>(_self.userWalletState, (value) {
    return _then(_self.copyWith(userWalletState: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<DashboardSystemConfigEntity, $Res> get adminConfigState {
  
  return $BlocStatusCopyWith<DashboardSystemConfigEntity, $Res>(_self.adminConfigState, (value) {
    return _then(_self.copyWith(adminConfigState: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<DashboardVehicleTypeEntity>, $Res> get adminVehicleTypesState {
  
  return $BlocStatusCopyWith<List<DashboardVehicleTypeEntity>, $Res>(_self.adminVehicleTypesState, (value) {
    return _then(_self.copyWith(adminVehicleTypesState: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get configActionState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.configActionState, (value) {
    return _then(_self.copyWith(configActionState: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get vehicleTypeActionState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.vehicleTypeActionState, (value) {
    return _then(_self.copyWith(vehicleTypeActionState: value));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BlocStatus<DashboardEntity> overviewState,  BlocStatus<List<DashboardDriverDocumentEntity>> driverDocumentsState,  BlocStatus<void> documentReviewState,  BlocStatus<void> driverApprovalState,  BlocStatus<void> tripAssignmentState,  BlocStatus<List<DashboardDriverLocationEntity>> driverLocationsState,  BlocStatus<List<DashboardTripEntity>> adminTripsState,  int adminTripsPage,  bool adminTripsHasMore,  bool adminTripsLoadingMore,  String adminTripsSearch,  String adminTripsPassengerId,  String adminTripsPassengerName,  BlocStatus<DashboardTripDetailsEntity> tripDetailsState,  BlocStatus<DashboardTripFinancialsEntity> tripFinancialsState,  BlocStatus<DashboardUserWalletEntity> userWalletState,  BlocStatus<DashboardSystemConfigEntity> adminConfigState,  BlocStatus<List<DashboardVehicleTypeEntity>> adminVehicleTypesState,  BlocStatus<void> configActionState,  BlocStatus<void> vehicleTypeActionState,  String? selectedDriverId,  String? selectedTripId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
return $default(_that.overviewState,_that.driverDocumentsState,_that.documentReviewState,_that.driverApprovalState,_that.tripAssignmentState,_that.driverLocationsState,_that.adminTripsState,_that.adminTripsPage,_that.adminTripsHasMore,_that.adminTripsLoadingMore,_that.adminTripsSearch,_that.adminTripsPassengerId,_that.adminTripsPassengerName,_that.tripDetailsState,_that.tripFinancialsState,_that.userWalletState,_that.adminConfigState,_that.adminVehicleTypesState,_that.configActionState,_that.vehicleTypeActionState,_that.selectedDriverId,_that.selectedTripId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BlocStatus<DashboardEntity> overviewState,  BlocStatus<List<DashboardDriverDocumentEntity>> driverDocumentsState,  BlocStatus<void> documentReviewState,  BlocStatus<void> driverApprovalState,  BlocStatus<void> tripAssignmentState,  BlocStatus<List<DashboardDriverLocationEntity>> driverLocationsState,  BlocStatus<List<DashboardTripEntity>> adminTripsState,  int adminTripsPage,  bool adminTripsHasMore,  bool adminTripsLoadingMore,  String adminTripsSearch,  String adminTripsPassengerId,  String adminTripsPassengerName,  BlocStatus<DashboardTripDetailsEntity> tripDetailsState,  BlocStatus<DashboardTripFinancialsEntity> tripFinancialsState,  BlocStatus<DashboardUserWalletEntity> userWalletState,  BlocStatus<DashboardSystemConfigEntity> adminConfigState,  BlocStatus<List<DashboardVehicleTypeEntity>> adminVehicleTypesState,  BlocStatus<void> configActionState,  BlocStatus<void> vehicleTypeActionState,  String? selectedDriverId,  String? selectedTripId)  $default,) {final _that = this;
switch (_that) {
case _DashboardState():
return $default(_that.overviewState,_that.driverDocumentsState,_that.documentReviewState,_that.driverApprovalState,_that.tripAssignmentState,_that.driverLocationsState,_that.adminTripsState,_that.adminTripsPage,_that.adminTripsHasMore,_that.adminTripsLoadingMore,_that.adminTripsSearch,_that.adminTripsPassengerId,_that.adminTripsPassengerName,_that.tripDetailsState,_that.tripFinancialsState,_that.userWalletState,_that.adminConfigState,_that.adminVehicleTypesState,_that.configActionState,_that.vehicleTypeActionState,_that.selectedDriverId,_that.selectedTripId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BlocStatus<DashboardEntity> overviewState,  BlocStatus<List<DashboardDriverDocumentEntity>> driverDocumentsState,  BlocStatus<void> documentReviewState,  BlocStatus<void> driverApprovalState,  BlocStatus<void> tripAssignmentState,  BlocStatus<List<DashboardDriverLocationEntity>> driverLocationsState,  BlocStatus<List<DashboardTripEntity>> adminTripsState,  int adminTripsPage,  bool adminTripsHasMore,  bool adminTripsLoadingMore,  String adminTripsSearch,  String adminTripsPassengerId,  String adminTripsPassengerName,  BlocStatus<DashboardTripDetailsEntity> tripDetailsState,  BlocStatus<DashboardTripFinancialsEntity> tripFinancialsState,  BlocStatus<DashboardUserWalletEntity> userWalletState,  BlocStatus<DashboardSystemConfigEntity> adminConfigState,  BlocStatus<List<DashboardVehicleTypeEntity>> adminVehicleTypesState,  BlocStatus<void> configActionState,  BlocStatus<void> vehicleTypeActionState,  String? selectedDriverId,  String? selectedTripId)?  $default,) {final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
return $default(_that.overviewState,_that.driverDocumentsState,_that.documentReviewState,_that.driverApprovalState,_that.tripAssignmentState,_that.driverLocationsState,_that.adminTripsState,_that.adminTripsPage,_that.adminTripsHasMore,_that.adminTripsLoadingMore,_that.adminTripsSearch,_that.adminTripsPassengerId,_that.adminTripsPassengerName,_that.tripDetailsState,_that.tripFinancialsState,_that.userWalletState,_that.adminConfigState,_that.adminVehicleTypesState,_that.configActionState,_that.vehicleTypeActionState,_that.selectedDriverId,_that.selectedTripId);case _:
  return null;

}
}

}

/// @nodoc


class _DashboardState implements DashboardState {
  const _DashboardState({this.overviewState = const BlocStatus<DashboardEntity>.initial(), this.driverDocumentsState = const BlocStatus<List<DashboardDriverDocumentEntity>>.initial(), this.documentReviewState = const BlocStatus<void>.initial(), this.driverApprovalState = const BlocStatus<void>.initial(), this.tripAssignmentState = const BlocStatus<void>.initial(), this.driverLocationsState = const BlocStatus<List<DashboardDriverLocationEntity>>.initial(), this.adminTripsState = const BlocStatus<List<DashboardTripEntity>>.initial(), this.adminTripsPage = 1, this.adminTripsHasMore = true, this.adminTripsLoadingMore = false, this.adminTripsSearch = '', this.adminTripsPassengerId = '', this.adminTripsPassengerName = '', this.tripDetailsState = const BlocStatus<DashboardTripDetailsEntity>.initial(), this.tripFinancialsState = const BlocStatus<DashboardTripFinancialsEntity>.initial(), this.userWalletState = const BlocStatus<DashboardUserWalletEntity>.initial(), this.adminConfigState = const BlocStatus<DashboardSystemConfigEntity>.initial(), this.adminVehicleTypesState = const BlocStatus<List<DashboardVehicleTypeEntity>>.initial(), this.configActionState = const BlocStatus<void>.initial(), this.vehicleTypeActionState = const BlocStatus<void>.initial(), this.selectedDriverId, this.selectedTripId});
  

@override@JsonKey() final  BlocStatus<DashboardEntity> overviewState;
@override@JsonKey() final  BlocStatus<List<DashboardDriverDocumentEntity>> driverDocumentsState;
@override@JsonKey() final  BlocStatus<void> documentReviewState;
@override@JsonKey() final  BlocStatus<void> driverApprovalState;
@override@JsonKey() final  BlocStatus<void> tripAssignmentState;
@override@JsonKey() final  BlocStatus<List<DashboardDriverLocationEntity>> driverLocationsState;
@override@JsonKey() final  BlocStatus<List<DashboardTripEntity>> adminTripsState;
@override@JsonKey() final  int adminTripsPage;
@override@JsonKey() final  bool adminTripsHasMore;
@override@JsonKey() final  bool adminTripsLoadingMore;
@override@JsonKey() final  String adminTripsSearch;
@override@JsonKey() final  String adminTripsPassengerId;
@override@JsonKey() final  String adminTripsPassengerName;
@override@JsonKey() final  BlocStatus<DashboardTripDetailsEntity> tripDetailsState;
@override@JsonKey() final  BlocStatus<DashboardTripFinancialsEntity> tripFinancialsState;
@override@JsonKey() final  BlocStatus<DashboardUserWalletEntity> userWalletState;
// --- Control Center admin states ---
@override@JsonKey() final  BlocStatus<DashboardSystemConfigEntity> adminConfigState;
@override@JsonKey() final  BlocStatus<List<DashboardVehicleTypeEntity>> adminVehicleTypesState;
// Per-section action loading (scoped instead of shared)
@override@JsonKey() final  BlocStatus<void> configActionState;
@override@JsonKey() final  BlocStatus<void> vehicleTypeActionState;
@override final  String? selectedDriverId;
@override final  String? selectedTripId;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardStateCopyWith<_DashboardState> get copyWith => __$DashboardStateCopyWithImpl<_DashboardState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardState&&(identical(other.overviewState, overviewState) || other.overviewState == overviewState)&&(identical(other.driverDocumentsState, driverDocumentsState) || other.driverDocumentsState == driverDocumentsState)&&(identical(other.documentReviewState, documentReviewState) || other.documentReviewState == documentReviewState)&&(identical(other.driverApprovalState, driverApprovalState) || other.driverApprovalState == driverApprovalState)&&(identical(other.tripAssignmentState, tripAssignmentState) || other.tripAssignmentState == tripAssignmentState)&&(identical(other.driverLocationsState, driverLocationsState) || other.driverLocationsState == driverLocationsState)&&(identical(other.adminTripsState, adminTripsState) || other.adminTripsState == adminTripsState)&&(identical(other.adminTripsPage, adminTripsPage) || other.adminTripsPage == adminTripsPage)&&(identical(other.adminTripsHasMore, adminTripsHasMore) || other.adminTripsHasMore == adminTripsHasMore)&&(identical(other.adminTripsLoadingMore, adminTripsLoadingMore) || other.adminTripsLoadingMore == adminTripsLoadingMore)&&(identical(other.adminTripsSearch, adminTripsSearch) || other.adminTripsSearch == adminTripsSearch)&&(identical(other.adminTripsPassengerId, adminTripsPassengerId) || other.adminTripsPassengerId == adminTripsPassengerId)&&(identical(other.adminTripsPassengerName, adminTripsPassengerName) || other.adminTripsPassengerName == adminTripsPassengerName)&&(identical(other.tripDetailsState, tripDetailsState) || other.tripDetailsState == tripDetailsState)&&(identical(other.tripFinancialsState, tripFinancialsState) || other.tripFinancialsState == tripFinancialsState)&&(identical(other.userWalletState, userWalletState) || other.userWalletState == userWalletState)&&(identical(other.adminConfigState, adminConfigState) || other.adminConfigState == adminConfigState)&&(identical(other.adminVehicleTypesState, adminVehicleTypesState) || other.adminVehicleTypesState == adminVehicleTypesState)&&(identical(other.configActionState, configActionState) || other.configActionState == configActionState)&&(identical(other.vehicleTypeActionState, vehicleTypeActionState) || other.vehicleTypeActionState == vehicleTypeActionState)&&(identical(other.selectedDriverId, selectedDriverId) || other.selectedDriverId == selectedDriverId)&&(identical(other.selectedTripId, selectedTripId) || other.selectedTripId == selectedTripId));
}


@override
int get hashCode => Object.hashAll([runtimeType,overviewState,driverDocumentsState,documentReviewState,driverApprovalState,tripAssignmentState,driverLocationsState,adminTripsState,adminTripsPage,adminTripsHasMore,adminTripsLoadingMore,adminTripsSearch,adminTripsPassengerId,adminTripsPassengerName,tripDetailsState,tripFinancialsState,userWalletState,adminConfigState,adminVehicleTypesState,configActionState,vehicleTypeActionState,selectedDriverId,selectedTripId]);

@override
String toString() {
  return 'DashboardState(overviewState: $overviewState, driverDocumentsState: $driverDocumentsState, documentReviewState: $documentReviewState, driverApprovalState: $driverApprovalState, tripAssignmentState: $tripAssignmentState, driverLocationsState: $driverLocationsState, adminTripsState: $adminTripsState, adminTripsPage: $adminTripsPage, adminTripsHasMore: $adminTripsHasMore, adminTripsLoadingMore: $adminTripsLoadingMore, adminTripsSearch: $adminTripsSearch, adminTripsPassengerId: $adminTripsPassengerId, adminTripsPassengerName: $adminTripsPassengerName, tripDetailsState: $tripDetailsState, tripFinancialsState: $tripFinancialsState, userWalletState: $userWalletState, adminConfigState: $adminConfigState, adminVehicleTypesState: $adminVehicleTypesState, configActionState: $configActionState, vehicleTypeActionState: $vehicleTypeActionState, selectedDriverId: $selectedDriverId, selectedTripId: $selectedTripId)';
}


}

/// @nodoc
abstract mixin class _$DashboardStateCopyWith<$Res> implements $DashboardStateCopyWith<$Res> {
  factory _$DashboardStateCopyWith(_DashboardState value, $Res Function(_DashboardState) _then) = __$DashboardStateCopyWithImpl;
@override @useResult
$Res call({
 BlocStatus<DashboardEntity> overviewState, BlocStatus<List<DashboardDriverDocumentEntity>> driverDocumentsState, BlocStatus<void> documentReviewState, BlocStatus<void> driverApprovalState, BlocStatus<void> tripAssignmentState, BlocStatus<List<DashboardDriverLocationEntity>> driverLocationsState, BlocStatus<List<DashboardTripEntity>> adminTripsState, int adminTripsPage, bool adminTripsHasMore, bool adminTripsLoadingMore, String adminTripsSearch, String adminTripsPassengerId, String adminTripsPassengerName, BlocStatus<DashboardTripDetailsEntity> tripDetailsState, BlocStatus<DashboardTripFinancialsEntity> tripFinancialsState, BlocStatus<DashboardUserWalletEntity> userWalletState, BlocStatus<DashboardSystemConfigEntity> adminConfigState, BlocStatus<List<DashboardVehicleTypeEntity>> adminVehicleTypesState, BlocStatus<void> configActionState, BlocStatus<void> vehicleTypeActionState, String? selectedDriverId, String? selectedTripId
});


@override $BlocStatusCopyWith<DashboardEntity, $Res> get overviewState;@override $BlocStatusCopyWith<List<DashboardDriverDocumentEntity>, $Res> get driverDocumentsState;@override $BlocStatusCopyWith<void, $Res> get documentReviewState;@override $BlocStatusCopyWith<void, $Res> get driverApprovalState;@override $BlocStatusCopyWith<void, $Res> get tripAssignmentState;@override $BlocStatusCopyWith<List<DashboardDriverLocationEntity>, $Res> get driverLocationsState;@override $BlocStatusCopyWith<List<DashboardTripEntity>, $Res> get adminTripsState;@override $BlocStatusCopyWith<DashboardTripDetailsEntity, $Res> get tripDetailsState;@override $BlocStatusCopyWith<DashboardTripFinancialsEntity, $Res> get tripFinancialsState;@override $BlocStatusCopyWith<DashboardUserWalletEntity, $Res> get userWalletState;@override $BlocStatusCopyWith<DashboardSystemConfigEntity, $Res> get adminConfigState;@override $BlocStatusCopyWith<List<DashboardVehicleTypeEntity>, $Res> get adminVehicleTypesState;@override $BlocStatusCopyWith<void, $Res> get configActionState;@override $BlocStatusCopyWith<void, $Res> get vehicleTypeActionState;

}
/// @nodoc
class __$DashboardStateCopyWithImpl<$Res>
    implements _$DashboardStateCopyWith<$Res> {
  __$DashboardStateCopyWithImpl(this._self, this._then);

  final _DashboardState _self;
  final $Res Function(_DashboardState) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? overviewState = null,Object? driverDocumentsState = null,Object? documentReviewState = null,Object? driverApprovalState = null,Object? tripAssignmentState = null,Object? driverLocationsState = null,Object? adminTripsState = null,Object? adminTripsPage = null,Object? adminTripsHasMore = null,Object? adminTripsLoadingMore = null,Object? adminTripsSearch = null,Object? adminTripsPassengerId = null,Object? adminTripsPassengerName = null,Object? tripDetailsState = null,Object? tripFinancialsState = null,Object? userWalletState = null,Object? adminConfigState = null,Object? adminVehicleTypesState = null,Object? configActionState = null,Object? vehicleTypeActionState = null,Object? selectedDriverId = freezed,Object? selectedTripId = freezed,}) {
  return _then(_DashboardState(
overviewState: null == overviewState ? _self.overviewState : overviewState // ignore: cast_nullable_to_non_nullable
as BlocStatus<DashboardEntity>,driverDocumentsState: null == driverDocumentsState ? _self.driverDocumentsState : driverDocumentsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<DashboardDriverDocumentEntity>>,documentReviewState: null == documentReviewState ? _self.documentReviewState : documentReviewState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,driverApprovalState: null == driverApprovalState ? _self.driverApprovalState : driverApprovalState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,tripAssignmentState: null == tripAssignmentState ? _self.tripAssignmentState : tripAssignmentState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,driverLocationsState: null == driverLocationsState ? _self.driverLocationsState : driverLocationsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<DashboardDriverLocationEntity>>,adminTripsState: null == adminTripsState ? _self.adminTripsState : adminTripsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<DashboardTripEntity>>,adminTripsPage: null == adminTripsPage ? _self.adminTripsPage : adminTripsPage // ignore: cast_nullable_to_non_nullable
as int,adminTripsHasMore: null == adminTripsHasMore ? _self.adminTripsHasMore : adminTripsHasMore // ignore: cast_nullable_to_non_nullable
as bool,adminTripsLoadingMore: null == adminTripsLoadingMore ? _self.adminTripsLoadingMore : adminTripsLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,adminTripsSearch: null == adminTripsSearch ? _self.adminTripsSearch : adminTripsSearch // ignore: cast_nullable_to_non_nullable
as String,adminTripsPassengerId: null == adminTripsPassengerId ? _self.adminTripsPassengerId : adminTripsPassengerId // ignore: cast_nullable_to_non_nullable
as String,adminTripsPassengerName: null == adminTripsPassengerName ? _self.adminTripsPassengerName : adminTripsPassengerName // ignore: cast_nullable_to_non_nullable
as String,tripDetailsState: null == tripDetailsState ? _self.tripDetailsState : tripDetailsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<DashboardTripDetailsEntity>,tripFinancialsState: null == tripFinancialsState ? _self.tripFinancialsState : tripFinancialsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<DashboardTripFinancialsEntity>,userWalletState: null == userWalletState ? _self.userWalletState : userWalletState // ignore: cast_nullable_to_non_nullable
as BlocStatus<DashboardUserWalletEntity>,adminConfigState: null == adminConfigState ? _self.adminConfigState : adminConfigState // ignore: cast_nullable_to_non_nullable
as BlocStatus<DashboardSystemConfigEntity>,adminVehicleTypesState: null == adminVehicleTypesState ? _self.adminVehicleTypesState : adminVehicleTypesState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<DashboardVehicleTypeEntity>>,configActionState: null == configActionState ? _self.configActionState : configActionState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,vehicleTypeActionState: null == vehicleTypeActionState ? _self.vehicleTypeActionState : vehicleTypeActionState // ignore: cast_nullable_to_non_nullable
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
$BlocStatusCopyWith<DashboardTripFinancialsEntity, $Res> get tripFinancialsState {
  
  return $BlocStatusCopyWith<DashboardTripFinancialsEntity, $Res>(_self.tripFinancialsState, (value) {
    return _then(_self.copyWith(tripFinancialsState: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<DashboardUserWalletEntity, $Res> get userWalletState {
  
  return $BlocStatusCopyWith<DashboardUserWalletEntity, $Res>(_self.userWalletState, (value) {
    return _then(_self.copyWith(userWalletState: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<DashboardSystemConfigEntity, $Res> get adminConfigState {
  
  return $BlocStatusCopyWith<DashboardSystemConfigEntity, $Res>(_self.adminConfigState, (value) {
    return _then(_self.copyWith(adminConfigState: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<DashboardVehicleTypeEntity>, $Res> get adminVehicleTypesState {
  
  return $BlocStatusCopyWith<List<DashboardVehicleTypeEntity>, $Res>(_self.adminVehicleTypesState, (value) {
    return _then(_self.copyWith(adminVehicleTypesState: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get configActionState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.configActionState, (value) {
    return _then(_self.copyWith(configActionState: value));
  });
}/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get vehicleTypeActionState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.vehicleTypeActionState, (value) {
    return _then(_self.copyWith(vehicleTypeActionState: value));
  });
}
}

// dart format on
