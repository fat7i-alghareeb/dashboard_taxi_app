// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kyc_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$KycEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KycEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'KycEvent()';
}


}

/// @nodoc
class $KycEventCopyWith<$Res>  {
$KycEventCopyWith(KycEvent _, $Res Function(KycEvent) __);
}


/// Adds pattern-matching-related methods to [KycEvent].
extension KycEventPatterns on KycEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _UploadDocumentRequested value)?  uploadDocumentRequested,TResult Function( _RefreshStatusRequested value)?  refreshStatusRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _UploadDocumentRequested() when uploadDocumentRequested != null:
return uploadDocumentRequested(_that);case _RefreshStatusRequested() when refreshStatusRequested != null:
return refreshStatusRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _UploadDocumentRequested value)  uploadDocumentRequested,required TResult Function( _RefreshStatusRequested value)  refreshStatusRequested,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _UploadDocumentRequested():
return uploadDocumentRequested(_that);case _RefreshStatusRequested():
return refreshStatusRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _UploadDocumentRequested value)?  uploadDocumentRequested,TResult? Function( _RefreshStatusRequested value)?  refreshStatusRequested,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _UploadDocumentRequested() when uploadDocumentRequested != null:
return uploadDocumentRequested(_that);case _RefreshStatusRequested() when refreshStatusRequested != null:
return refreshStatusRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String driverId)?  started,TResult Function( String type,  String filePath)?  uploadDocumentRequested,TResult Function()?  refreshStatusRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.driverId);case _UploadDocumentRequested() when uploadDocumentRequested != null:
return uploadDocumentRequested(_that.type,_that.filePath);case _RefreshStatusRequested() when refreshStatusRequested != null:
return refreshStatusRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String driverId)  started,required TResult Function( String type,  String filePath)  uploadDocumentRequested,required TResult Function()  refreshStatusRequested,}) {final _that = this;
switch (_that) {
case _Started():
return started(_that.driverId);case _UploadDocumentRequested():
return uploadDocumentRequested(_that.type,_that.filePath);case _RefreshStatusRequested():
return refreshStatusRequested();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String driverId)?  started,TResult? Function( String type,  String filePath)?  uploadDocumentRequested,TResult? Function()?  refreshStatusRequested,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.driverId);case _UploadDocumentRequested() when uploadDocumentRequested != null:
return uploadDocumentRequested(_that.type,_that.filePath);case _RefreshStatusRequested() when refreshStatusRequested != null:
return refreshStatusRequested();case _:
  return null;

}
}

}

/// @nodoc


class _Started implements KycEvent {
  const _Started(this.driverId);
  

 final  String driverId;

/// Create a copy of KycEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StartedCopyWith<_Started> get copyWith => __$StartedCopyWithImpl<_Started>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started&&(identical(other.driverId, driverId) || other.driverId == driverId));
}


@override
int get hashCode => Object.hash(runtimeType,driverId);

@override
String toString() {
  return 'KycEvent.started(driverId: $driverId)';
}


}

/// @nodoc
abstract mixin class _$StartedCopyWith<$Res> implements $KycEventCopyWith<$Res> {
  factory _$StartedCopyWith(_Started value, $Res Function(_Started) _then) = __$StartedCopyWithImpl;
@useResult
$Res call({
 String driverId
});




}
/// @nodoc
class __$StartedCopyWithImpl<$Res>
    implements _$StartedCopyWith<$Res> {
  __$StartedCopyWithImpl(this._self, this._then);

  final _Started _self;
  final $Res Function(_Started) _then;

/// Create a copy of KycEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? driverId = null,}) {
  return _then(_Started(
null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _UploadDocumentRequested implements KycEvent {
  const _UploadDocumentRequested({required this.type, required this.filePath});
  

 final  String type;
 final  String filePath;

/// Create a copy of KycEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UploadDocumentRequestedCopyWith<_UploadDocumentRequested> get copyWith => __$UploadDocumentRequestedCopyWithImpl<_UploadDocumentRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UploadDocumentRequested&&(identical(other.type, type) || other.type == type)&&(identical(other.filePath, filePath) || other.filePath == filePath));
}


@override
int get hashCode => Object.hash(runtimeType,type,filePath);

@override
String toString() {
  return 'KycEvent.uploadDocumentRequested(type: $type, filePath: $filePath)';
}


}

/// @nodoc
abstract mixin class _$UploadDocumentRequestedCopyWith<$Res> implements $KycEventCopyWith<$Res> {
  factory _$UploadDocumentRequestedCopyWith(_UploadDocumentRequested value, $Res Function(_UploadDocumentRequested) _then) = __$UploadDocumentRequestedCopyWithImpl;
@useResult
$Res call({
 String type, String filePath
});




}
/// @nodoc
class __$UploadDocumentRequestedCopyWithImpl<$Res>
    implements _$UploadDocumentRequestedCopyWith<$Res> {
  __$UploadDocumentRequestedCopyWithImpl(this._self, this._then);

  final _UploadDocumentRequested _self;
  final $Res Function(_UploadDocumentRequested) _then;

/// Create a copy of KycEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? type = null,Object? filePath = null,}) {
  return _then(_UploadDocumentRequested(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,filePath: null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RefreshStatusRequested implements KycEvent {
  const _RefreshStatusRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshStatusRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'KycEvent.refreshStatusRequested()';
}


}




/// @nodoc
mixin _$KycState {

 String get driverId; String get uploadingType; BlocStatus<List<KycDocumentEntity>> get fetchState; BlocStatus<String> get uploadState; BlocStatus<void> get refreshState; FormGroup get form;
/// Create a copy of KycState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KycStateCopyWith<KycState> get copyWith => _$KycStateCopyWithImpl<KycState>(this as KycState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KycState&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.uploadingType, uploadingType) || other.uploadingType == uploadingType)&&(identical(other.fetchState, fetchState) || other.fetchState == fetchState)&&(identical(other.uploadState, uploadState) || other.uploadState == uploadState)&&(identical(other.refreshState, refreshState) || other.refreshState == refreshState)&&(identical(other.form, form) || other.form == form));
}


@override
int get hashCode => Object.hash(runtimeType,driverId,uploadingType,fetchState,uploadState,refreshState,form);

@override
String toString() {
  return 'KycState(driverId: $driverId, uploadingType: $uploadingType, fetchState: $fetchState, uploadState: $uploadState, refreshState: $refreshState, form: $form)';
}


}

/// @nodoc
abstract mixin class $KycStateCopyWith<$Res>  {
  factory $KycStateCopyWith(KycState value, $Res Function(KycState) _then) = _$KycStateCopyWithImpl;
@useResult
$Res call({
 String driverId, String uploadingType, BlocStatus<List<KycDocumentEntity>> fetchState, BlocStatus<String> uploadState, BlocStatus<void> refreshState, FormGroup form
});


$BlocStatusCopyWith<List<KycDocumentEntity>, $Res> get fetchState;$BlocStatusCopyWith<String, $Res> get uploadState;$BlocStatusCopyWith<void, $Res> get refreshState;

}
/// @nodoc
class _$KycStateCopyWithImpl<$Res>
    implements $KycStateCopyWith<$Res> {
  _$KycStateCopyWithImpl(this._self, this._then);

  final KycState _self;
  final $Res Function(KycState) _then;

/// Create a copy of KycState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? driverId = null,Object? uploadingType = null,Object? fetchState = null,Object? uploadState = null,Object? refreshState = null,Object? form = null,}) {
  return _then(_self.copyWith(
driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,uploadingType: null == uploadingType ? _self.uploadingType : uploadingType // ignore: cast_nullable_to_non_nullable
as String,fetchState: null == fetchState ? _self.fetchState : fetchState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<KycDocumentEntity>>,uploadState: null == uploadState ? _self.uploadState : uploadState // ignore: cast_nullable_to_non_nullable
as BlocStatus<String>,refreshState: null == refreshState ? _self.refreshState : refreshState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,form: null == form ? _self.form : form // ignore: cast_nullable_to_non_nullable
as FormGroup,
  ));
}
/// Create a copy of KycState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<KycDocumentEntity>, $Res> get fetchState {
  
  return $BlocStatusCopyWith<List<KycDocumentEntity>, $Res>(_self.fetchState, (value) {
    return _then(_self.copyWith(fetchState: value));
  });
}/// Create a copy of KycState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<String, $Res> get uploadState {
  
  return $BlocStatusCopyWith<String, $Res>(_self.uploadState, (value) {
    return _then(_self.copyWith(uploadState: value));
  });
}/// Create a copy of KycState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get refreshState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.refreshState, (value) {
    return _then(_self.copyWith(refreshState: value));
  });
}
}


/// Adds pattern-matching-related methods to [KycState].
extension KycStatePatterns on KycState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KycState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KycState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KycState value)  $default,){
final _that = this;
switch (_that) {
case _KycState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KycState value)?  $default,){
final _that = this;
switch (_that) {
case _KycState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String driverId,  String uploadingType,  BlocStatus<List<KycDocumentEntity>> fetchState,  BlocStatus<String> uploadState,  BlocStatus<void> refreshState,  FormGroup form)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KycState() when $default != null:
return $default(_that.driverId,_that.uploadingType,_that.fetchState,_that.uploadState,_that.refreshState,_that.form);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String driverId,  String uploadingType,  BlocStatus<List<KycDocumentEntity>> fetchState,  BlocStatus<String> uploadState,  BlocStatus<void> refreshState,  FormGroup form)  $default,) {final _that = this;
switch (_that) {
case _KycState():
return $default(_that.driverId,_that.uploadingType,_that.fetchState,_that.uploadState,_that.refreshState,_that.form);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String driverId,  String uploadingType,  BlocStatus<List<KycDocumentEntity>> fetchState,  BlocStatus<String> uploadState,  BlocStatus<void> refreshState,  FormGroup form)?  $default,) {final _that = this;
switch (_that) {
case _KycState() when $default != null:
return $default(_that.driverId,_that.uploadingType,_that.fetchState,_that.uploadState,_that.refreshState,_that.form);case _:
  return null;

}
}

}

/// @nodoc


class _KycState implements KycState {
  const _KycState({this.driverId = '', this.uploadingType = '', this.fetchState = const BlocStatus<List<KycDocumentEntity>>.initial(), this.uploadState = const BlocStatus<String>.initial(), this.refreshState = const BlocStatus<void>.initial(), required this.form});
  

@override@JsonKey() final  String driverId;
@override@JsonKey() final  String uploadingType;
@override@JsonKey() final  BlocStatus<List<KycDocumentEntity>> fetchState;
@override@JsonKey() final  BlocStatus<String> uploadState;
@override@JsonKey() final  BlocStatus<void> refreshState;
@override final  FormGroup form;

/// Create a copy of KycState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KycStateCopyWith<_KycState> get copyWith => __$KycStateCopyWithImpl<_KycState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KycState&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.uploadingType, uploadingType) || other.uploadingType == uploadingType)&&(identical(other.fetchState, fetchState) || other.fetchState == fetchState)&&(identical(other.uploadState, uploadState) || other.uploadState == uploadState)&&(identical(other.refreshState, refreshState) || other.refreshState == refreshState)&&(identical(other.form, form) || other.form == form));
}


@override
int get hashCode => Object.hash(runtimeType,driverId,uploadingType,fetchState,uploadState,refreshState,form);

@override
String toString() {
  return 'KycState(driverId: $driverId, uploadingType: $uploadingType, fetchState: $fetchState, uploadState: $uploadState, refreshState: $refreshState, form: $form)';
}


}

/// @nodoc
abstract mixin class _$KycStateCopyWith<$Res> implements $KycStateCopyWith<$Res> {
  factory _$KycStateCopyWith(_KycState value, $Res Function(_KycState) _then) = __$KycStateCopyWithImpl;
@override @useResult
$Res call({
 String driverId, String uploadingType, BlocStatus<List<KycDocumentEntity>> fetchState, BlocStatus<String> uploadState, BlocStatus<void> refreshState, FormGroup form
});


@override $BlocStatusCopyWith<List<KycDocumentEntity>, $Res> get fetchState;@override $BlocStatusCopyWith<String, $Res> get uploadState;@override $BlocStatusCopyWith<void, $Res> get refreshState;

}
/// @nodoc
class __$KycStateCopyWithImpl<$Res>
    implements _$KycStateCopyWith<$Res> {
  __$KycStateCopyWithImpl(this._self, this._then);

  final _KycState _self;
  final $Res Function(_KycState) _then;

/// Create a copy of KycState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? driverId = null,Object? uploadingType = null,Object? fetchState = null,Object? uploadState = null,Object? refreshState = null,Object? form = null,}) {
  return _then(_KycState(
driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,uploadingType: null == uploadingType ? _self.uploadingType : uploadingType // ignore: cast_nullable_to_non_nullable
as String,fetchState: null == fetchState ? _self.fetchState : fetchState // ignore: cast_nullable_to_non_nullable
as BlocStatus<List<KycDocumentEntity>>,uploadState: null == uploadState ? _self.uploadState : uploadState // ignore: cast_nullable_to_non_nullable
as BlocStatus<String>,refreshState: null == refreshState ? _self.refreshState : refreshState // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,form: null == form ? _self.form : form // ignore: cast_nullable_to_non_nullable
as FormGroup,
  ));
}

/// Create a copy of KycState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<List<KycDocumentEntity>, $Res> get fetchState {
  
  return $BlocStatusCopyWith<List<KycDocumentEntity>, $Res>(_self.fetchState, (value) {
    return _then(_self.copyWith(fetchState: value));
  });
}/// Create a copy of KycState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<String, $Res> get uploadState {
  
  return $BlocStatusCopyWith<String, $Res>(_self.uploadState, (value) {
    return _then(_self.copyWith(uploadState: value));
  });
}/// Create a copy of KycState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get refreshState {
  
  return $BlocStatusCopyWith<void, $Res>(_self.refreshState, (value) {
    return _then(_self.copyWith(refreshState: value));
  });
}
}

// dart format on
