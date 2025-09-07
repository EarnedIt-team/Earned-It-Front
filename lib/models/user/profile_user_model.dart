import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_user_model.freezed.dart';
part 'profile_user_model.g.dart';

@freezed
abstract class ProfileUserModel with _$ProfileUserModel {
  const factory ProfileUserModel({
    // ✨ @Default(0) 추가
    @Default(0) int userId,

    String? profileImage,
    required String nickname,

    // ✨ @Default(0) 추가
    @Default(0) int monthlySalary,

    @Default(0.0) double amountPerSec,
  }) = _ProfileUserModel;

  factory ProfileUserModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileUserModelFromJson(json);
}
