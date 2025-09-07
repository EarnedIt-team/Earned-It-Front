// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfileUserModel {

// ✨ @Default(0) 추가
 int get userId; String? get profileImage; String get nickname;// ✨ @Default(0) 추가
 int get monthlySalary;
/// Create a copy of ProfileUserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileUserModelCopyWith<ProfileUserModel> get copyWith => _$ProfileUserModelCopyWithImpl<ProfileUserModel>(this as ProfileUserModel, _$identity);

  /// Serializes this ProfileUserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileUserModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.monthlySalary, monthlySalary) || other.monthlySalary == monthlySalary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,profileImage,nickname,monthlySalary);

@override
String toString() {
  return 'ProfileUserModel(userId: $userId, profileImage: $profileImage, nickname: $nickname, monthlySalary: $monthlySalary)';
}


}

/// @nodoc
abstract mixin class $ProfileUserModelCopyWith<$Res>  {
  factory $ProfileUserModelCopyWith(ProfileUserModel value, $Res Function(ProfileUserModel) _then) = _$ProfileUserModelCopyWithImpl;
@useResult
$Res call({
 int userId, String? profileImage, String nickname, int monthlySalary
});




}
/// @nodoc
class _$ProfileUserModelCopyWithImpl<$Res>
    implements $ProfileUserModelCopyWith<$Res> {
  _$ProfileUserModelCopyWithImpl(this._self, this._then);

  final ProfileUserModel _self;
  final $Res Function(ProfileUserModel) _then;

/// Create a copy of ProfileUserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? profileImage = freezed,Object? nickname = null,Object? monthlySalary = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,monthlySalary: null == monthlySalary ? _self.monthlySalary : monthlySalary // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileUserModel].
extension ProfileUserModelPatterns on ProfileUserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileUserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileUserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileUserModel value)  $default,){
final _that = this;
switch (_that) {
case _ProfileUserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileUserModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileUserModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int userId,  String? profileImage,  String nickname,  int monthlySalary)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileUserModel() when $default != null:
return $default(_that.userId,_that.profileImage,_that.nickname,_that.monthlySalary);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int userId,  String? profileImage,  String nickname,  int monthlySalary)  $default,) {final _that = this;
switch (_that) {
case _ProfileUserModel():
return $default(_that.userId,_that.profileImage,_that.nickname,_that.monthlySalary);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int userId,  String? profileImage,  String nickname,  int monthlySalary)?  $default,) {final _that = this;
switch (_that) {
case _ProfileUserModel() when $default != null:
return $default(_that.userId,_that.profileImage,_that.nickname,_that.monthlySalary);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileUserModel implements ProfileUserModel {
  const _ProfileUserModel({this.userId = 0, this.profileImage, required this.nickname, this.monthlySalary = 0});
  factory _ProfileUserModel.fromJson(Map<String, dynamic> json) => _$ProfileUserModelFromJson(json);

// ✨ @Default(0) 추가
@override@JsonKey() final  int userId;
@override final  String? profileImage;
@override final  String nickname;
// ✨ @Default(0) 추가
@override@JsonKey() final  int monthlySalary;

/// Create a copy of ProfileUserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileUserModelCopyWith<_ProfileUserModel> get copyWith => __$ProfileUserModelCopyWithImpl<_ProfileUserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileUserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileUserModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.monthlySalary, monthlySalary) || other.monthlySalary == monthlySalary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,profileImage,nickname,monthlySalary);

@override
String toString() {
  return 'ProfileUserModel(userId: $userId, profileImage: $profileImage, nickname: $nickname, monthlySalary: $monthlySalary)';
}


}

/// @nodoc
abstract mixin class _$ProfileUserModelCopyWith<$Res> implements $ProfileUserModelCopyWith<$Res> {
  factory _$ProfileUserModelCopyWith(_ProfileUserModel value, $Res Function(_ProfileUserModel) _then) = __$ProfileUserModelCopyWithImpl;
@override @useResult
$Res call({
 int userId, String? profileImage, String nickname, int monthlySalary
});




}
/// @nodoc
class __$ProfileUserModelCopyWithImpl<$Res>
    implements _$ProfileUserModelCopyWith<$Res> {
  __$ProfileUserModelCopyWithImpl(this._self, this._then);

  final _ProfileUserModel _self;
  final $Res Function(_ProfileUserModel) _then;

/// Create a copy of ProfileUserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? profileImage = freezed,Object? nickname = null,Object? monthlySalary = null,}) {
  return _then(_ProfileUserModel(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,monthlySalary: null == monthlySalary ? _self.monthlySalary : monthlySalary // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
