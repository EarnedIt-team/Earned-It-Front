// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'piece_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PieceState {

// 처리 여부
 bool get isLoading;// 가장 최근에 획득한 조각
 PieceInfoModel? get recentlyPiece;// 선택한 조각
 PieceInfoModel? get selectedPiece;/// 현재까지 획득한 조각 리스트 (퍼즐 View)
 List<ThemeModel> get pieces;
/// Create a copy of PieceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PieceStateCopyWith<PieceState> get copyWith => _$PieceStateCopyWithImpl<PieceState>(this as PieceState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PieceState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.recentlyPiece, recentlyPiece) || other.recentlyPiece == recentlyPiece)&&(identical(other.selectedPiece, selectedPiece) || other.selectedPiece == selectedPiece)&&const DeepCollectionEquality().equals(other.pieces, pieces));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,recentlyPiece,selectedPiece,const DeepCollectionEquality().hash(pieces));

@override
String toString() {
  return 'PieceState(isLoading: $isLoading, recentlyPiece: $recentlyPiece, selectedPiece: $selectedPiece, pieces: $pieces)';
}


}

/// @nodoc
abstract mixin class $PieceStateCopyWith<$Res>  {
  factory $PieceStateCopyWith(PieceState value, $Res Function(PieceState) _then) = _$PieceStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, PieceInfoModel? recentlyPiece, PieceInfoModel? selectedPiece, List<ThemeModel> pieces
});


$PieceInfoModelCopyWith<$Res>? get recentlyPiece;$PieceInfoModelCopyWith<$Res>? get selectedPiece;

}
/// @nodoc
class _$PieceStateCopyWithImpl<$Res>
    implements $PieceStateCopyWith<$Res> {
  _$PieceStateCopyWithImpl(this._self, this._then);

  final PieceState _self;
  final $Res Function(PieceState) _then;

/// Create a copy of PieceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? recentlyPiece = freezed,Object? selectedPiece = freezed,Object? pieces = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,recentlyPiece: freezed == recentlyPiece ? _self.recentlyPiece : recentlyPiece // ignore: cast_nullable_to_non_nullable
as PieceInfoModel?,selectedPiece: freezed == selectedPiece ? _self.selectedPiece : selectedPiece // ignore: cast_nullable_to_non_nullable
as PieceInfoModel?,pieces: null == pieces ? _self.pieces : pieces // ignore: cast_nullable_to_non_nullable
as List<ThemeModel>,
  ));
}
/// Create a copy of PieceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PieceInfoModelCopyWith<$Res>? get recentlyPiece {
    if (_self.recentlyPiece == null) {
    return null;
  }

  return $PieceInfoModelCopyWith<$Res>(_self.recentlyPiece!, (value) {
    return _then(_self.copyWith(recentlyPiece: value));
  });
}/// Create a copy of PieceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PieceInfoModelCopyWith<$Res>? get selectedPiece {
    if (_self.selectedPiece == null) {
    return null;
  }

  return $PieceInfoModelCopyWith<$Res>(_self.selectedPiece!, (value) {
    return _then(_self.copyWith(selectedPiece: value));
  });
}
}


/// Adds pattern-matching-related methods to [PieceState].
extension PieceStatePatterns on PieceState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PieceState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PieceState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PieceState value)  $default,){
final _that = this;
switch (_that) {
case _PieceState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PieceState value)?  $default,){
final _that = this;
switch (_that) {
case _PieceState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  PieceInfoModel? recentlyPiece,  PieceInfoModel? selectedPiece,  List<ThemeModel> pieces)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PieceState() when $default != null:
return $default(_that.isLoading,_that.recentlyPiece,_that.selectedPiece,_that.pieces);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  PieceInfoModel? recentlyPiece,  PieceInfoModel? selectedPiece,  List<ThemeModel> pieces)  $default,) {final _that = this;
switch (_that) {
case _PieceState():
return $default(_that.isLoading,_that.recentlyPiece,_that.selectedPiece,_that.pieces);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  PieceInfoModel? recentlyPiece,  PieceInfoModel? selectedPiece,  List<ThemeModel> pieces)?  $default,) {final _that = this;
switch (_that) {
case _PieceState() when $default != null:
return $default(_that.isLoading,_that.recentlyPiece,_that.selectedPiece,_that.pieces);case _:
  return null;

}
}

}

/// @nodoc


class _PieceState implements PieceState {
  const _PieceState({this.isLoading = false, this.recentlyPiece, this.selectedPiece, final  List<ThemeModel> pieces = const []}): _pieces = pieces;
  

// 처리 여부
@override@JsonKey() final  bool isLoading;
// 가장 최근에 획득한 조각
@override final  PieceInfoModel? recentlyPiece;
// 선택한 조각
@override final  PieceInfoModel? selectedPiece;
/// 현재까지 획득한 조각 리스트 (퍼즐 View)
 final  List<ThemeModel> _pieces;
/// 현재까지 획득한 조각 리스트 (퍼즐 View)
@override@JsonKey() List<ThemeModel> get pieces {
  if (_pieces is EqualUnmodifiableListView) return _pieces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pieces);
}


/// Create a copy of PieceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PieceStateCopyWith<_PieceState> get copyWith => __$PieceStateCopyWithImpl<_PieceState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PieceState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.recentlyPiece, recentlyPiece) || other.recentlyPiece == recentlyPiece)&&(identical(other.selectedPiece, selectedPiece) || other.selectedPiece == selectedPiece)&&const DeepCollectionEquality().equals(other._pieces, _pieces));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,recentlyPiece,selectedPiece,const DeepCollectionEquality().hash(_pieces));

@override
String toString() {
  return 'PieceState(isLoading: $isLoading, recentlyPiece: $recentlyPiece, selectedPiece: $selectedPiece, pieces: $pieces)';
}


}

/// @nodoc
abstract mixin class _$PieceStateCopyWith<$Res> implements $PieceStateCopyWith<$Res> {
  factory _$PieceStateCopyWith(_PieceState value, $Res Function(_PieceState) _then) = __$PieceStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, PieceInfoModel? recentlyPiece, PieceInfoModel? selectedPiece, List<ThemeModel> pieces
});


@override $PieceInfoModelCopyWith<$Res>? get recentlyPiece;@override $PieceInfoModelCopyWith<$Res>? get selectedPiece;

}
/// @nodoc
class __$PieceStateCopyWithImpl<$Res>
    implements _$PieceStateCopyWith<$Res> {
  __$PieceStateCopyWithImpl(this._self, this._then);

  final _PieceState _self;
  final $Res Function(_PieceState) _then;

/// Create a copy of PieceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? recentlyPiece = freezed,Object? selectedPiece = freezed,Object? pieces = null,}) {
  return _then(_PieceState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,recentlyPiece: freezed == recentlyPiece ? _self.recentlyPiece : recentlyPiece // ignore: cast_nullable_to_non_nullable
as PieceInfoModel?,selectedPiece: freezed == selectedPiece ? _self.selectedPiece : selectedPiece // ignore: cast_nullable_to_non_nullable
as PieceInfoModel?,pieces: null == pieces ? _self._pieces : pieces // ignore: cast_nullable_to_non_nullable
as List<ThemeModel>,
  ));
}

/// Create a copy of PieceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PieceInfoModelCopyWith<$Res>? get recentlyPiece {
    if (_self.recentlyPiece == null) {
    return null;
  }

  return $PieceInfoModelCopyWith<$Res>(_self.recentlyPiece!, (value) {
    return _then(_self.copyWith(recentlyPiece: value));
  });
}/// Create a copy of PieceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PieceInfoModelCopyWith<$Res>? get selectedPiece {
    if (_self.selectedPiece == null) {
    return null;
  }

  return $PieceInfoModelCopyWith<$Res>(_self.selectedPiece!, (value) {
    return _then(_self.copyWith(selectedPiece: value));
  });
}
}

// dart format on
