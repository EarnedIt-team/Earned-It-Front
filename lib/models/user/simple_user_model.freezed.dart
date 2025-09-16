// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'simple_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SimpleUserModel {

 int get userId; String get nickname; String? get profileImage;
/// Create a copy of SimpleUserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SimpleUserModelCopyWith<SimpleUserModel> get copyWith => _$SimpleUserModelCopyWithImpl<SimpleUserModel>(this as SimpleUserModel, _$identity);

  /// Serializes this SimpleUserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SimpleUserModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,nickname,profileImage);

@override
String toString() {
  return 'SimpleUserModel(userId: $userId, nickname: $nickname, profileImage: $profileImage)';
}


}

/// @nodoc
abstract mixin class $SimpleUserModelCopyWith<$Res>  {
  factory $SimpleUserModelCopyWith(SimpleUserModel value, $Res Function(SimpleUserModel) _then) = _$SimpleUserModelCopyWithImpl;
@useResult
$Res call({
 int userId, String nickname, String? profileImage
});




}
/// @nodoc
class _$SimpleUserModelCopyWithImpl<$Res>
    implements $SimpleUserModelCopyWith<$Res> {
  _$SimpleUserModelCopyWithImpl(this._self, this._then);

  final SimpleUserModel _self;
  final $Res Function(SimpleUserModel) _then;

/// Create a copy of SimpleUserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? nickname = null,Object? profileImage = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SimpleUserModel].
extension SimpleUserModelPatterns on SimpleUserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SimpleUserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SimpleUserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SimpleUserModel value)  $default,){
final _that = this;
switch (_that) {
case _SimpleUserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SimpleUserModel value)?  $default,){
final _that = this;
switch (_that) {
case _SimpleUserModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int userId,  String nickname,  String? profileImage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SimpleUserModel() when $default != null:
return $default(_that.userId,_that.nickname,_that.profileImage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int userId,  String nickname,  String? profileImage)  $default,) {final _that = this;
switch (_that) {
case _SimpleUserModel():
return $default(_that.userId,_that.nickname,_that.profileImage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int userId,  String nickname,  String? profileImage)?  $default,) {final _that = this;
switch (_that) {
case _SimpleUserModel() when $default != null:
return $default(_that.userId,_that.nickname,_that.profileImage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SimpleUserModel implements SimpleUserModel {
  const _SimpleUserModel({required this.userId, required this.nickname, this.profileImage});
  factory _SimpleUserModel.fromJson(Map<String, dynamic> json) => _$SimpleUserModelFromJson(json);

@override final  int userId;
@override final  String nickname;
@override final  String? profileImage;

/// Create a copy of SimpleUserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SimpleUserModelCopyWith<_SimpleUserModel> get copyWith => __$SimpleUserModelCopyWithImpl<_SimpleUserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SimpleUserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SimpleUserModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,nickname,profileImage);

@override
String toString() {
  return 'SimpleUserModel(userId: $userId, nickname: $nickname, profileImage: $profileImage)';
}


}

/// @nodoc
abstract mixin class _$SimpleUserModelCopyWith<$Res> implements $SimpleUserModelCopyWith<$Res> {
  factory _$SimpleUserModelCopyWith(_SimpleUserModel value, $Res Function(_SimpleUserModel) _then) = __$SimpleUserModelCopyWithImpl;
@override @useResult
$Res call({
 int userId, String nickname, String? profileImage
});




}
/// @nodoc
class __$SimpleUserModelCopyWithImpl<$Res>
    implements _$SimpleUserModelCopyWith<$Res> {
  __$SimpleUserModelCopyWithImpl(this._self, this._then);

  final _SimpleUserModel _self;
  final $Res Function(_SimpleUserModel) _then;

/// Create a copy of SimpleUserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? nickname = null,Object? profileImage = freezed,}) {
  return _then(_SimpleUserModel(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
