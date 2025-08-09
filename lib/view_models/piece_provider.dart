import 'package:earned_it/models/piece/piece_info_model.dart';
import 'package:earned_it/models/piece/piece_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final pieceProvider = NotifierProvider<PieceNotifier, PieceState>(
  PieceNotifier.new,
);

class PieceNotifier extends Notifier<PieceState> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  PieceState build() {
    return const PieceState();
  }

  /// 서버 응답의 데이터를 받아 로컬에서 가장 최근에 획득한 조각을 업데이트 하는 메소드
  void updateRecentlyPiece(Map<String, dynamic> data) {
    final rawPieceInfo = data["pieceInfo"];

    if (rawPieceInfo != null) {
      // 2. null이 아닐 경우에만 PieceInfoModel로 파싱합니다.
      final PieceInfoModel recentlyPiece = PieceInfoModel.fromJson(
        rawPieceInfo as Map<String, dynamic>,
      );
      state = state.copyWith(recentlyPiece: recentlyPiece);
    } else {
      // 3. null일 경우에는 상태의 recentlyPiece도 null로 설정하여 비워줍니다.
      state = state.copyWith(recentlyPiece: null);
    }
  }

  /// 상태를 초기화하는 메소드
  void reset() {
    state = const PieceState(); // 다시 초기 상태로 되돌립니다.
  }
}
