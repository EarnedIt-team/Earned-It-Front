import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkedIn_model.freezed.dart';
part 'checkedIn_model.g.dart';

// 출석체크 모달의 상태를 정의하는 State 클래스
@freezed
abstract class CheckedinModel with _$CheckedinModel {
  const factory CheckedinModel({
    int? itemId,
    String? name,
    String? image,
    int? price,
  }) = _CheckedinModel;

  factory CheckedinModel.fromJson(Map<String, dynamic> json) =>
      _$CheckedinModelFromJson(json);
}
