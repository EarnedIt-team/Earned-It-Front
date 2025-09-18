// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rank_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RankState {

/// 데이터 통신 중 로딩 상태
 bool get isLoading;/// 내 랭킹 정보
 RankModel? get myRank;/// 상위 10명 랭킹 리스트
 List<RankModel> get top10;/// 데이터가 마지막으로 업데이트된 시간
 DateTime? get lastUpdated;
/// Create a copy of RankState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RankStateCopyWith<RankState> get copyWith => _$RankStateCopyWithImpl<RankState>(this as RankState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RankState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.myRank, myRank) || other.myRank == myRank)&&const DeepCollectionEquality().equals(other.top10, top10)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,myRank,const DeepCollectionEquality().hash(top10),lastUpdated);

@override
String toString() {
  return 'RankState(isLoading: $isLoading, myRank: $myRank, top10: $top10, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class $RankStateCopyWith<$Res>  {
  factory $RankStateCopyWith(RankState value, $Res Function(RankState) _then) = _$RankStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, RankModel? myRank, List<RankModel> top10, DateTime? lastUpdated
});


$RankModelCopyWith<$Res>? get myRank;

}
/// @nodoc
class _$RankStateCopyWithImpl<$Res>
    implements $RankStateCopyWith<$Res> {
  _$RankStateCopyWithImpl(this._self, this._then);

  final RankState _self;
  final $Res Function(RankState) _then;

/// Create a copy of RankState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? myRank = freezed,Object? top10 = null,Object? lastUpdated = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,myRank: freezed == myRank ? _self.myRank : myRank // ignore: cast_nullable_to_non_nullable
as RankModel?,top10: null == top10 ? _self.top10 : top10 // ignore: cast_nullable_to_non_nullable
as List<RankModel>,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of RankState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RankModelCopyWith<$Res>? get myRank {
    if (_self.myRank == null) {
    return null;
  }

  return $RankModelCopyWith<$Res>(_self.myRank!, (value) {
    return _then(_self.copyWith(myRank: value));
  });
}
}


/// Adds pattern-matching-related methods to [RankState].
extension RankStatePatterns on RankState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RankState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RankState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RankState value)  $default,){
final _that = this;
switch (_that) {
case _RankState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RankState value)?  $default,){
final _that = this;
switch (_that) {
case _RankState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  RankModel? myRank,  List<RankModel> top10,  DateTime? lastUpdated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RankState() when $default != null:
return $default(_that.isLoading,_that.myRank,_that.top10,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  RankModel? myRank,  List<RankModel> top10,  DateTime? lastUpdated)  $default,) {final _that = this;
switch (_that) {
case _RankState():
return $default(_that.isLoading,_that.myRank,_that.top10,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  RankModel? myRank,  List<RankModel> top10,  DateTime? lastUpdated)?  $default,) {final _that = this;
switch (_that) {
case _RankState() when $default != null:
return $default(_that.isLoading,_that.myRank,_that.top10,_that.lastUpdated);case _:
  return null;

}
}

}

/// @nodoc


class _RankState implements RankState {
  const _RankState({this.isLoading = false, this.myRank, final  List<RankModel> top10 = const [], this.lastUpdated}): _top10 = top10;
  

/// 데이터 통신 중 로딩 상태
@override@JsonKey() final  bool isLoading;
/// 내 랭킹 정보
@override final  RankModel? myRank;
/// 상위 10명 랭킹 리스트
 final  List<RankModel> _top10;
/// 상위 10명 랭킹 리스트
@override@JsonKey() List<RankModel> get top10 {
  if (_top10 is EqualUnmodifiableListView) return _top10;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_top10);
}

/// 데이터가 마지막으로 업데이트된 시간
@override final  DateTime? lastUpdated;

/// Create a copy of RankState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RankStateCopyWith<_RankState> get copyWith => __$RankStateCopyWithImpl<_RankState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RankState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.myRank, myRank) || other.myRank == myRank)&&const DeepCollectionEquality().equals(other._top10, _top10)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,myRank,const DeepCollectionEquality().hash(_top10),lastUpdated);

@override
String toString() {
  return 'RankState(isLoading: $isLoading, myRank: $myRank, top10: $top10, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class _$RankStateCopyWith<$Res> implements $RankStateCopyWith<$Res> {
  factory _$RankStateCopyWith(_RankState value, $Res Function(_RankState) _then) = __$RankStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, RankModel? myRank, List<RankModel> top10, DateTime? lastUpdated
});


@override $RankModelCopyWith<$Res>? get myRank;

}
/// @nodoc
class __$RankStateCopyWithImpl<$Res>
    implements _$RankStateCopyWith<$Res> {
  __$RankStateCopyWithImpl(this._self, this._then);

  final _RankState _self;
  final $Res Function(_RankState) _then;

/// Create a copy of RankState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? myRank = freezed,Object? top10 = null,Object? lastUpdated = freezed,}) {
  return _then(_RankState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,myRank: freezed == myRank ? _self.myRank : myRank // ignore: cast_nullable_to_non_nullable
as RankModel?,top10: null == top10 ? _self._top10 : top10 // ignore: cast_nullable_to_non_nullable
as List<RankModel>,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of RankState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RankModelCopyWith<$Res>? get myRank {
    if (_self.myRank == null) {
    return null;
  }

  return $RankModelCopyWith<$Res>(_self.myRank!, (value) {
    return _then(_self.copyWith(myRank: value));
  });
}
}

// dart format on
