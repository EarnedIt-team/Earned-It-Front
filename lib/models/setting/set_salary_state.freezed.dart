// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'set_salary_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SetSalaryState {

 String get salaryText; int get selectedDay; bool get isButtonEnabled; bool get isLoading; String get errorMessage; String? get salaryErrorText;
/// Create a copy of SetSalaryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetSalaryStateCopyWith<SetSalaryState> get copyWith => _$SetSalaryStateCopyWithImpl<SetSalaryState>(this as SetSalaryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetSalaryState&&(identical(other.salaryText, salaryText) || other.salaryText == salaryText)&&(identical(other.selectedDay, selectedDay) || other.selectedDay == selectedDay)&&(identical(other.isButtonEnabled, isButtonEnabled) || other.isButtonEnabled == isButtonEnabled)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.salaryErrorText, salaryErrorText) || other.salaryErrorText == salaryErrorText));
}


@override
int get hashCode => Object.hash(runtimeType,salaryText,selectedDay,isButtonEnabled,isLoading,errorMessage,salaryErrorText);

@override
String toString() {
  return 'SetSalaryState(salaryText: $salaryText, selectedDay: $selectedDay, isButtonEnabled: $isButtonEnabled, isLoading: $isLoading, errorMessage: $errorMessage, salaryErrorText: $salaryErrorText)';
}


}

/// @nodoc
abstract mixin class $SetSalaryStateCopyWith<$Res>  {
  factory $SetSalaryStateCopyWith(SetSalaryState value, $Res Function(SetSalaryState) _then) = _$SetSalaryStateCopyWithImpl;
@useResult
$Res call({
 String salaryText, int selectedDay, bool isButtonEnabled, bool isLoading, String errorMessage, String? salaryErrorText
});




}
/// @nodoc
class _$SetSalaryStateCopyWithImpl<$Res>
    implements $SetSalaryStateCopyWith<$Res> {
  _$SetSalaryStateCopyWithImpl(this._self, this._then);

  final SetSalaryState _self;
  final $Res Function(SetSalaryState) _then;

/// Create a copy of SetSalaryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? salaryText = null,Object? selectedDay = null,Object? isButtonEnabled = null,Object? isLoading = null,Object? errorMessage = null,Object? salaryErrorText = freezed,}) {
  return _then(_self.copyWith(
salaryText: null == salaryText ? _self.salaryText : salaryText // ignore: cast_nullable_to_non_nullable
as String,selectedDay: null == selectedDay ? _self.selectedDay : selectedDay // ignore: cast_nullable_to_non_nullable
as int,isButtonEnabled: null == isButtonEnabled ? _self.isButtonEnabled : isButtonEnabled // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,salaryErrorText: freezed == salaryErrorText ? _self.salaryErrorText : salaryErrorText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SetSalaryState].
extension SetSalaryStatePatterns on SetSalaryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SetSalaryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SetSalaryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SetSalaryState value)  $default,){
final _that = this;
switch (_that) {
case _SetSalaryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SetSalaryState value)?  $default,){
final _that = this;
switch (_that) {
case _SetSalaryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String salaryText,  int selectedDay,  bool isButtonEnabled,  bool isLoading,  String errorMessage,  String? salaryErrorText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SetSalaryState() when $default != null:
return $default(_that.salaryText,_that.selectedDay,_that.isButtonEnabled,_that.isLoading,_that.errorMessage,_that.salaryErrorText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String salaryText,  int selectedDay,  bool isButtonEnabled,  bool isLoading,  String errorMessage,  String? salaryErrorText)  $default,) {final _that = this;
switch (_that) {
case _SetSalaryState():
return $default(_that.salaryText,_that.selectedDay,_that.isButtonEnabled,_that.isLoading,_that.errorMessage,_that.salaryErrorText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String salaryText,  int selectedDay,  bool isButtonEnabled,  bool isLoading,  String errorMessage,  String? salaryErrorText)?  $default,) {final _that = this;
switch (_that) {
case _SetSalaryState() when $default != null:
return $default(_that.salaryText,_that.selectedDay,_that.isButtonEnabled,_that.isLoading,_that.errorMessage,_that.salaryErrorText);case _:
  return null;

}
}

}

/// @nodoc


class _SetSalaryState implements SetSalaryState {
  const _SetSalaryState({this.salaryText = '', this.selectedDay = 1, this.isButtonEnabled = false, this.isLoading = false, this.errorMessage = '', this.salaryErrorText});
  

@override@JsonKey() final  String salaryText;
@override@JsonKey() final  int selectedDay;
@override@JsonKey() final  bool isButtonEnabled;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  String errorMessage;
@override final  String? salaryErrorText;

/// Create a copy of SetSalaryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetSalaryStateCopyWith<_SetSalaryState> get copyWith => __$SetSalaryStateCopyWithImpl<_SetSalaryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetSalaryState&&(identical(other.salaryText, salaryText) || other.salaryText == salaryText)&&(identical(other.selectedDay, selectedDay) || other.selectedDay == selectedDay)&&(identical(other.isButtonEnabled, isButtonEnabled) || other.isButtonEnabled == isButtonEnabled)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.salaryErrorText, salaryErrorText) || other.salaryErrorText == salaryErrorText));
}


@override
int get hashCode => Object.hash(runtimeType,salaryText,selectedDay,isButtonEnabled,isLoading,errorMessage,salaryErrorText);

@override
String toString() {
  return 'SetSalaryState(salaryText: $salaryText, selectedDay: $selectedDay, isButtonEnabled: $isButtonEnabled, isLoading: $isLoading, errorMessage: $errorMessage, salaryErrorText: $salaryErrorText)';
}


}

/// @nodoc
abstract mixin class _$SetSalaryStateCopyWith<$Res> implements $SetSalaryStateCopyWith<$Res> {
  factory _$SetSalaryStateCopyWith(_SetSalaryState value, $Res Function(_SetSalaryState) _then) = __$SetSalaryStateCopyWithImpl;
@override @useResult
$Res call({
 String salaryText, int selectedDay, bool isButtonEnabled, bool isLoading, String errorMessage, String? salaryErrorText
});




}
/// @nodoc
class __$SetSalaryStateCopyWithImpl<$Res>
    implements _$SetSalaryStateCopyWith<$Res> {
  __$SetSalaryStateCopyWithImpl(this._self, this._then);

  final _SetSalaryState _self;
  final $Res Function(_SetSalaryState) _then;

/// Create a copy of SetSalaryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? salaryText = null,Object? selectedDay = null,Object? isButtonEnabled = null,Object? isLoading = null,Object? errorMessage = null,Object? salaryErrorText = freezed,}) {
  return _then(_SetSalaryState(
salaryText: null == salaryText ? _self.salaryText : salaryText // ignore: cast_nullable_to_non_nullable
as String,selectedDay: null == selectedDay ? _self.selectedDay : selectedDay // ignore: cast_nullable_to_non_nullable
as int,isButtonEnabled: null == isButtonEnabled ? _self.isButtonEnabled : isButtonEnabled // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,salaryErrorText: freezed == salaryErrorText ? _self.salaryErrorText : salaryErrorText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
