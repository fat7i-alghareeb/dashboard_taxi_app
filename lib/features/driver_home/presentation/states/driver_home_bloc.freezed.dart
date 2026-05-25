// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driver_home_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DriverHomeEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriverHomeEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DriverHomeEvent()';
}


}

/// @nodoc
class $DriverHomeEventCopyWith<$Res>  {
$DriverHomeEventCopyWith(DriverHomeEvent _, $Res Function(DriverHomeEvent) __);
}


/// Adds pattern-matching-related methods to [DriverHomeEvent].
extension DriverHomeEventPatterns on DriverHomeEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _ToggleStatusRequested value)?  toggleStatusRequested,TResult Function( _EarningsRequested value)?  earningsRequested,TResult Function( _ConnectionStateChanged value)?  connectionStateChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _ToggleStatusRequested() when toggleStatusRequested != null:
return toggleStatusRequested(_that);case _EarningsRequested() when earningsRequested != null:
return earningsRequested(_that);case _ConnectionStateChanged() when connectionStateChanged != null:
return connectionStateChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _ToggleStatusRequested value)  toggleStatusRequested,required TResult Function( _EarningsRequested value)  earningsRequested,required TResult Function( _ConnectionStateChanged value)  connectionStateChanged,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _ToggleStatusRequested():
return toggleStatusRequested(_that);case _EarningsRequested():
return earningsRequested(_that);case _ConnectionStateChanged():
return connectionStateChanged(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _ToggleStatusRequested value)?  toggleStatusRequested,TResult? Function( _EarningsRequested value)?  earningsRequested,TResult? Function( _ConnectionStateChanged value)?  connectionStateChanged,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _ToggleStatusRequested() when toggleStatusRequested != null:
return toggleStatusRequested(_that);case _EarningsRequested() when earningsRequested != null:
return earningsRequested(_that);case _ConnectionStateChanged() when connectionStateChanged != null:
return connectionStateChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( bool isOnline)?  toggleStatusRequested,TResult Function()?  earningsRequested,TResult Function( RealtimeConnectionState connectionState)?  connectionStateChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _ToggleStatusRequested() when toggleStatusRequested != null:
return toggleStatusRequested(_that.isOnline);case _EarningsRequested() when earningsRequested != null:
return earningsRequested();case _ConnectionStateChanged() when connectionStateChanged != null:
return connectionStateChanged(_that.connectionState);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( bool isOnline)  toggleStatusRequested,required TResult Function()  earningsRequested,required TResult Function( RealtimeConnectionState connectionState)  connectionStateChanged,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _ToggleStatusRequested():
return toggleStatusRequested(_that.isOnline);case _EarningsRequested():
return earningsRequested();case _ConnectionStateChanged():
return connectionStateChanged(_that.connectionState);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( bool isOnline)?  toggleStatusRequested,TResult? Function()?  earningsRequested,TResult? Function( RealtimeConnectionState connectionState)?  connectionStateChanged,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _ToggleStatusRequested() when toggleStatusRequested != null:
return toggleStatusRequested(_that.isOnline);case _EarningsRequested() when earningsRequested != null:
return earningsRequested();case _ConnectionStateChanged() when connectionStateChanged != null:
return connectionStateChanged(_that.connectionState);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements DriverHomeEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DriverHomeEvent.started()';
}


}




/// @nodoc


class _ToggleStatusRequested implements DriverHomeEvent {
  const _ToggleStatusRequested(this.isOnline);
  

 final  bool isOnline;

/// Create a copy of DriverHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleStatusRequestedCopyWith<_ToggleStatusRequested> get copyWith => __$ToggleStatusRequestedCopyWithImpl<_ToggleStatusRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleStatusRequested&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline));
}


@override
int get hashCode => Object.hash(runtimeType,isOnline);

@override
String toString() {
  return 'DriverHomeEvent.toggleStatusRequested(isOnline: $isOnline)';
}


}

/// @nodoc
abstract mixin class _$ToggleStatusRequestedCopyWith<$Res> implements $DriverHomeEventCopyWith<$Res> {
  factory _$ToggleStatusRequestedCopyWith(_ToggleStatusRequested value, $Res Function(_ToggleStatusRequested) _then) = __$ToggleStatusRequestedCopyWithImpl;
@useResult
$Res call({
 bool isOnline
});




}
/// @nodoc
class __$ToggleStatusRequestedCopyWithImpl<$Res>
    implements _$ToggleStatusRequestedCopyWith<$Res> {
  __$ToggleStatusRequestedCopyWithImpl(this._self, this._then);

  final _ToggleStatusRequested _self;
  final $Res Function(_ToggleStatusRequested) _then;

/// Create a copy of DriverHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isOnline = null,}) {
  return _then(_ToggleStatusRequested(
null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _EarningsRequested implements DriverHomeEvent {
  const _EarningsRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarningsRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DriverHomeEvent.earningsRequested()';
}


}




/// @nodoc


class _ConnectionStateChanged implements DriverHomeEvent {
  const _ConnectionStateChanged(this.connectionState);
  

 final  RealtimeConnectionState connectionState;

/// Create a copy of DriverHomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectionStateChangedCopyWith<_ConnectionStateChanged> get copyWith => __$ConnectionStateChangedCopyWithImpl<_ConnectionStateChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectionStateChanged&&(identical(other.connectionState, connectionState) || other.connectionState == connectionState));
}


@override
int get hashCode => Object.hash(runtimeType,connectionState);

@override
String toString() {
  return 'DriverHomeEvent.connectionStateChanged(connectionState: $connectionState)';
}


}

/// @nodoc
abstract mixin class _$ConnectionStateChangedCopyWith<$Res> implements $DriverHomeEventCopyWith<$Res> {
  factory _$ConnectionStateChangedCopyWith(_ConnectionStateChanged value, $Res Function(_ConnectionStateChanged) _then) = __$ConnectionStateChangedCopyWithImpl;
@useResult
$Res call({
 RealtimeConnectionState connectionState
});




}
/// @nodoc
class __$ConnectionStateChangedCopyWithImpl<$Res>
    implements _$ConnectionStateChangedCopyWith<$Res> {
  __$ConnectionStateChangedCopyWithImpl(this._self, this._then);

  final _ConnectionStateChanged _self;
  final $Res Function(_ConnectionStateChanged) _then;

/// Create a copy of DriverHomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? connectionState = null,}) {
  return _then(_ConnectionStateChanged(
null == connectionState ? _self.connectionState : connectionState // ignore: cast_nullable_to_non_nullable
as RealtimeConnectionState,
  ));
}


}

/// @nodoc
mixin _$DriverHomeState {

 bool get isOnline; BlocStatus<void> get statusState; BlocStatus<DriverEarningsEntity> get earningsState; RealtimeConnectionState get connectionState;
/// Create a copy of DriverHomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriverHomeStateCopyWith<DriverHomeState> get copyWith => _$DriverHomeStateCopyWithImpl<DriverHomeState>(this as DriverHomeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriverHomeState&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.statusState, statusState) || other.statusState == statusState)&&(identical(other.earningsState, earningsState) || other.earningsState == earningsState)&&(identical(other.connectionState, connectionState) || other.connectionState == connectionState));
}


@override
int get hashCode => Object.hash(runtimeType,isOnline,statusState,earningsState,connectionState);

@override
String toString() {
  return 'DriverHomeState(isOnline: $isOnline, statusState: $statusState, earningsState: $earningsState, connectionState: $connectionState)';
}


}

/// @nodoc
abstract mixin class $DriverHomeStateCopyWith<$Res>  {
  factory $DriverHomeStateCopyWith(DriverHomeState value, $Res Function(DriverHomeState) _then) = _$DriverHomeStateCopyWithImpl;
@useResult
$Res call({
 bool isOnline, BlocStatus<void> statusState, BlocStatus<DriverEarningsEntity> earningsState, RealtimeConnectionState connectionState
});


$BlocStatusCopyWith<void, $Res> get statusState;$BlocStatusCopyWith<DriverEarningsEntity, $Res> get earningsState;

}
/// @nodoc
class _$DriverHomeStateCopyWithImpl<$Res>
    implements $DriverHomeStateCopyWith<$Res> {
  _$DriverHomeStateCopyWithImpl(this._self, this._then);

  final DriverHomeState _self;
  final $Res Function(DriverHomeState) _then;

/// Create a copy of DriverHomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isOnline = null,Object? statusState = null,Object? earningsState = null,Object? connectionState = null,}) {
  return _then(_self.copyWith(
isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,statusState: null == statusState ? _self.statusState : statusState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,earningsState: null == earningsState ? _self.earningsState : earningsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<DriverEarningsEntity>,connectionState: null == connectionState ? _self.connectionState : connectionState // ignore: cast_nullable_to_non_nullable
as RealtimeConnectionState,
  ));
}
/// Create a copy of DriverHomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get statusState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.statusState, (value) {
    return _then(_self.copyWith(statusState: value));
  });
}/// Create a copy of DriverHomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<DriverEarningsEntity, $Res> get earningsState {
  
  return $BlocStatusCopyWith<DriverEarningsEntity, $Res>(_self.earningsState, (value) {
    return _then(_self.copyWith(earningsState: value));
  });
}
}


/// Adds pattern-matching-related methods to [DriverHomeState].
extension DriverHomeStatePatterns on DriverHomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DriverHomeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DriverHomeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DriverHomeState value)  $default,){
final _that = this;
switch (_that) {
case _DriverHomeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DriverHomeState value)?  $default,){
final _that = this;
switch (_that) {
case _DriverHomeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isOnline,  BlocStatus<void> statusState,  BlocStatus<DriverEarningsEntity> earningsState,  RealtimeConnectionState connectionState)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DriverHomeState() when $default != null:
return $default(_that.isOnline,_that.statusState,_that.earningsState,_that.connectionState);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isOnline,  BlocStatus<void> statusState,  BlocStatus<DriverEarningsEntity> earningsState,  RealtimeConnectionState connectionState)  $default,) {final _that = this;
switch (_that) {
case _DriverHomeState():
return $default(_that.isOnline,_that.statusState,_that.earningsState,_that.connectionState);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isOnline,  BlocStatus<void> statusState,  BlocStatus<DriverEarningsEntity> earningsState,  RealtimeConnectionState connectionState)?  $default,) {final _that = this;
switch (_that) {
case _DriverHomeState() when $default != null:
return $default(_that.isOnline,_that.statusState,_that.earningsState,_that.connectionState);case _:
  return null;

}
}

}

/// @nodoc


class _DriverHomeState implements DriverHomeState {
  const _DriverHomeState({this.isOnline = false, this.statusState = const BlocStatus<void>.initial(), this.earningsState = const BlocStatus<DriverEarningsEntity>.initial(), this.connectionState = RealtimeConnectionState.disconnected});
  

@override@JsonKey() final  bool isOnline;
@override@JsonKey() final  BlocStatus<void> statusState;
@override@JsonKey() final  BlocStatus<DriverEarningsEntity> earningsState;
@override@JsonKey() final  RealtimeConnectionState connectionState;

/// Create a copy of DriverHomeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriverHomeStateCopyWith<_DriverHomeState> get copyWith => __$DriverHomeStateCopyWithImpl<_DriverHomeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriverHomeState&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.statusState, statusState) || other.statusState == statusState)&&(identical(other.earningsState, earningsState) || other.earningsState == earningsState)&&(identical(other.connectionState, connectionState) || other.connectionState == connectionState));
}


@override
int get hashCode => Object.hash(runtimeType,isOnline,statusState,earningsState,connectionState);

@override
String toString() {
  return 'DriverHomeState(isOnline: $isOnline, statusState: $statusState, earningsState: $earningsState, connectionState: $connectionState)';
}


}

/// @nodoc
abstract mixin class _$DriverHomeStateCopyWith<$Res> implements $DriverHomeStateCopyWith<$Res> {
  factory _$DriverHomeStateCopyWith(_DriverHomeState value, $Res Function(_DriverHomeState) _then) = __$DriverHomeStateCopyWithImpl;
@override @useResult
$Res call({
 bool isOnline, BlocStatus<void> statusState, BlocStatus<DriverEarningsEntity> earningsState, RealtimeConnectionState connectionState
});


@override $BlocStatusCopyWith<void, $Res> get statusState;@override $BlocStatusCopyWith<DriverEarningsEntity, $Res> get earningsState;

}
/// @nodoc
class __$DriverHomeStateCopyWithImpl<$Res>
    implements _$DriverHomeStateCopyWith<$Res> {
  __$DriverHomeStateCopyWithImpl(this._self, this._then);

  final _DriverHomeState _self;
  final $Res Function(_DriverHomeState) _then;

/// Create a copy of DriverHomeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isOnline = null,Object? statusState = null,Object? earningsState = null,Object? connectionState = null,}) {
  return _then(_DriverHomeState(
isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,statusState: null == statusState ? _self.statusState : statusState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,earningsState: null == earningsState ? _self.earningsState : earningsState // ignore: cast_nullable_to_non_nullable
as BlocStatus<DriverEarningsEntity>,connectionState: null == connectionState ? _self.connectionState : connectionState // ignore: cast_nullable_to_non_nullable
as RealtimeConnectionState,
  ));
}

/// Create a copy of DriverHomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get statusState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.statusState, (value) {
    return _then(_self.copyWith(statusState: value));
  });
}/// Create a copy of DriverHomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<DriverEarningsEntity, $Res> get earningsState {
  
  return $BlocStatusCopyWith<DriverEarningsEntity, $Res>(_self.earningsState, (value) {
    return _then(_self.copyWith(earningsState: value));
  });
}
}

// dart format on
