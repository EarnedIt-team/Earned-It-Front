import 'package:earned_it/models/piece/piece_info_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'piece_state.freezed.dart';

@freezed
abstract class PieceState with _$PieceState {
  const factory PieceState({
    // 처리 여부
    @Default(false) bool isLoading,

    // 가장 최근에 획득한 조각
    PieceInfoModel? recentlyPiece,

    /// 현재까지 획득한 조각
    @Default([]) List<PieceInfoModel> pieces,
  }) = _PieceState;
}
