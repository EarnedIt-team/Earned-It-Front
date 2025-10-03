import 'package:earned_it/models/wish/wish_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'wish_edit_state.freezed.dart';

// 수정 화면의 상태를 정의하는 State 클래스
@freezed
abstract class WishEditState with _$WishEditState {
  const factory WishEditState({
    WishModel? initialWish, // 수정 전 원본 데이터

    XFile? originalImageSource, // 편집의 기준이 될 원본 이미지
    XFile? itemImage, // 화면에 표시되고 최종 업로드될 이미지 (편집 결과물)
    @Default(false) bool imageHasChanged, // 이미지가 변경되었는지 여부
    @Default(false) bool isTop5,
    @Default(false) bool canSubmit,
    @Default("") String priceError,
    @Default(false) bool isLoading,
  }) = _WishEditState;
}
