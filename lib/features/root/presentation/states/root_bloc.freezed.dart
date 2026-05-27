// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'root_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RootEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RootEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RootEvent()';
}


}

/// @nodoc
class $RootEventCopyWith<$Res>  {
$RootEventCopyWith(RootEvent _, $Res Function(RootEvent) __);
}


/// Adds pattern-matching-related methods to [RootEvent].
extension RootEventPatterns on RootEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _MapBootstrapRequested value)?  mapBootstrapRequested,TResult Function( _RecenterRequested value)?  recenterRequested,TResult Function( _AccurateLocationResolved value)?  accurateLocationResolved,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _MapBootstrapRequested() when mapBootstrapRequested != null:
return mapBootstrapRequested(_that);case _RecenterRequested() when recenterRequested != null:
return recenterRequested(_that);case _AccurateLocationResolved() when accurateLocationResolved != null:
return accurateLocationResolved(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _MapBootstrapRequested value)  mapBootstrapRequested,required TResult Function( _RecenterRequested value)  recenterRequested,required TResult Function( _AccurateLocationResolved value)  accurateLocationResolved,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _MapBootstrapRequested():
return mapBootstrapRequested(_that);case _RecenterRequested():
return recenterRequested(_that);case _AccurateLocationResolved():
return accurateLocationResolved(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _MapBootstrapRequested value)?  mapBootstrapRequested,TResult? Function( _RecenterRequested value)?  recenterRequested,TResult? Function( _AccurateLocationResolved value)?  accurateLocationResolved,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _MapBootstrapRequested() when mapBootstrapRequested != null:
return mapBootstrapRequested(_that);case _RecenterRequested() when recenterRequested != null:
return recenterRequested(_that);case _AccurateLocationResolved() when accurateLocationResolved != null:
return accurateLocationResolved(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  mapBootstrapRequested,TResult Function()?  recenterRequested,TResult Function( RootMapLocationEntity location)?  accurateLocationResolved,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _MapBootstrapRequested() when mapBootstrapRequested != null:
return mapBootstrapRequested();case _RecenterRequested() when recenterRequested != null:
return recenterRequested();case _AccurateLocationResolved() when accurateLocationResolved != null:
return accurateLocationResolved(_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  mapBootstrapRequested,required TResult Function()  recenterRequested,required TResult Function( RootMapLocationEntity location)  accurateLocationResolved,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _MapBootstrapRequested():
return mapBootstrapRequested();case _RecenterRequested():
return recenterRequested();case _AccurateLocationResolved():
return accurateLocationResolved(_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  mapBootstrapRequested,TResult? Function()?  recenterRequested,TResult? Function( RootMapLocationEntity location)?  accurateLocationResolved,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _MapBootstrapRequested() when mapBootstrapRequested != null:
return mapBootstrapRequested();case _RecenterRequested() when recenterRequested != null:
return recenterRequested();case _AccurateLocationResolved() when accurateLocationResolved != null:
return accurateLocationResolved(_that.location);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements RootEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RootEvent.started()';
}


}




/// @nodoc


class _MapBootstrapRequested implements RootEvent {
  const _MapBootstrapRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapBootstrapRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RootEvent.mapBootstrapRequested()';
}


}




/// @nodoc


class _RecenterRequested implements RootEvent {
  const _RecenterRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecenterRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RootEvent.recenterRequested()';
}


}




/// @nodoc


class _AccurateLocationResolved implements RootEvent {
  const _AccurateLocationResolved(this.location);
  

 final  RootMapLocationEntity location;

/// Create a copy of RootEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccurateLocationResolvedCopyWith<_AccurateLocationResolved> get copyWith => __$AccurateLocationResolvedCopyWithImpl<_AccurateLocationResolved>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccurateLocationResolved&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,location);

@override
String toString() {
  return 'RootEvent.accurateLocationResolved(location: $location)';
}


}

/// @nodoc
abstract mixin class _$AccurateLocationResolvedCopyWith<$Res> implements $RootEventCopyWith<$Res> {
  factory _$AccurateLocationResolvedCopyWith(_AccurateLocationResolved value, $Res Function(_AccurateLocationResolved) _then) = __$AccurateLocationResolvedCopyWithImpl;
@useResult
$Res call({
 RootMapLocationEntity location
});




}
/// @nodoc
class __$AccurateLocationResolvedCopyWithImpl<$Res>
    implements _$AccurateLocationResolvedCopyWith<$Res> {
  __$AccurateLocationResolvedCopyWithImpl(this._self, this._then);

  final _AccurateLocationResolved _self;
  final $Res Function(_AccurateLocationResolved) _then;

/// Create a copy of RootEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? location = null,}) {
  return _then(_AccurateLocationResolved(
null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as RootMapLocationEntity,
  ));
}


}

/// @nodoc
mixin _$RootState {

 BlocStatus<RootMapLocationEntity> get mapBootstrapState; BlocStatus<RootMapLocationEntity> get recenterState;
/// Create a copy of RootState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RootStateCopyWith<RootState> get copyWith => _$RootStateCopyWithImpl<RootState>(this as RootState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RootState&&(identical(other.mapBootstrapState, mapBootstrapState) || other.mapBootstrapState == mapBootstrapState)&&(identical(other.recenterState, recenterState) || other.recenterState == recenterState));
}


@override
int get hashCode => Object.hash(runtimeType,mapBootstrapState,recenterState);

@override
String toString() {
  return 'RootState(mapBootstrapState: $mapBootstrapState, recenterState: $recenterState)';
}


}

/// @nodoc
abstract mixin class $RootStateCopyWith<$Res>  {
  factory $RootStateCopyWith(RootState value, $Res Function(RootState) _then) = _$RootStateCopyWithImpl;
@useResult
$Res call({
 BlocStatus<RootMapLocationEntity> mapBootstrapState, BlocStatus<RootMapLocationEntity> recenterState
});


$BlocStatusCopyWith<RootMapLocationEntity, $Res> get mapBootstrapState;$BlocStatusCopyWith<RootMapLocationEntity, $Res> get recenterState;

}
/// @nodoc
class _$RootStateCopyWithImpl<$Res>
    implements $RootStateCopyWith<$Res> {
  _$RootStateCopyWithImpl(this._self, this._then);

  final RootState _self;
  final $Res Function(RootState) _then;

/// Create a copy of RootState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mapBootstrapState = null,Object? recenterState = null,}) {
  return _then(_self.copyWith(
mapBootstrapState: null == mapBootstrapState ? _self.mapBootstrapState : mapBootstrapState // ignore: cast_nullable_to_non_nullable
as BlocStatus<RootMapLocationEntity>,recenterState: null == recenterState ? _self.recenterState : recenterState // ignore: cast_nullable_to_non_nullable
as BlocStatus<RootMapLocationEntity>,
  ));
}
/// Create a copy of RootState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<RootMapLocationEntity, $Res> get mapBootstrapState {
  
  return $BlocStatusCopyWith<RootMapLocationEntity, $Res>(_self.mapBootstrapState, (value) {
    return _then(_self.copyWith(mapBootstrapState: value));
  });
}/// Create a copy of RootState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<RootMapLocationEntity, $Res> get recenterState {
  
  return $BlocStatusCopyWith<RootMapLocationEntity, $Res>(_self.recenterState, (value) {
    return _then(_self.copyWith(recenterState: value));
  });
}
}


/// Adds pattern-matching-related methods to [RootState].
extension RootStatePatterns on RootState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RootState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RootState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RootState value)  $default,){
final _that = this;
switch (_that) {
case _RootState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RootState value)?  $default,){
final _that = this;
switch (_that) {
case _RootState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BlocStatus<RootMapLocationEntity> mapBootstrapState,  BlocStatus<RootMapLocationEntity> recenterState)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RootState() when $default != null:
return $default(_that.mapBootstrapState,_that.recenterState);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BlocStatus<RootMapLocationEntity> mapBootstrapState,  BlocStatus<RootMapLocationEntity> recenterState)  $default,) {final _that = this;
switch (_that) {
case _RootState():
return $default(_that.mapBootstrapState,_that.recenterState);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BlocStatus<RootMapLocationEntity> mapBootstrapState,  BlocStatus<RootMapLocationEntity> recenterState)?  $default,) {final _that = this;
switch (_that) {
case _RootState() when $default != null:
return $default(_that.mapBootstrapState,_that.recenterState);case _:
  return null;

}
}

}

/// @nodoc


class _RootState implements RootState {
  const _RootState({this.mapBootstrapState = const BlocStatus<RootMapLocationEntity>.initial(), this.recenterState = const BlocStatus<RootMapLocationEntity>.initial()});
  

@override@JsonKey() final  BlocStatus<RootMapLocationEntity> mapBootstrapState;
@override@JsonKey() final  BlocStatus<RootMapLocationEntity> recenterState;

/// Create a copy of RootState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RootStateCopyWith<_RootState> get copyWith => __$RootStateCopyWithImpl<_RootState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RootState&&(identical(other.mapBootstrapState, mapBootstrapState) || other.mapBootstrapState == mapBootstrapState)&&(identical(other.recenterState, recenterState) || other.recenterState == recenterState));
}


@override
int get hashCode => Object.hash(runtimeType,mapBootstrapState,recenterState);

@override
String toString() {
  return 'RootState(mapBootstrapState: $mapBootstrapState, recenterState: $recenterState)';
}


}

/// @nodoc
abstract mixin class _$RootStateCopyWith<$Res> implements $RootStateCopyWith<$Res> {
  factory _$RootStateCopyWith(_RootState value, $Res Function(_RootState) _then) = __$RootStateCopyWithImpl;
@override @useResult
$Res call({
 BlocStatus<RootMapLocationEntity> mapBootstrapState, BlocStatus<RootMapLocationEntity> recenterState
});


@override $BlocStatusCopyWith<RootMapLocationEntity, $Res> get mapBootstrapState;@override $BlocStatusCopyWith<RootMapLocationEntity, $Res> get recenterState;

}
/// @nodoc
class __$RootStateCopyWithImpl<$Res>
    implements _$RootStateCopyWith<$Res> {
  __$RootStateCopyWithImpl(this._self, this._then);

  final _RootState _self;
  final $Res Function(_RootState) _then;

/// Create a copy of RootState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mapBootstrapState = null,Object? recenterState = null,}) {
  return _then(_RootState(
mapBootstrapState: null == mapBootstrapState ? _self.mapBootstrapState : mapBootstrapState // ignore: cast_nullable_to_non_nullable
as BlocStatus<RootMapLocationEntity>,recenterState: null == recenterState ? _self.recenterState : recenterState // ignore: cast_nullable_to_non_nullable
as BlocStatus<RootMapLocationEntity>,
  ));
}

/// Create a copy of RootState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<RootMapLocationEntity, $Res> get mapBootstrapState {
  
  return $BlocStatusCopyWith<RootMapLocationEntity, $Res>(_self.mapBootstrapState, (value) {
    return _then(_self.copyWith(mapBootstrapState: value));
  });
}/// Create a copy of RootState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<RootMapLocationEntity, $Res> get recenterState {
  
  return $BlocStatusCopyWith<RootMapLocationEntity, $Res>(_self.recenterState, (value) {
    return _then(_self.copyWith(recenterState: value));
  });
}
}

// dart format on
