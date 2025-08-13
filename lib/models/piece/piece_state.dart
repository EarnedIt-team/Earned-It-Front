import 'package:earned_it/models/piece/piece_info_model.dart';
import 'package:earned_it/models/piece/theme_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'piece_state.freezed.dart';

@freezed
abstract class PieceState with _$PieceState {
  const factory PieceState({
    /// 처리 여부
    @Default(false) bool isLoading,

    /// 전체 테마 개수
    @Default(0) int themeCount,

    /// 현재 완성한 테마 개수
    @Default(0) int completedThemeCount,

    /// 전체 조각 개수
    @Default(0) int totalPieceCount,

    /// 현재 획득한 조각 개수
    @Default(0) int completedPieceCount,

    /// 획득한 조각의 가치
    @Default(0) int totalAccumulatedValue,

    /// 가장 최근에 획득한 조각
    PieceInfoModel? recentlyPiece,

    /// 선택한 조각
    PieceInfoModel? selectedPiece,

    /// 현재까지 획득한 조각 리스트 (퍼즐 View)
    @Default([]) List<ThemeModel> pieces,
  }) = _PieceState;
}
