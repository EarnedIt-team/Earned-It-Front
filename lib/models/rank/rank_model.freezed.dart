// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rank_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RankModel {

 int get userId; int get rank; String get nickname; int get score; String? get profileImage;
/// Create a copy of RankModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RankModelCopyWith<RankModel> get copyWith => _$RankModelCopyWithImpl<RankModel>(this as RankModel, _$identity);

  /// Serializes this RankModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RankModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.score, score) || other.score == score)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,rank,nickname,score,profileImage);

@override
String toString() {
  return 'RankModel(userId: $userId, rank: $rank, nickname: $nickname, score: $score, profileImage: $profileImage)';
}


}

/// @nodoc
abstract mixin class $RankModelCopyWith<$Res>  {
  factory $RankModelCopyWith(RankModel value, $Res Function(RankModel) _then) = _$RankModelCopyWithImpl;
@useResult
$Res call({
 int userId, int rank, String nickname, int score, String? profileImage
});




}
/// @nodoc
class _$RankModelCopyWithImpl<$Res>
    implements $RankModelCopyWith<$Res> {
  _$RankModelCopyWithImpl(this._self, this._then);

  final RankModel _self;
  final $Res Function(RankModel) _then;

/// Create a copy of RankModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? rank = null,Object? nickname = null,Object? score = null,Object? profileImage = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RankModel].
extension RankModelPatterns on RankModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RankModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RankModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RankModel value)  $default,){
final _that = this;
switch (_that) {
case _RankModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RankModel value)?  $default,){
final _that = this;
switch (_that) {
case _RankModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int userId,  int rank,  String nickname,  int score,  String? profileImage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RankModel() when $default != null:
return $default(_that.userId,_that.rank,_that.nickname,_that.score,_that.profileImage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int userId,  int rank,  String nickname,  int score,  String? profileImage)  $default,) {final _that = this;
switch (_that) {
case _RankModel():
return $default(_that.userId,_that.rank,_that.nickname,_that.score,_that.profileImage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int userId,  int rank,  String nickname,  int score,  String? profileImage)?  $default,) {final _that = this;
switch (_that) {
case _RankModel() when $default != null:
return $default(_that.userId,_that.rank,_that.nickname,_that.score,_that.profileImage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RankModel implements RankModel {
  const _RankModel({required this.userId, required this.rank, required this.nickname, required this.score, this.profileImage});
  factory _RankModel.fromJson(Map<String, dynamic> json) => _$RankModelFromJson(json);

@override final  int userId;
@override final  int rank;
@override final  String nickname;
@override final  int score;
@override final  String? profileImage;

/// Create a copy of RankModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RankModelCopyWith<_RankModel> get copyWith => __$RankModelCopyWithImpl<_RankModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RankModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RankModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.score, score) || other.score == score)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,rank,nickname,score,profileImage);

@override
String toString() {
  return 'RankModel(userId: $userId, rank: $rank, nickname: $nickname, score: $score, profileImage: $profileImage)';
}


}

/// @nodoc
abstract mixin class _$RankModelCopyWith<$Res> implements $RankModelCopyWith<$Res> {
  factory _$RankModelCopyWith(_RankModel value, $Res Function(_RankModel) _then) = __$RankModelCopyWithImpl;
@override @useResult
$Res call({
 int userId, int rank, String nickname, int score, String? profileImage
});




}
/// @nodoc
class __$RankModelCopyWithImpl<$Res>
    implements _$RankModelCopyWith<$Res> {
  __$RankModelCopyWithImpl(this._self, this._then);

  final _RankModel _self;
  final $Res Function(_RankModel) _then;

/// Create a copy of RankModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? rank = null,Object? nickname = null,Object? score = null,Object? profileImage = freezed,}) {
  return _then(_RankModel(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
