// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driver_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DriverEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriverEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DriverEvent()';
}


}

/// @nodoc
class $DriverEventCopyWith<$Res>  {
$DriverEventCopyWith(DriverEvent _, $Res Function(DriverEvent) __);
}


/// Adds pattern-matching-related methods to [DriverEvent].
extension DriverEventPatterns on DriverEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _GetAllRequested value)?  getAllRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _GetAllRequested() when getAllRequested != null:
return getAllRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _GetAllRequested value)  getAllRequested,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _GetAllRequested():
return getAllRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _GetAllRequested value)?  getAllRequested,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _GetAllRequested() when getAllRequested != null:
return getAllRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  getAllRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _GetAllRequested() when getAllRequested != null:
return getAllRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  getAllRequested,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _GetAllRequested():
return getAllRequested();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  getAllRequested,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _GetAllRequested() when getAllRequested != null:
return getAllRequested();case _:
  return null;

}
}

}

/// @nodoc


class _Started implements DriverEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DriverEvent.started()';
}


}




/// @nodoc


class _GetAllRequested implements DriverEvent {
  const _GetAllRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetAllRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DriverEvent.getAllRequested()';
}


}




/// @nodoc
mixin _$DriverState {

 BlocStatus<List<DriverEntity>> get getAllState;
/// Create a copy of DriverState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriverStateCopyWith<DriverState> get copyWith => _$DriverStateCopyWithImpl<DriverState>(this as DriverState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriverState&&(identical(other.getAllState, getAllState) || other.getAllState == getAllState));
}


@override
int get hashCode => Object.hash(runtimeType,getAllState);

@override
String toString() {
  return 'DriverState(getAllState: $getAllState)';
}


}

/// @nodoc
abstract mixin class $DriverStateCopyWith<$Res>  {
  factory $DriverStateCopyWith(DriverState value, $Res Function(DriverState) _then) = _$DriverStateCopyWithImpl;
@useResult
$Res call({
 BlocStatus<List<DriverEntity>> getAllState
});


$BlocStatusCopyWith<List<DriverEntity>, $Res> get getAllState;

}
/// @nodoc
class _$DriverStateCopyWithImpl<$Res>
    implements $DriverStateCopyWith<$Res> {
  _$DriverStateCopyWithImpl(this._self, this._then);

  final DriverState _self;
  final $Res Function(DriverState) _then;

/// Create a copy of DriverState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? getAllState = null,}) {
  return _then(_self.copyWith(
getAllState: null == getAllState ? _self.getAllState : getAllState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<DriverEntity>>,
  ));
}
/// Create a copy of DriverState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<DriverEntity>, $Res> get getAllState {
  
  return $BlocStatusCopyWith<List<DriverEntity>, $Res>(_self.getAllState, (value) {
    return _then(_self.copyWith(getAllState: value));
  });
}
}


/// Adds pattern-matching-related methods to [DriverState].
extension DriverStatePatterns on DriverState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DriverState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DriverState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DriverState value)  $default,){
final _that = this;
switch (_that) {
case _DriverState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DriverState value)?  $default,){
final _that = this;
switch (_that) {
case _DriverState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BlocStatus<List<DriverEntity>> getAllState)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DriverState() when $default != null:
return $default(_that.getAllState);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BlocStatus<List<DriverEntity>> getAllState)  $default,) {final _that = this;
switch (_that) {
case _DriverState():
return $default(_that.getAllState);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BlocStatus<List<DriverEntity>> getAllState)?  $default,) {final _that = this;
switch (_that) {
case _DriverState() when $default != null:
return $default(_that.getAllState);case _:
  return null;

}
}

}

/// @nodoc


class _DriverState implements DriverState {
  const _DriverState({this.getAllState = const BlocStatus<List<DriverEntity>>.initial()});
  

@override@JsonKey() final  BlocStatus<List<DriverEntity>> getAllState;

/// Create a copy of DriverState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriverStateCopyWith<_DriverState> get copyWith => __$DriverStateCopyWithImpl<_DriverState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriverState&&(identical(other.getAllState, getAllState) || other.getAllState == getAllState));
}


@override
int get hashCode => Object.hash(runtimeType,getAllState);

@override
String toString() {
  return 'DriverState(getAllState: $getAllState)';
}


}

/// @nodoc
abstract mixin class _$DriverStateCopyWith<$Res> implements $DriverStateCopyWith<$Res> {
  factory _$DriverStateCopyWith(_DriverState value, $Res Function(_DriverState) _then) = __$DriverStateCopyWithImpl;
@override @useResult
$Res call({
 BlocStatus<List<DriverEntity>> getAllState
});


@override $BlocStatusCopyWith<List<DriverEntity>, $Res> get getAllState;

}
/// @nodoc
class __$DriverStateCopyWithImpl<$Res>
    implements _$DriverStateCopyWith<$Res> {
  __$DriverStateCopyWithImpl(this._self, this._then);

  final _DriverState _self;
  final $Res Function(_DriverState) _then;

/// Create a copy of DriverState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? getAllState = null,}) {
  return _then(_DriverState(
getAllState: null == getAllState ? _self.getAllState : getAllState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<DriverEntity>>,
  ));
}

/// Create a copy of DriverState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<DriverEntity>, $Res> get getAllState {
  
  return $BlocStatusCopyWith<List<DriverEntity>, $Res>(_self.getAllState, (value) {
    return _then(_self.copyWith(getAllState: value));
  });
}
}

// dart format on
