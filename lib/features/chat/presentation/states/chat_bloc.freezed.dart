// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatEvent()';
}


}

/// @nodoc
class $ChatEventCopyWith<$Res>  {
$ChatEventCopyWith(ChatEvent _, $Res Function(ChatEvent) __);
}


/// Adds pattern-matching-related methods to [ChatEvent].
extension ChatEventPatterns on ChatEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Opened value)?  opened,TResult Function( _ViewOpened value)?  viewOpened,TResult Function( _ViewClosed value)?  viewClosed,TResult Function( _SendText value)?  sendText,TResult Function( _SendPhoto value)?  sendPhoto,TResult Function( _MessageReceived value)?  messageReceived,TResult Function( _ChatClosedReceived value)?  chatClosedReceived,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Opened() when opened != null:
return opened(_that);case _ViewOpened() when viewOpened != null:
return viewOpened(_that);case _ViewClosed() when viewClosed != null:
return viewClosed(_that);case _SendText() when sendText != null:
return sendText(_that);case _SendPhoto() when sendPhoto != null:
return sendPhoto(_that);case _MessageReceived() when messageReceived != null:
return messageReceived(_that);case _ChatClosedReceived() when chatClosedReceived != null:
return chatClosedReceived(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Opened value)  opened,required TResult Function( _ViewOpened value)  viewOpened,required TResult Function( _ViewClosed value)  viewClosed,required TResult Function( _SendText value)  sendText,required TResult Function( _SendPhoto value)  sendPhoto,required TResult Function( _MessageReceived value)  messageReceived,required TResult Function( _ChatClosedReceived value)  chatClosedReceived,}){
final _that = this;
switch (_that) {
case _Opened():
return opened(_that);case _ViewOpened():
return viewOpened(_that);case _ViewClosed():
return viewClosed(_that);case _SendText():
return sendText(_that);case _SendPhoto():
return sendPhoto(_that);case _MessageReceived():
return messageReceived(_that);case _ChatClosedReceived():
return chatClosedReceived(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Opened value)?  opened,TResult? Function( _ViewOpened value)?  viewOpened,TResult? Function( _ViewClosed value)?  viewClosed,TResult? Function( _SendText value)?  sendText,TResult? Function( _SendPhoto value)?  sendPhoto,TResult? Function( _MessageReceived value)?  messageReceived,TResult? Function( _ChatClosedReceived value)?  chatClosedReceived,}){
final _that = this;
switch (_that) {
case _Opened() when opened != null:
return opened(_that);case _ViewOpened() when viewOpened != null:
return viewOpened(_that);case _ViewClosed() when viewClosed != null:
return viewClosed(_that);case _SendText() when sendText != null:
return sendText(_that);case _SendPhoto() when sendPhoto != null:
return sendPhoto(_that);case _MessageReceived() when messageReceived != null:
return messageReceived(_that);case _ChatClosedReceived() when chatClosedReceived != null:
return chatClosedReceived(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String tripId)?  opened,TResult Function()?  viewOpened,TResult Function()?  viewClosed,TResult Function( String text)?  sendText,TResult Function( String path)?  sendPhoto,TResult Function( ChatMessageEntity message)?  messageReceived,TResult Function()?  chatClosedReceived,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Opened() when opened != null:
return opened(_that.tripId);case _ViewOpened() when viewOpened != null:
return viewOpened();case _ViewClosed() when viewClosed != null:
return viewClosed();case _SendText() when sendText != null:
return sendText(_that.text);case _SendPhoto() when sendPhoto != null:
return sendPhoto(_that.path);case _MessageReceived() when messageReceived != null:
return messageReceived(_that.message);case _ChatClosedReceived() when chatClosedReceived != null:
return chatClosedReceived();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String tripId)  opened,required TResult Function()  viewOpened,required TResult Function()  viewClosed,required TResult Function( String text)  sendText,required TResult Function( String path)  sendPhoto,required TResult Function( ChatMessageEntity message)  messageReceived,required TResult Function()  chatClosedReceived,}) {final _that = this;
switch (_that) {
case _Opened():
return opened(_that.tripId);case _ViewOpened():
return viewOpened();case _ViewClosed():
return viewClosed();case _SendText():
return sendText(_that.text);case _SendPhoto():
return sendPhoto(_that.path);case _MessageReceived():
return messageReceived(_that.message);case _ChatClosedReceived():
return chatClosedReceived();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String tripId)?  opened,TResult? Function()?  viewOpened,TResult? Function()?  viewClosed,TResult? Function( String text)?  sendText,TResult? Function( String path)?  sendPhoto,TResult? Function( ChatMessageEntity message)?  messageReceived,TResult? Function()?  chatClosedReceived,}) {final _that = this;
switch (_that) {
case _Opened() when opened != null:
return opened(_that.tripId);case _ViewOpened() when viewOpened != null:
return viewOpened();case _ViewClosed() when viewClosed != null:
return viewClosed();case _SendText() when sendText != null:
return sendText(_that.text);case _SendPhoto() when sendPhoto != null:
return sendPhoto(_that.path);case _MessageReceived() when messageReceived != null:
return messageReceived(_that.message);case _ChatClosedReceived() when chatClosedReceived != null:
return chatClosedReceived();case _:
  return null;

}
}

}

/// @nodoc


class _Opened implements ChatEvent {
  const _Opened(this.tripId);
  

 final  String tripId;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpenedCopyWith<_Opened> get copyWith => __$OpenedCopyWithImpl<_Opened>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Opened&&(identical(other.tripId, tripId) || other.tripId == tripId));
}


@override
int get hashCode => Object.hash(runtimeType,tripId);

@override
String toString() {
  return 'ChatEvent.opened(tripId: $tripId)';
}


}

/// @nodoc
abstract mixin class _$OpenedCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory _$OpenedCopyWith(_Opened value, $Res Function(_Opened) _then) = __$OpenedCopyWithImpl;
@useResult
$Res call({
 String tripId
});




}
/// @nodoc
class __$OpenedCopyWithImpl<$Res>
    implements _$OpenedCopyWith<$Res> {
  __$OpenedCopyWithImpl(this._self, this._then);

  final _Opened _self;
  final $Res Function(_Opened) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tripId = null,}) {
  return _then(_Opened(
null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ViewOpened implements ChatEvent {
  const _ViewOpened();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ViewOpened);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatEvent.viewOpened()';
}


}




/// @nodoc


class _ViewClosed implements ChatEvent {
  const _ViewClosed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ViewClosed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatEvent.viewClosed()';
}


}




/// @nodoc


class _SendText implements ChatEvent {
  const _SendText(this.text);
  

 final  String text;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendTextCopyWith<_SendText> get copyWith => __$SendTextCopyWithImpl<_SendText>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendText&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'ChatEvent.sendText(text: $text)';
}


}

/// @nodoc
abstract mixin class _$SendTextCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory _$SendTextCopyWith(_SendText value, $Res Function(_SendText) _then) = __$SendTextCopyWithImpl;
@useResult
$Res call({
 String text
});




}
/// @nodoc
class __$SendTextCopyWithImpl<$Res>
    implements _$SendTextCopyWith<$Res> {
  __$SendTextCopyWithImpl(this._self, this._then);

  final _SendText _self;
  final $Res Function(_SendText) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(_SendText(
null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SendPhoto implements ChatEvent {
  const _SendPhoto(this.path);
  

 final  String path;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendPhotoCopyWith<_SendPhoto> get copyWith => __$SendPhotoCopyWithImpl<_SendPhoto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendPhoto&&(identical(other.path, path) || other.path == path));
}


@override
int get hashCode => Object.hash(runtimeType,path);

@override
String toString() {
  return 'ChatEvent.sendPhoto(path: $path)';
}


}

/// @nodoc
abstract mixin class _$SendPhotoCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory _$SendPhotoCopyWith(_SendPhoto value, $Res Function(_SendPhoto) _then) = __$SendPhotoCopyWithImpl;
@useResult
$Res call({
 String path
});




}
/// @nodoc
class __$SendPhotoCopyWithImpl<$Res>
    implements _$SendPhotoCopyWith<$Res> {
  __$SendPhotoCopyWithImpl(this._self, this._then);

  final _SendPhoto _self;
  final $Res Function(_SendPhoto) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? path = null,}) {
  return _then(_SendPhoto(
null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _MessageReceived implements ChatEvent {
  const _MessageReceived(this.message);
  

 final  ChatMessageEntity message;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageReceivedCopyWith<_MessageReceived> get copyWith => __$MessageReceivedCopyWithImpl<_MessageReceived>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageReceived&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ChatEvent.messageReceived(message: $message)';
}


}

/// @nodoc
abstract mixin class _$MessageReceivedCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory _$MessageReceivedCopyWith(_MessageReceived value, $Res Function(_MessageReceived) _then) = __$MessageReceivedCopyWithImpl;
@useResult
$Res call({
 ChatMessageEntity message
});


$ChatMessageEntityCopyWith<$Res> get message;

}
/// @nodoc
class __$MessageReceivedCopyWithImpl<$Res>
    implements _$MessageReceivedCopyWith<$Res> {
  __$MessageReceivedCopyWithImpl(this._self, this._then);

  final _MessageReceived _self;
  final $Res Function(_MessageReceived) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_MessageReceived(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as ChatMessageEntity,
  ));
}

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatMessageEntityCopyWith<$Res> get message {
  
  return $ChatMessageEntityCopyWith<$Res>(_self.message, (value) {
    return _then(_self.copyWith(message: value));
  });
}
}

/// @nodoc


class _ChatClosedReceived implements ChatEvent {
  const _ChatClosedReceived();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatClosedReceived);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatEvent.chatClosedReceived()';
}


}




/// @nodoc
mixin _$ChatState {

 List<ChatMessageEntity> get messages; BlocStatus<void> get loadStatus; BlocStatus<void> get sendStatus;/// True once the trip ended — the message input is locked.
 bool get isClosed;/// Whether the chat sheet is currently on screen (drives unread counting).
 bool get isViewing;/// Messages received from other participants while the sheet was closed.
 int get unreadCount;
/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatStateCopyWith<ChatState> get copyWith => _$ChatStateCopyWithImpl<ChatState>(this as ChatState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatState&&const DeepCollectionEquality().equals(other.messages, messages)&&(identical(other.loadStatus, loadStatus) || other.loadStatus == loadStatus)&&(identical(other.sendStatus, sendStatus) || other.sendStatus == sendStatus)&&(identical(other.isClosed, isClosed) || other.isClosed == isClosed)&&(identical(other.isViewing, isViewing) || other.isViewing == isViewing)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(messages),loadStatus,sendStatus,isClosed,isViewing,unreadCount);

@override
String toString() {
  return 'ChatState(messages: $messages, loadStatus: $loadStatus, sendStatus: $sendStatus, isClosed: $isClosed, isViewing: $isViewing, unreadCount: $unreadCount)';
}


}

/// @nodoc
abstract mixin class $ChatStateCopyWith<$Res>  {
  factory $ChatStateCopyWith(ChatState value, $Res Function(ChatState) _then) = _$ChatStateCopyWithImpl;
@useResult
$Res call({
 List<ChatMessageEntity> messages, BlocStatus<void> loadStatus, BlocStatus<void> sendStatus, bool isClosed, bool isViewing, int unreadCount
});


$BlocStatusCopyWith<void, $Res> get loadStatus;$BlocStatusCopyWith<void, $Res> get sendStatus;

}
/// @nodoc
class _$ChatStateCopyWithImpl<$Res>
    implements $ChatStateCopyWith<$Res> {
  _$ChatStateCopyWithImpl(this._self, this._then);

  final ChatState _self;
  final $Res Function(ChatState) _then;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messages = null,Object? loadStatus = null,Object? sendStatus = null,Object? isClosed = null,Object? isViewing = null,Object? unreadCount = null,}) {
  return _then(_self.copyWith(
messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessageEntity>,loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,sendStatus: null == sendStatus ? _self.sendStatus : sendStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,isClosed: null == isClosed ? _self.isClosed : isClosed // ignore: cast_nullable_to_non_nullable
as bool,isViewing: null == isViewing ? _self.isViewing : isViewing // ignore: cast_nullable_to_non_nullable
as bool,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get loadStatus {
  
  return $BlocStatusCopyWith<void, $Res>(_self.loadStatus, (value) {
    return _then(_self.copyWith(loadStatus: value));
  });
}/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get sendStatus {
  
  return $BlocStatusCopyWith<void, $Res>(_self.sendStatus, (value) {
    return _then(_self.copyWith(sendStatus: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChatState].
extension ChatStatePatterns on ChatState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatState value)  $default,){
final _that = this;
switch (_that) {
case _ChatState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatState value)?  $default,){
final _that = this;
switch (_that) {
case _ChatState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ChatMessageEntity> messages,  BlocStatus<void> loadStatus,  BlocStatus<void> sendStatus,  bool isClosed,  bool isViewing,  int unreadCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatState() when $default != null:
return $default(_that.messages,_that.loadStatus,_that.sendStatus,_that.isClosed,_that.isViewing,_that.unreadCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ChatMessageEntity> messages,  BlocStatus<void> loadStatus,  BlocStatus<void> sendStatus,  bool isClosed,  bool isViewing,  int unreadCount)  $default,) {final _that = this;
switch (_that) {
case _ChatState():
return $default(_that.messages,_that.loadStatus,_that.sendStatus,_that.isClosed,_that.isViewing,_that.unreadCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ChatMessageEntity> messages,  BlocStatus<void> loadStatus,  BlocStatus<void> sendStatus,  bool isClosed,  bool isViewing,  int unreadCount)?  $default,) {final _that = this;
switch (_that) {
case _ChatState() when $default != null:
return $default(_that.messages,_that.loadStatus,_that.sendStatus,_that.isClosed,_that.isViewing,_that.unreadCount);case _:
  return null;

}
}

}

/// @nodoc


class _ChatState implements ChatState {
  const _ChatState({final  List<ChatMessageEntity> messages = const [], this.loadStatus = const BlocStatus<void>.initial(), this.sendStatus = const BlocStatus<void>.initial(), this.isClosed = false, this.isViewing = false, this.unreadCount = 0}): _messages = messages;
  

 final  List<ChatMessageEntity> _messages;
@override@JsonKey() List<ChatMessageEntity> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override@JsonKey() final  BlocStatus<void> loadStatus;
@override@JsonKey() final  BlocStatus<void> sendStatus;
/// True once the trip ended — the message input is locked.
@override@JsonKey() final  bool isClosed;
/// Whether the chat sheet is currently on screen (drives unread counting).
@override@JsonKey() final  bool isViewing;
/// Messages received from other participants while the sheet was closed.
@override@JsonKey() final  int unreadCount;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatStateCopyWith<_ChatState> get copyWith => __$ChatStateCopyWithImpl<_ChatState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatState&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.loadStatus, loadStatus) || other.loadStatus == loadStatus)&&(identical(other.sendStatus, sendStatus) || other.sendStatus == sendStatus)&&(identical(other.isClosed, isClosed) || other.isClosed == isClosed)&&(identical(other.isViewing, isViewing) || other.isViewing == isViewing)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_messages),loadStatus,sendStatus,isClosed,isViewing,unreadCount);

@override
String toString() {
  return 'ChatState(messages: $messages, loadStatus: $loadStatus, sendStatus: $sendStatus, isClosed: $isClosed, isViewing: $isViewing, unreadCount: $unreadCount)';
}


}

/// @nodoc
abstract mixin class _$ChatStateCopyWith<$Res> implements $ChatStateCopyWith<$Res> {
  factory _$ChatStateCopyWith(_ChatState value, $Res Function(_ChatState) _then) = __$ChatStateCopyWithImpl;
@override @useResult
$Res call({
 List<ChatMessageEntity> messages, BlocStatus<void> loadStatus, BlocStatus<void> sendStatus, bool isClosed, bool isViewing, int unreadCount
});


@override $BlocStatusCopyWith<void, $Res> get loadStatus;@override $BlocStatusCopyWith<void, $Res> get sendStatus;

}
/// @nodoc
class __$ChatStateCopyWithImpl<$Res>
    implements _$ChatStateCopyWith<$Res> {
  __$ChatStateCopyWithImpl(this._self, this._then);

  final _ChatState _self;
  final $Res Function(_ChatState) _then;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messages = null,Object? loadStatus = null,Object? sendStatus = null,Object? isClosed = null,Object? isViewing = null,Object? unreadCount = null,}) {
  return _then(_ChatState(
messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessageEntity>,loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,sendStatus: null == sendStatus ? _self.sendStatus : sendStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus<void>,isClosed: null == isClosed ? _self.isClosed : isClosed // ignore: cast_nullable_to_non_nullable
as bool,isViewing: null == isViewing ? _self.isViewing : isViewing // ignore: cast_nullable_to_non_nullable
as bool,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get loadStatus {
  
  return $BlocStatusCopyWith<void, $Res>(_self.loadStatus, (value) {
    return _then(_self.copyWith(loadStatus: value));
  });
}/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlocStatusCopyWith<void, $Res> get sendStatus {
  
  return $BlocStatusCopyWith<void, $Res>(_self.sendStatus, (value) {
    return _then(_self.copyWith(sendStatus: value));
  });
}
}

// dart format on
