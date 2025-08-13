import 'package:dio/dio.dart';
import 'package:earned_it/config/exception.dart';
import 'package:earned_it/config/toastMessage.dart';
import 'package:earned_it/models/checkedIn/checkedIn_model.dart';
import 'package:earned_it/models/checkedIn/checkedIn_state.dart';
import 'package:earned_it/services/auth/login_service.dart';
import 'package:earned_it/services/checkin_service.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final checkedInViewModelProvider =
    NotifierProvider.autoDispose<CheckedInViewModel, CheckedInState>(
      CheckedInViewModel.new,
    );

class CheckedInViewModel extends AutoDisposeNotifier<CheckedInState> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  late final CheckinService _checkinService;
  late final LoginService _loginService;

  @override
  CheckedInState build() {
    _checkinService = ref.read(checkinServiceProvider);
    _loginService = ref.read(loginServiceProvider);
    return const CheckedInState();
  }

  /// 보상 후보 가져오기
  Future<void> getCandidates(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    try {
      final accessToken = await _storage.read(key: 'accessToken');
      if (accessToken == null) throw Exception("로그인이 필요합니다.");

      final response = await _checkinService.getCandidateList(
        accessToken: accessToken,
      );

      final List<dynamic> rawCandidatesList = response.data["candidates"];
      final List<CheckedinModel> candidatesList =
          rawCandidatesList
              .map(
                (json) => CheckedinModel.fromJson(json as Map<String, dynamic>),
              )
              .toList();

      state = state.copyWith(
        rewardToken: response.data["rewardToken"],
        candidatesCheckedInList: candidatesList,
        isLoading: false,
      );
    } on DioException catch (e) {
      if (context.mounted) _handleApiError(context, e);
    } catch (e) {
      if (context.mounted) _handleGeneralError(context, e);
    } finally {
      if (ref.exists(checkedInViewModelProvider)) {
        state = state.copyWith(isLoading: false);
      }
    }
  }

  /// 보상 선택
  Future<void> selectGift(BuildContext context, int index) async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true, selectedIndex: index);
    await Future.delayed(const Duration(seconds: 2));

    try {
      final candidates = state.candidatesCheckedInList;
      if (index < 0 || index >= candidates.length) {
        throw Exception("선택한 보상이 유효하지 않습니다.");
      }

      final selectedItem = candidates[index];
      final rewardName = selectedItem.name ?? '알 수 없는 보상';

      final accessToken = await _storage.read(key: 'accessToken');
      if (accessToken == null) throw Exception("로그인이 필요합니다.");

      final response = await _checkinService.selectDailyCheck(
        accessToken: accessToken,
        rewardToken: state.rewardToken!,
        selectedItemId: selectedItem.itemId!,
      );

      ref.read(userProvider.notifier).updateCheckIn(isCheckIn: true);
      state = state.copyWith(reward: rewardName);
    } on DioException catch (e) {
      if (context.mounted) _handleApiError(context, e);
    } catch (e) {
      if (context.mounted) _handleGeneralError(context, e);
    } finally {
      if (ref.exists(checkedInViewModelProvider)) {
        state = state.copyWith(isLoading: false);
      }
    }
  }

  void reset() {
    state = const CheckedInState();
  }

  Future<void> hideForToday() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final todayString = DateFormat('yyyy-MM-dd').format(DateTime.now());
      await prefs.setString('hideCheckedInModalDate', todayString);
    } catch (e) {
      print('SharedPreferences 저장 오류: $e');
    }
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
    toastMessage(context, e.toString(), type: ToastmessageType.errorType);
  }
}
