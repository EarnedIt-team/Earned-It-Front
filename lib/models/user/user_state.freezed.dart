// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserState {

/// 월 수익 설정 여부
@JsonKey(name: 'hasSalary') bool get isearningsPerSecond;/// 월 급여
@JsonKey(name: 'amount') int get monthlySalary;/// 월급날
 int get payday;/// 초당 수익
@JsonKey(name: 'amountPerSec') double get earningsPerSecond;/// 약관 동의 여부 (Default = true)
 bool get hasAgreedTerm;/// 즐겨찾기 위시리스트 (Top5)
 List<WishModel> get starWishes;/// 위시리스트 상위 노출 3개
 List<WishModel> get Wishes3;/// 전체 위시리스트
 List<WishModel> get totalWishes;/// 등록된 위시아이템 개수
 int get currentWishCount;
/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserStateCopyWith<UserState> get copyWith => _$UserStateCopyWithImpl<UserState>(this as UserState, _$identity);

  /// Serializes this UserState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserState&&(identical(other.isearningsPerSecond, isearningsPerSecond) || other.isearningsPerSecond == isearningsPerSecond)&&(identical(other.monthlySalary, monthlySalary) || other.monthlySalary == monthlySalary)&&(identical(other.payday, payday) || other.payday == payday)&&(identical(other.earningsPerSecond, earningsPerSecond) || other.earningsPerSecond == earningsPerSecond)&&(identical(other.hasAgreedTerm, hasAgreedTerm) || other.hasAgreedTerm == hasAgreedTerm)&&const DeepCollectionEquality().equals(other.starWishes, starWishes)&&const DeepCollectionEquality().equals(other.Wishes3, Wishes3)&&const DeepCollectionEquality().equals(other.totalWishes, totalWishes)&&(identical(other.currentWishCount, currentWishCount) || other.currentWishCount == currentWishCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isearningsPerSecond,monthlySalary,payday,earningsPerSecond,hasAgreedTerm,const DeepCollectionEquality().hash(starWishes),const DeepCollectionEquality().hash(Wishes3),const DeepCollectionEquality().hash(totalWishes),currentWishCount);

@override
String toString() {
  return 'UserState(isearningsPerSecond: $isearningsPerSecond, monthlySalary: $monthlySalary, payday: $payday, earningsPerSecond: $earningsPerSecond, hasAgreedTerm: $hasAgreedTerm, starWishes: $starWishes, Wishes3: $Wishes3, totalWishes: $totalWishes, currentWishCount: $currentWishCount)';
}


}

/// @nodoc
abstract mixin class $UserStateCopyWith<$Res>  {
  factory $UserStateCopyWith(UserState value, $Res Function(UserState) _then) = _$UserStateCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'hasSalary') bool isearningsPerSecond,@JsonKey(name: 'amount') int monthlySalary, int payday,@JsonKey(name: 'amountPerSec') double earningsPerSecond, bool hasAgreedTerm, List<WishModel> starWishes, List<WishModel> Wishes3, List<WishModel> totalWishes, int currentWishCount
});




}
/// @nodoc
class _$UserStateCopyWithImpl<$Res>
    implements $UserStateCopyWith<$Res> {
  _$UserStateCopyWithImpl(this._self, this._then);

  final UserState _self;
  final $Res Function(UserState) _then;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isearningsPerSecond = null,Object? monthlySalary = null,Object? payday = null,Object? earningsPerSecond = null,Object? hasAgreedTerm = null,Object? starWishes = null,Object? Wishes3 = null,Object? totalWishes = null,Object? currentWishCount = null,}) {
  return _then(_self.copyWith(
isearningsPerSecond: null == isearningsPerSecond ? _self.isearningsPerSecond : isearningsPerSecond // ignore: cast_nullable_to_non_nullable
as bool,monthlySalary: null == monthlySalary ? _self.monthlySalary : monthlySalary // ignore: cast_nullable_to_non_nullable
as int,payday: null == payday ? _self.payday : payday // ignore: cast_nullable_to_non_nullable
as int,earningsPerSecond: null == earningsPerSecond ? _self.earningsPerSecond : earningsPerSecond // ignore: cast_nullable_to_non_nullable
as double,hasAgreedTerm: null == hasAgreedTerm ? _self.hasAgreedTerm : hasAgreedTerm // ignore: cast_nullable_to_non_nullable
as bool,starWishes: null == starWishes ? _self.starWishes : starWishes // ignore: cast_nullable_to_non_nullable
as List<WishModel>,Wishes3: null == Wishes3 ? _self.Wishes3 : Wishes3 // ignore: cast_nullable_to_non_nullable
as List<WishModel>,totalWishes: null == totalWishes ? _self.totalWishes : totalWishes // ignore: cast_nullable_to_non_nullable
as List<WishModel>,currentWishCount: null == currentWishCount ? _self.currentWishCount : currentWishCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UserState].
extension UserStatePatterns on UserState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserState value)  $default,){
final _that = this;
switch (_that) {
case _UserState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserState value)?  $default,){
final _that = this;
switch (_that) {
case _UserState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'hasSalary')  bool isearningsPerSecond, @JsonKey(name: 'amount')  int monthlySalary,  int payday, @JsonKey(name: 'amountPerSec')  double earningsPerSecond,  bool hasAgreedTerm,  List<WishModel> starWishes,  List<WishModel> Wishes3,  List<WishModel> totalWishes,  int currentWishCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserState() when $default != null:
return $default(_that.isearningsPerSecond,_that.monthlySalary,_that.payday,_that.earningsPerSecond,_that.hasAgreedTerm,_that.starWishes,_that.Wishes3,_that.totalWishes,_that.currentWishCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'hasSalary')  bool isearningsPerSecond, @JsonKey(name: 'amount')  int monthlySalary,  int payday, @JsonKey(name: 'amountPerSec')  double earningsPerSecond,  bool hasAgreedTerm,  List<WishModel> starWishes,  List<WishModel> Wishes3,  List<WishModel> totalWishes,  int currentWishCount)  $default,) {final _that = this;
switch (_that) {
case _UserState():
return $default(_that.isearningsPerSecond,_that.monthlySalary,_that.payday,_that.earningsPerSecond,_that.hasAgreedTerm,_that.starWishes,_that.Wishes3,_that.totalWishes,_that.currentWishCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'hasSalary')  bool isearningsPerSecond, @JsonKey(name: 'amount')  int monthlySalary,  int payday, @JsonKey(name: 'amountPerSec')  double earningsPerSecond,  bool hasAgreedTerm,  List<WishModel> starWishes,  List<WishModel> Wishes3,  List<WishModel> totalWishes,  int currentWishCount)?  $default,) {final _that = this;
switch (_that) {
case _UserState() when $default != null:
return $default(_that.isearningsPerSecond,_that.monthlySalary,_that.payday,_that.earningsPerSecond,_that.hasAgreedTerm,_that.starWishes,_that.Wishes3,_that.totalWishes,_that.currentWishCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserState implements UserState {
  const _UserState({@JsonKey(name: 'hasSalary') this.isearningsPerSecond = false, @JsonKey(name: 'amount') this.monthlySalary = 0, this.payday = 0, @JsonKey(name: 'amountPerSec') this.earningsPerSecond = 0.0, this.hasAgreedTerm = true, final  List<WishModel> starWishes = const [], final  List<WishModel> Wishes3 = const [], final  List<WishModel> totalWishes = const [], this.currentWishCount = 0}): _starWishes = starWishes,_Wishes3 = Wishes3,_totalWishes = totalWishes;
  factory _UserState.fromJson(Map<String, dynamic> json) => _$UserStateFromJson(json);

/// 월 수익 설정 여부
@override@JsonKey(name: 'hasSalary') final  bool isearningsPerSecond;
/// 월 급여
@override@JsonKey(name: 'amount') final  int monthlySalary;
/// 월급날
@override@JsonKey() final  int payday;
/// 초당 수익
@override@JsonKey(name: 'amountPerSec') final  double earningsPerSecond;
/// 약관 동의 여부 (Default = true)
@override@JsonKey() final  bool hasAgreedTerm;
/// 즐겨찾기 위시리스트 (Top5)
 final  List<WishModel> _starWishes;
/// 즐겨찾기 위시리스트 (Top5)
@override@JsonKey() List<WishModel> get starWishes {
  if (_starWishes is EqualUnmodifiableListView) return _starWishes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_starWishes);
}

/// 위시리스트 상위 노출 3개
 final  List<WishModel> _Wishes3;
/// 위시리스트 상위 노출 3개
@override@JsonKey() List<WishModel> get Wishes3 {
  if (_Wishes3 is EqualUnmodifiableListView) return _Wishes3;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_Wishes3);
}

/// 전체 위시리스트
 final  List<WishModel> _totalWishes;
/// 전체 위시리스트
@override@JsonKey() List<WishModel> get totalWishes {
  if (_totalWishes is EqualUnmodifiableListView) return _totalWishes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_totalWishes);
}

/// 등록된 위시아이템 개수
@override@JsonKey() final  int currentWishCount;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserStateCopyWith<_UserState> get copyWith => __$UserStateCopyWithImpl<_UserState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserState&&(identical(other.isearningsPerSecond, isearningsPerSecond) || other.isearningsPerSecond == isearningsPerSecond)&&(identical(other.monthlySalary, monthlySalary) || other.monthlySalary == monthlySalary)&&(identical(other.payday, payday) || other.payday == payday)&&(identical(other.earningsPerSecond, earningsPerSecond) || other.earningsPerSecond == earningsPerSecond)&&(identical(other.hasAgreedTerm, hasAgreedTerm) || other.hasAgreedTerm == hasAgreedTerm)&&const DeepCollectionEquality().equals(other._starWishes, _starWishes)&&const DeepCollectionEquality().equals(other._Wishes3, _Wishes3)&&const DeepCollectionEquality().equals(other._totalWishes, _totalWishes)&&(identical(other.currentWishCount, currentWishCount) || other.currentWishCount == currentWishCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isearningsPerSecond,monthlySalary,payday,earningsPerSecond,hasAgreedTerm,const DeepCollectionEquality().hash(_starWishes),const DeepCollectionEquality().hash(_Wishes3),const DeepCollectionEquality().hash(_totalWishes),currentWishCount);

@override
String toString() {
  return 'UserState(isearningsPerSecond: $isearningsPerSecond, monthlySalary: $monthlySalary, payday: $payday, earningsPerSecond: $earningsPerSecond, hasAgreedTerm: $hasAgreedTerm, starWishes: $starWishes, Wishes3: $Wishes3, totalWishes: $totalWishes, currentWishCount: $currentWishCount)';
}


}

/// @nodoc
abstract mixin class _$UserStateCopyWith<$Res> implements $UserStateCopyWith<$Res> {
  factory _$UserStateCopyWith(_UserState value, $Res Function(_UserState) _then) = __$UserStateCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'hasSalary') bool isearningsPerSecond,@JsonKey(name: 'amount') int monthlySalary, int payday,@JsonKey(name: 'amountPerSec') double earningsPerSecond, bool hasAgreedTerm, List<WishModel> starWishes, List<WishModel> Wishes3, List<WishModel> totalWishes, int currentWishCount
});




}
/// @nodoc
class __$UserStateCopyWithImpl<$Res>
    implements _$UserStateCopyWith<$Res> {
  __$UserStateCopyWithImpl(this._self, this._then);

  final _UserState _self;
  final $Res Function(_UserState) _then;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isearningsPerSecond = null,Object? monthlySalary = null,Object? payday = null,Object? earningsPerSecond = null,Object? hasAgreedTerm = null,Object? starWishes = null,Object? Wishes3 = null,Object? totalWishes = null,Object? currentWishCount = null,}) {
  return _then(_UserState(
isearningsPerSecond: null == isearningsPerSecond ? _self.isearningsPerSecond : isearningsPerSecond // ignore: cast_nullable_to_non_nullable
as bool,monthlySalary: null == monthlySalary ? _self.monthlySalary : monthlySalary // ignore: cast_nullable_to_non_nullable
as int,payday: null == payday ? _self.payday : payday // ignore: cast_nullable_to_non_nullable
as int,earningsPerSecond: null == earningsPerSecond ? _self.earningsPerSecond : earningsPerSecond // ignore: cast_nullable_to_non_nullable
as double,hasAgreedTerm: null == hasAgreedTerm ? _self.hasAgreedTerm : hasAgreedTerm // ignore: cast_nullable_to_non_nullable
as bool,starWishes: null == starWishes ? _self._starWishes : starWishes // ignore: cast_nullable_to_non_nullable
as List<WishModel>,Wishes3: null == Wishes3 ? _self._Wishes3 : Wishes3 // ignore: cast_nullable_to_non_nullable
as List<WishModel>,totalWishes: null == totalWishes ? _self._totalWishes : totalWishes // ignore: cast_nullable_to_non_nullable
as List<WishModel>,currentWishCount: null == currentWishCount ? _self.currentWishCount : currentWishCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
