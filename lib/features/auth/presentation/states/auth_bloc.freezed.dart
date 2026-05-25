// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent()';
}


}

/// @nodoc
class $AuthEventCopyWith<$Res>  {
$AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}


/// Adds pattern-matching-related methods to [AuthEvent].
extension AuthEventPatterns on AuthEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _SendOtpRequested value)?  sendOtpRequested,TResult Function( _VerifyOtpRequested value)?  verifyOtpRequested,TResult Function( _ForceResetPasswordRequested value)?  forceResetPasswordRequested,TResult Function( _ResetRequested value)?  resetRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _SendOtpRequested() when sendOtpRequested != null:
return sendOtpRequested(_that);case _VerifyOtpRequested() when verifyOtpRequested != null:
return verifyOtpRequested(_that);case _ForceResetPasswordRequested() when forceResetPasswordRequested != null:
return forceResetPasswordRequested(_that);case _ResetRequested() when resetRequested != null:
return resetRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _SendOtpRequested value)  sendOtpRequested,required TResult Function( _VerifyOtpRequested value)  verifyOtpRequested,required TResult Function( _ForceResetPasswordRequested value)  forceResetPasswordRequested,required TResult Function( _ResetRequested value)  resetRequested,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _SendOtpRequested():
return sendOtpRequested(_that);case _VerifyOtpRequested():
return verifyOtpRequested(_that);case _ForceResetPasswordRequested():
return forceResetPasswordRequested(_that);case _ResetRequested():
return resetRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _SendOtpRequested value)?  sendOtpRequested,TResult? Function( _VerifyOtpRequested value)?  verifyOtpRequested,TResult? Function( _ForceResetPasswordRequested value)?  forceResetPasswordRequested,TResult? Function( _ResetRequested value)?  resetRequested,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _SendOtpRequested() when sendOtpRequested != null:
return sendOtpRequested(_that);case _VerifyOtpRequested() when verifyOtpRequested != null:
return verifyOtpRequested(_that);case _ForceResetPasswordRequested() when forceResetPasswordRequested != null:
return forceResetPasswordRequested(_that);case _ResetRequested() when resetRequested != null:
return resetRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String phone)?  sendOtpRequested,TResult Function( String otp)?  verifyOtpRequested,TResult Function( String newPassword)?  forceResetPasswordRequested,TResult Function()?  resetRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _SendOtpRequested() when sendOtpRequested != null:
return sendOtpRequested(_that.phone);case _VerifyOtpRequested() when verifyOtpRequested != null:
return verifyOtpRequested(_that.otp);case _ForceResetPasswordRequested() when forceResetPasswordRequested != null:
return forceResetPasswordRequested(_that.newPassword);case _ResetRequested() when resetRequested != null:
return resetRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String phone)  sendOtpRequested,required TResult Function( String otp)  verifyOtpRequested,required TResult Function( String newPassword)  forceResetPasswordRequested,required TResult Function()  resetRequested,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _SendOtpRequested():
return sendOtpRequested(_that.phone);case _VerifyOtpRequested():
return verifyOtpRequested(_that.otp);case _ForceResetPasswordRequested():
return forceResetPasswordRequested(_that.newPassword);case _ResetRequested():
return resetRequested();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String phone)?  sendOtpRequested,TResult? Function( String otp)?  verifyOtpRequested,TResult? Function( String newPassword)?  forceResetPasswordRequested,TResult? Function()?  resetRequested,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _SendOtpRequested() when sendOtpRequested != null:
return sendOtpRequested(_that.phone);case _VerifyOtpRequested() when verifyOtpRequested != null:
return verifyOtpRequested(_that.otp);case _ForceResetPasswordRequested() when forceResetPasswordRequested != null:
return forceResetPasswordRequested(_that.newPassword);case _ResetRequested() when resetRequested != null:
return resetRequested();case _:
  return null;

}
}

}

/// @nodoc


class _Started implements AuthEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.started()';
}


}




/// @nodoc


class _SendOtpRequested implements AuthEvent {
  const _SendOtpRequested(this.phone);
  

 final  String phone;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendOtpRequestedCopyWith<_SendOtpRequested> get copyWith => __$SendOtpRequestedCopyWithImpl<_SendOtpRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendOtpRequested&&(identical(other.phone, phone) || other.phone == phone));
}


@override
int get hashCode => Object.hash(runtimeType,phone);

@override
String toString() {
  return 'AuthEvent.sendOtpRequested(phone: $phone)';
}


}

/// @nodoc
abstract mixin class _$SendOtpRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$SendOtpRequestedCopyWith(_SendOtpRequested value, $Res Function(_SendOtpRequested) _then) = __$SendOtpRequestedCopyWithImpl;
@useResult
$Res call({
 String phone
});




}
/// @nodoc
class __$SendOtpRequestedCopyWithImpl<$Res>
    implements _$SendOtpRequestedCopyWith<$Res> {
  __$SendOtpRequestedCopyWithImpl(this._self, this._then);

  final _SendOtpRequested _self;
  final $Res Function(_SendOtpRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? phone = null,}) {
  return _then(_SendOtpRequested(
null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _VerifyOtpRequested implements AuthEvent {
  const _VerifyOtpRequested(this.otp);
  

 final  String otp;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyOtpRequestedCopyWith<_VerifyOtpRequested> get copyWith => __$VerifyOtpRequestedCopyWithImpl<_VerifyOtpRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyOtpRequested&&(identical(other.otp, otp) || other.otp == otp));
}


@override
int get hashCode => Object.hash(runtimeType,otp);

@override
String toString() {
  return 'AuthEvent.verifyOtpRequested(otp: $otp)';
}


}

/// @nodoc
abstract mixin class _$VerifyOtpRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$VerifyOtpRequestedCopyWith(_VerifyOtpRequested value, $Res Function(_VerifyOtpRequested) _then) = __$VerifyOtpRequestedCopyWithImpl;
@useResult
$Res call({
 String otp
});




}
/// @nodoc
class __$VerifyOtpRequestedCopyWithImpl<$Res>
    implements _$VerifyOtpRequestedCopyWith<$Res> {
  __$VerifyOtpRequestedCopyWithImpl(this._self, this._then);

  final _VerifyOtpRequested _self;
  final $Res Function(_VerifyOtpRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? otp = null,}) {
  return _then(_VerifyOtpRequested(
null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ForceResetPasswordRequested implements AuthEvent {
  const _ForceResetPasswordRequested(this.newPassword);
  

 final  String newPassword;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForceResetPasswordRequestedCopyWith<_ForceResetPasswordRequested> get copyWith => __$ForceResetPasswordRequestedCopyWithImpl<_ForceResetPasswordRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForceResetPasswordRequested&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword));
}


@override
int get hashCode => Object.hash(runtimeType,newPassword);

@override
String toString() {
  return 'AuthEvent.forceResetPasswordRequested(newPassword: $newPassword)';
}


}

/// @nodoc
abstract mixin class _$ForceResetPasswordRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$ForceResetPasswordRequestedCopyWith(_ForceResetPasswordRequested value, $Res Function(_ForceResetPasswordRequested) _then) = __$ForceResetPasswordRequestedCopyWithImpl;
@useResult
$Res call({
 String newPassword
});




}
/// @nodoc
class __$ForceResetPasswordRequestedCopyWithImpl<$Res>
    implements _$ForceResetPasswordRequestedCopyWith<$Res> {
  __$ForceResetPasswordRequestedCopyWithImpl(this._self, this._then);

  final _ForceResetPasswordRequested _self;
  final $Res Function(_ForceResetPasswordRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? newPassword = null,}) {
  return _then(_ForceResetPasswordRequested(
null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ResetRequested implements AuthEvent {
  const _ResetRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.resetRequested()';
}


}




/// @nodoc
mixin _$AuthState {

 BlocStatus<void> get phoneStatus; BlocStatus<UserEntity> get otpStatus; BlocStatus<void> get forceResetStatus; bool get isOtpSent; String? get verificationId;
/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthStateCopyWith<AuthState> get copyWith => _$AuthStateCopyWithImpl<AuthState>(this as AuthState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState&&(identical(other.phoneStatus, phoneStatus) || other.phoneStatus == phoneStatus)&&(identical(other.otpStatus, otpStatus) || other.otpStatus == otpStatus)&&(identical(other.forceResetStatus, forceResetStatus) || other.forceResetStatus == forceResetStatus)&&(identical(other.isOtpSent, isOtpSent) || other.isOtpSent == isOtpSent)&&(identical(other.verificationId, verificationId) || other.verificationId == verificationId));
}


@override
int get hashCode => Object.hash(runtimeType,phoneStatus,otpStatus,forceResetStatus,isOtpSent,verificationId);

@override
String toString() {
  return 'AuthState(phoneStatus: $phoneStatus, otpStatus: $otpStatus, forceResetStatus: $forceResetStatus, isOtpSent: $isOtpSent, verificationId: $verificationId)';
}


}

/// @nodoc
abstract mixin class $AuthStateCopyWith<$Res>  {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) _then) = _$AuthStateCopyWithImpl;
@useResult
$Res call({
 BlocStatus<void> phoneStatus, BlocStatus<UserEntity> otpStatus, BlocStatus<void> forceResetStatus, bool isOtpSent, String? verificationId
});


$BlocStatusCopyWith<void, $Res> get phoneStatus;$BlocStatusCopyWith<UserEntity, $Res> get otpStatus;$BlocStatusCopyWith<void, $Res> get forceResetStatus;

}
/// @nodoc
class _$AuthStateCopyWithImpl<$Res>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._self, this._then);

  final AuthState _self;
  final $Res Function(AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phoneStatus = null,Object? otpStatus = null,Object? forceResetStatus = null,Object? isOtpSent = null,Object? verificationId = freezed,}) {
  return _then(_self.copyWith(
phoneStatus: null == phoneStatus ? _self.phoneStatus : phoneStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,otpStatus: null == otpStatus ? _self.otpStatus : otpStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<UserEntity>,forceResetStatus: null == forceResetStatus ? _self.forceResetStatus : forceResetStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,isOtpSent: null == isOtpSent ? _self.isOtpSent : isOtpSent // ignore: cast_nullable_to_non_nullable
as bool,verificationId: freezed == verificationId ? _self.verificationId : verificationId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get phoneStatus {
  
  return $BlocStatusCopyWith<void, $Res>(_self.phoneStatus, (value) {
    return _then(_self.copyWith(phoneStatus: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<UserEntity, $Res> get otpStatus {
  
  return $BlocStatusCopyWith<UserEntity, $Res>(_self.otpStatus, (value) {
    return _then(_self.copyWith(otpStatus: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get forceResetStatus {
  
  return $BlocStatusCopyWith<void, $Res>(_self.forceResetStatus, (value) {
    return _then(_self.copyWith(forceResetStatus: value));
  });
}
}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthState value)  $default,){
final _that = this;
switch (_that) {
case _AuthState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthState value)?  $default,){
final _that = this;
switch (_that) {
case _AuthState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BlocStatus<void> phoneStatus,  BlocStatus<UserEntity> otpStatus,  BlocStatus<void> forceResetStatus,  bool isOtpSent,  String? verificationId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that.phoneStatus,_that.otpStatus,_that.forceResetStatus,_that.isOtpSent,_that.verificationId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BlocStatus<void> phoneStatus,  BlocStatus<UserEntity> otpStatus,  BlocStatus<void> forceResetStatus,  bool isOtpSent,  String? verificationId)  $default,) {final _that = this;
switch (_that) {
case _AuthState():
return $default(_that.phoneStatus,_that.otpStatus,_that.forceResetStatus,_that.isOtpSent,_that.verificationId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BlocStatus<void> phoneStatus,  BlocStatus<UserEntity> otpStatus,  BlocStatus<void> forceResetStatus,  bool isOtpSent,  String? verificationId)?  $default,) {final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that.phoneStatus,_that.otpStatus,_that.forceResetStatus,_that.isOtpSent,_that.verificationId);case _:
  return null;

}
}

}

/// @nodoc


class _AuthState implements AuthState {
  const _AuthState({this.phoneStatus = const BlocStatus<void>.initial(), this.otpStatus = const BlocStatus<UserEntity>.initial(), this.forceResetStatus = const BlocStatus<void>.initial(), this.isOtpSent = false, this.verificationId});
  

@override@JsonKey() final  BlocStatus<void> phoneStatus;
@override@JsonKey() final  BlocStatus<UserEntity> otpStatus;
@override@JsonKey() final  BlocStatus<void> forceResetStatus;
@override@JsonKey() final  bool isOtpSent;
@override final  String? verificationId;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthStateCopyWith<_AuthState> get copyWith => __$AuthStateCopyWithImpl<_AuthState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthState&&(identical(other.phoneStatus, phoneStatus) || other.phoneStatus == phoneStatus)&&(identical(other.otpStatus, otpStatus) || other.otpStatus == otpStatus)&&(identical(other.forceResetStatus, forceResetStatus) || other.forceResetStatus == forceResetStatus)&&(identical(other.isOtpSent, isOtpSent) || other.isOtpSent == isOtpSent)&&(identical(other.verificationId, verificationId) || other.verificationId == verificationId));
}


@override
int get hashCode => Object.hash(runtimeType,phoneStatus,otpStatus,forceResetStatus,isOtpSent,verificationId);

@override
String toString() {
  return 'AuthState(phoneStatus: $phoneStatus, otpStatus: $otpStatus, forceResetStatus: $forceResetStatus, isOtpSent: $isOtpSent, verificationId: $verificationId)';
}


}

/// @nodoc
abstract mixin class _$AuthStateCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthStateCopyWith(_AuthState value, $Res Function(_AuthState) _then) = __$AuthStateCopyWithImpl;
@override @useResult
$Res call({
 BlocStatus<void> phoneStatus, BlocStatus<UserEntity> otpStatus, BlocStatus<void> forceResetStatus, bool isOtpSent, String? verificationId
});


@override $BlocStatusCopyWith<void, $Res> get phoneStatus;@override $BlocStatusCopyWith<UserEntity, $Res> get otpStatus;@override $BlocStatusCopyWith<void, $Res> get forceResetStatus;

}
/// @nodoc
class __$AuthStateCopyWithImpl<$Res>
    implements _$AuthStateCopyWith<$Res> {
  __$AuthStateCopyWithImpl(this._self, this._then);

  final _AuthState _self;
  final $Res Function(_AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phoneStatus = null,Object? otpStatus = null,Object? forceResetStatus = null,Object? isOtpSent = null,Object? verificationId = freezed,}) {
  return _then(_AuthState(
phoneStatus: null == phoneStatus ? _self.phoneStatus : phoneStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,otpStatus: null == otpStatus ? _self.otpStatus : otpStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<UserEntity>,forceResetStatus: null == forceResetStatus ? _self.forceResetStatus : forceResetStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,isOtpSent: null == isOtpSent ? _self.isOtpSent : isOtpSent // ignore: cast_nullable_to_non_nullable
as bool,verificationId: freezed == verificationId ? _self.verificationId : verificationId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get phoneStatus {
  
  return $BlocStatusCopyWith<void, $Res>(_self.phoneStatus, (value) {
    return _then(_self.copyWith(phoneStatus: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<UserEntity, $Res> get otpStatus {
  
  return $BlocStatusCopyWith<UserEntity, $Res>(_self.otpStatus, (value) {
    return _then(_self.copyWith(otpStatus: value));
  });
}/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get forceResetStatus {
  
  return $BlocStatusCopyWith<void, $Res>(_self.forceResetStatus, (value) {
    return _then(_self.copyWith(forceResetStatus: value));
  });
}
}

// dart format on
