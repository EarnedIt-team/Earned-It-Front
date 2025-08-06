import 'package:earned_it/models/wish/wish_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'wish_edit_state.freezed.dart';

// 수정 화면의 상태를 정의하는 State 클래스
@freezed
abstract class WishEditState with _$WishEditState {
  const factory WishEditState({
    WishModel? initialWish, // 수정 전 원본 데이터
    XFile? imageForUpload, // 새로 선택했거나, 기존 이미지를 다운로드한 파일
    @Default(false) bool isTop5,
    @Default(false) bool canSubmit,
    @Default(false) bool isLoading,
  }) = _WishEditState;
}
