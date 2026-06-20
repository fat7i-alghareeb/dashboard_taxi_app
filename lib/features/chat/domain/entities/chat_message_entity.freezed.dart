// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_message_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatMessageEntity {

 String get id; String get tripId; String get senderId; String get senderRole; String? get content; String? get photoUrl; DateTime get sentAtUtc;
/// Create a copy of ChatMessageEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageEntityCopyWith<ChatMessageEntity> get copyWith => _$ChatMessageEntityCopyWithImpl<ChatMessageEntity>(this as ChatMessageEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessageEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderRole, senderRole) || other.senderRole == senderRole)&&(identical(other.content, content) || other.content == content)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.sentAtUtc, sentAtUtc) || other.sentAtUtc == sentAtUtc));
}


@override
int get hashCode => Object.hash(runtimeType,id,tripId,senderId,senderRole,content,photoUrl,sentAtUtc);

@override
String toString() {
  return 'ChatMessageEntity(id: $id, tripId: $tripId, senderId: $senderId, senderRole: $senderRole, content: $content, photoUrl: $photoUrl, sentAtUtc: $sentAtUtc)';
}


}

/// @nodoc
abstract mixin class $ChatMessageEntityCopyWith<$Res>  {
  factory $ChatMessageEntityCopyWith(ChatMessageEntity value, $Res Function(ChatMessageEntity) _then) = _$ChatMessageEntityCopyWithImpl;
@useResult
$Res call({
 String id, String tripId, String senderId, String senderRole, String? content, String? photoUrl, DateTime sentAtUtc
});




}
/// @nodoc
class _$ChatMessageEntityCopyWithImpl<$Res>
    implements $ChatMessageEntityCopyWith<$Res> {
  _$ChatMessageEntityCopyWithImpl(this._self, this._then);

  final ChatMessageEntity _self;
  final $Res Function(ChatMessageEntity) _then;

/// Create a copy of ChatMessageEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tripId = null,Object? senderId = null,Object? senderRole = null,Object? content = freezed,Object? photoUrl = freezed,Object? sentAtUtc = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,senderRole: null == senderRole ? _self.senderRole : senderRole // ignore: cast_nullable_to_non_nullable
as String,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,sentAtUtc: null == sentAtUtc ? _self.sentAtUtc : sentAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatMessageEntity].
extension ChatMessageEntityPatterns on ChatMessageEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMessageEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMessageEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMessageEntity value)  $default,){
final _that = this;
switch (_that) {
case _ChatMessageEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMessageEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMessageEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tripId,  String senderId,  String senderRole,  String? content,  String? photoUrl,  DateTime sentAtUtc)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMessageEntity() when $default != null:
return $default(_that.id,_that.tripId,_that.senderId,_that.senderRole,_that.content,_that.photoUrl,_that.sentAtUtc);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tripId,  String senderId,  String senderRole,  String? content,  String? photoUrl,  DateTime sentAtUtc)  $default,) {final _that = this;
switch (_that) {
case _ChatMessageEntity():
return $default(_that.id,_that.tripId,_that.senderId,_that.senderRole,_that.content,_that.photoUrl,_that.sentAtUtc);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tripId,  String senderId,  String senderRole,  String? content,  String? photoUrl,  DateTime sentAtUtc)?  $default,) {final _that = this;
switch (_that) {
case _ChatMessageEntity() when $default != null:
return $default(_that.id,_that.tripId,_that.senderId,_that.senderRole,_that.content,_that.photoUrl,_that.sentAtUtc);case _:
  return null;

}
}

}

/// @nodoc


class _ChatMessageEntity implements ChatMessageEntity {
  const _ChatMessageEntity({required this.id, required this.tripId, required this.senderId, required this.senderRole, this.content, this.photoUrl, required this.sentAtUtc});
  

@override final  String id;
@override final  String tripId;
@override final  String senderId;
@override final  String senderRole;
@override final  String? content;
@override final  String? photoUrl;
@override final  DateTime sentAtUtc;

/// Create a copy of ChatMessageEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessageEntityCopyWith<_ChatMessageEntity> get copyWith => __$ChatMessageEntityCopyWithImpl<_ChatMessageEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessageEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderRole, senderRole) || other.senderRole == senderRole)&&(identical(other.content, content) || other.content == content)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.sentAtUtc, sentAtUtc) || other.sentAtUtc == sentAtUtc));
}


@override
int get hashCode => Object.hash(runtimeType,id,tripId,senderId,senderRole,content,photoUrl,sentAtUtc);

@override
String toString() {
  return 'ChatMessageEntity(id: $id, tripId: $tripId, senderId: $senderId, senderRole: $senderRole, content: $content, photoUrl: $photoUrl, sentAtUtc: $sentAtUtc)';
}


}

/// @nodoc
abstract mixin class _$ChatMessageEntityCopyWith<$Res> implements $ChatMessageEntityCopyWith<$Res> {
  factory _$ChatMessageEntityCopyWith(_ChatMessageEntity value, $Res Function(_ChatMessageEntity) _then) = __$ChatMessageEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String tripId, String senderId, String senderRole, String? content, String? photoUrl, DateTime sentAtUtc
});




}
/// @nodoc
class __$ChatMessageEntityCopyWithImpl<$Res>
    implements _$ChatMessageEntityCopyWith<$Res> {
  __$ChatMessageEntityCopyWithImpl(this._self, this._then);

  final _ChatMessageEntity _self;
  final $Res Function(_ChatMessageEntity) _then;

/// Create a copy of ChatMessageEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tripId = null,Object? senderId = null,Object? senderRole = null,Object? content = freezed,Object? photoUrl = freezed,Object? sentAtUtc = null,}) {
  return _then(_ChatMessageEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,senderRole: null == senderRole ? _self.senderRole : senderRole // ignore: cast_nullable_to_non_nullable
as String,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,sentAtUtc: null == sentAtUtc ? _self.sentAtUtc : sentAtUtc // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
