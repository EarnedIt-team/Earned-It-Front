import 'package:dio/dio.dart';
import 'package:earned_it/models/rank/rank_model.dart';
import 'package:earned_it/models/rank/rank_state.dart';
import 'package:earned_it/services/auth/login_service.dart'; // 에러 핸들링(토큰 재발급)에 필요
import 'package:earned_it/services/rank_service.dart';
import 'package:earned_it/config/toastMessage.dart'; // 예시 에러 메시지용
import 'package:earned_it/config/exception.dart'; // 예시 에러 메시지용
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final rankViewModelProvider = NotifierProvider<RankViewModel, RankState>(
  RankViewModel.new,
);

class RankViewModel extends Notifier<RankState> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  late final RankService _rankService = ref.read(rankServiceProvider);
  late final LoginService _loginService = ref.read(
    loginServiceProvider,
  ); // 토큰 재발급 로직을 위해 추가

  @override
  RankState build() {
    return const RankState();
  }

  /// 랭킹 정보 불러오기
  Future<void> loadRankData(BuildContext context) async {
    // 이미 로딩 중이면 다시 요청하지 않음
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);
    try {
      final accessToken = await _storage.read(key: 'accessToken');
      if (accessToken == null) throw Exception("로그인이 필요합니다.");

      final response = await _rankService.loadRank(accessToken: accessToken);

      // API 응답에서 'myRank'와 'top10' 데이터를 파싱
      final dynamic rawMyRank = response.data['myRank'];
      final List<dynamic> rawTop10List = response.data['top10'];

      final RankModel? myRank =
          rawMyRank != null
              ? RankModel.fromJson(rawMyRank as Map<String, dynamic>)
              : null;

      final List<RankModel> top10List =
          rawTop10List
              .map((json) => RankModel.fromJson(json as Map<String, dynamic>))
              .toList();

      // 상태 업데이트
      state = state.copyWith(
        myRank: myRank,
        top10: top10List,
        isLoading: false,
        lastUpdated: DateTime.now(),
      );
    } on DioException catch (e) {
      if (context.mounted) await _handleApiError(context, e);
    } catch (e) {
      if (context.mounted) _handleGeneralError(context, e);
    } finally {
      // 위젯이 unmount된 경우를 대비하여 확인
      if (ref.exists(rankViewModelProvider)) {
        state = state.copyWith(isLoading: false);
      }
    }
  }

  /// 상태 초기화
  void reset() {
    state = const RankState();
  }

  // --- 에러 처리 헬퍼 메서드 ---
  Future<void> _handleApiError(BuildContext context, DioException e) async {
    state = state.copyWith(isLoading: false);
    if (e.response?.data['code'] == "AUTH_REQUIRED") {
      // ... (토큰 재발급 로직)
    } else {
      _handleGeneralError(context, e.toDisplayString());
    }
  }

  void _handleGeneralError(BuildContext context, Object e) {
    state = state.copyWith(isLoading: false);
    toastMessage(
      context,
      e.toDisplayString(), // exception.dart 에 정의된 확장 함수 사용
      type: ToastmessageType.errorType,
    );
  }
}
