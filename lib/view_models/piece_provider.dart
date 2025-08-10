import 'package:dio/dio.dart';
import 'package:earned_it/models/piece/piece_info_model.dart';
import 'package:earned_it/models/piece/piece_state.dart';
import 'package:earned_it/services/piece_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:toastification/toastification.dart';

final pieceProvider = NotifierProvider<PieceNotifier, PieceState>(
  PieceNotifier.new,
);

class PieceNotifier extends Notifier<PieceState> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  late final PieceService _pieceService;

  @override
  PieceState build() {
    _pieceService = ref.read(pieceServiceProvider);
    return const PieceState();
  }

  /// 가장 최근에 획득한 조각 불러오기
  Future<void> loadRecentPiece(BuildContext context) async {
    try {
      state = state.copyWith(isLoading: true);
      final accessToken = await _storage.read(key: 'accessToken');
      if (accessToken == null) throw Exception("로그인이 필요합니다.");

      final response = await _pieceService.loadRecentPiece(
        accessToken: accessToken,
      );

      final PieceInfoModel recentlyPiece = PieceInfoModel.fromJson(
        response.data as Map<String, dynamic>,
      );
      state = state.copyWith(recentlyPiece: recentlyPiece);

      state = state.copyWith(isLoading: false);
    } on DioException catch (e) {
      if (context.mounted) _handleApiError(context, e);
    } catch (e) {
      if (context.mounted) _handleGeneralError(context, e);
    } finally {
      if (ref.exists(pieceServiceProvider)) {
        state = state.copyWith(isLoading: false);
      }
    }
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

  // --- 에러 처리 헬퍼 메서드 ---
  Future<void> _handleApiError(BuildContext context, DioException e) async {
    state = state.copyWith(isLoading: false);
    if (e.response?.data['code'] == "AUTH_REQUIRED") {
      // ... (토큰 재발급 로직)
    } else {
      _handleGeneralError(context, e);
    }
  }

  void _handleGeneralError(BuildContext context, Object e) {
    state = state.copyWith(isLoading: false);
    toastification.show(
      context: context,
      title: Text(e.toString()),
      autoCloseDuration: const Duration(seconds: 3),
    );
  }
}
