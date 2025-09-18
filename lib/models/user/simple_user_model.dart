import 'package:freezed_annotation/freezed_annotation.dart';

part 'simple_user_model.freezed.dart';
part 'simple_user_model.g.dart';

@freezed
abstract class SimpleUserModel with _$SimpleUserModel {
  const factory SimpleUserModel({
    required int userId,
    required String nickname,
    String? profileImage,
  }) = _SimpleUserModel;

  factory SimpleUserModel.fromJson(Map<String, dynamic> json) =>
      _$SimpleUserModelFromJson(json);
}
