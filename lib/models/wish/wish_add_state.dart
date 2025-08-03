import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'wish_add_state.freezed.dart';

@freezed
abstract class WishAddState with _$WishAddState {
  const factory WishAddState({
    XFile? itemImage,
    @Default(false) bool isTop5,
    @Default(false) bool canSubmit,
  }) = _WishAddState;
}
