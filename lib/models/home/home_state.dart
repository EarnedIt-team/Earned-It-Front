import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(0) int toggleIndex,
    @Default(0.0) double currentEarnedAmount,
  }) = _HomeState;
}
