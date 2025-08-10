// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkedIn_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CheckedInState {

 bool get isLoading;/// 사용자가 선택한 상자 인덱스
 int? get selectedIndex;/// 획득한 보상
 String? get reward;/// 보상 요청 인증 토큰
 String? get rewardToken;/// 보상 후보
 List<CheckedinModel> get candidatesCheckedInList;
/// Create a copy of CheckedInState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckedInStateCopyWith<CheckedInState> get copyWith => _$CheckedInStateCopyWithImpl<CheckedInState>(this as CheckedInState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckedInState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex)&&(identical(other.reward, reward) || other.reward == reward)&&(identical(other.rewardToken, rewardToken) || other.rewardToken == rewardToken)&&const DeepCollectionEquality().equals(other.candidatesCheckedInList, candidatesCheckedInList));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,selectedIndex,reward,rewardToken,const DeepCollectionEquality().hash(candidatesCheckedInList));

@override
String toString() {
  return 'CheckedInState(isLoading: $isLoading, selectedIndex: $selectedIndex, reward: $reward, rewardToken: $rewardToken, candidatesCheckedInList: $candidatesCheckedInList)';
}


}

/// @nodoc
abstract mixin class $CheckedInStateCopyWith<$Res>  {
  factory $CheckedInStateCopyWith(CheckedInState value, $Res Function(CheckedInState) _then) = _$CheckedInStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, int? selectedIndex, String? reward, String? rewardToken, List<CheckedinModel> candidatesCheckedInList
});




}
/// @nodoc
class _$CheckedInStateCopyWithImpl<$Res>
    implements $CheckedInStateCopyWith<$Res> {
  _$CheckedInStateCopyWithImpl(this._self, this._then);

  final CheckedInState _self;
  final $Res Function(CheckedInState) _then;

/// Create a copy of CheckedInState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? selectedIndex = freezed,Object? reward = freezed,Object? rewardToken = freezed,Object? candidatesCheckedInList = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,selectedIndex: freezed == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int?,reward: freezed == reward ? _self.reward : reward // ignore: cast_nullable_to_non_nullable
as String?,rewardToken: freezed == rewardToken ? _self.rewardToken : rewardToken // ignore: cast_nullable_to_non_nullable
as String?,candidatesCheckedInList: null == candidatesCheckedInList ? _self.candidatesCheckedInList : candidatesCheckedInList // ignore: cast_nullable_to_non_nullable
as List<CheckedinModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckedInState].
extension CheckedInStatePatterns on CheckedInState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckedInState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckedInState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckedInState value)  $default,){
final _that = this;
switch (_that) {
case _CheckedInState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckedInState value)?  $default,){
final _that = this;
switch (_that) {
case _CheckedInState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  int? selectedIndex,  String? reward,  String? rewardToken,  List<CheckedinModel> candidatesCheckedInList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckedInState() when $default != null:
return $default(_that.isLoading,_that.selectedIndex,_that.reward,_that.rewardToken,_that.candidatesCheckedInList);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  int? selectedIndex,  String? reward,  String? rewardToken,  List<CheckedinModel> candidatesCheckedInList)  $default,) {final _that = this;
switch (_that) {
case _CheckedInState():
return $default(_that.isLoading,_that.selectedIndex,_that.reward,_that.rewardToken,_that.candidatesCheckedInList);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  int? selectedIndex,  String? reward,  String? rewardToken,  List<CheckedinModel> candidatesCheckedInList)?  $default,) {final _that = this;
switch (_that) {
case _CheckedInState() when $default != null:
return $default(_that.isLoading,_that.selectedIndex,_that.reward,_that.rewardToken,_that.candidatesCheckedInList);case _:
  return null;

}
}

}

/// @nodoc


class _CheckedInState implements CheckedInState {
  const _CheckedInState({this.isLoading = false, this.selectedIndex, this.reward, this.rewardToken, final  List<CheckedinModel> candidatesCheckedInList = const []}): _candidatesCheckedInList = candidatesCheckedInList;
  

@override@JsonKey() final  bool isLoading;
/// 사용자가 선택한 상자 인덱스
@override final  int? selectedIndex;
/// 획득한 보상
@override final  String? reward;
/// 보상 요청 인증 토큰
@override final  String? rewardToken;
/// 보상 후보
 final  List<CheckedinModel> _candidatesCheckedInList;
/// 보상 후보
@override@JsonKey() List<CheckedinModel> get candidatesCheckedInList {
  if (_candidatesCheckedInList is EqualUnmodifiableListView) return _candidatesCheckedInList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_candidatesCheckedInList);
}


/// Create a copy of CheckedInState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckedInStateCopyWith<_CheckedInState> get copyWith => __$CheckedInStateCopyWithImpl<_CheckedInState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckedInState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex)&&(identical(other.reward, reward) || other.reward == reward)&&(identical(other.rewardToken, rewardToken) || other.rewardToken == rewardToken)&&const DeepCollectionEquality().equals(other._candidatesCheckedInList, _candidatesCheckedInList));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,selectedIndex,reward,rewardToken,const DeepCollectionEquality().hash(_candidatesCheckedInList));

@override
String toString() {
  return 'CheckedInState(isLoading: $isLoading, selectedIndex: $selectedIndex, reward: $reward, rewardToken: $rewardToken, candidatesCheckedInList: $candidatesCheckedInList)';
}


}

/// @nodoc
abstract mixin class _$CheckedInStateCopyWith<$Res> implements $CheckedInStateCopyWith<$Res> {
  factory _$CheckedInStateCopyWith(_CheckedInState value, $Res Function(_CheckedInState) _then) = __$CheckedInStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, int? selectedIndex, String? reward, String? rewardToken, List<CheckedinModel> candidatesCheckedInList
});




}
/// @nodoc
class __$CheckedInStateCopyWithImpl<$Res>
    implements _$CheckedInStateCopyWith<$Res> {
  __$CheckedInStateCopyWithImpl(this._self, this._then);

  final _CheckedInState _self;
  final $Res Function(_CheckedInState) _then;

/// Create a copy of CheckedInState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? selectedIndex = freezed,Object? reward = freezed,Object? rewardToken = freezed,Object? candidatesCheckedInList = null,}) {
  return _then(_CheckedInState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,selectedIndex: freezed == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int?,reward: freezed == reward ? _self.reward : reward // ignore: cast_nullable_to_non_nullable
as String?,rewardToken: freezed == rewardToken ? _self.rewardToken : rewardToken // ignore: cast_nullable_to_non_nullable
as String?,candidatesCheckedInList: null == candidatesCheckedInList ? _self._candidatesCheckedInList : candidatesCheckedInList // ignore: cast_nullable_to_non_nullable
as List<CheckedinModel>,
  ));
}


}

// dart format on
