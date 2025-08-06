import 'package:earned_it/models/user/user_state.dart';
import 'package:earned_it/models/wish/wish_model.dart';
import 'package:earned_it/services/auth/user_service.dart';
import 'package:earned_it/services/wish_service.dart';
import 'package:earned_it/view_models/wish/wish_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final userProvider = NotifierProvider<UserNotifier, UserState>(
  UserNotifier.new,
);

class UserNotifier extends Notifier<UserState> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  UserState build() {
    // Notifier가 처음 생성될 때의 초기 상태를 반환합니다.
    // UserState의 기본값(@Default)들이 사용됩니다.
    return const UserState();
  }

  /// 사용자 정보를 불러옵니다.
  Future<void> loadUser() async {
    try {
      final String? accessToken = await _storage.read(key: 'accessToken');

      final userService = ref.read(userServiceProvider);
      final response = await userService.loadUserInfo(accessToken!);
      final responseData = response.data as Map<String, dynamic>;

      state = state.copyWith(
        // 월 수익
        monthlySalary:
            response.data["userInfo"]["amount"] ?? state.monthlySalary,
        // 월 수익 날짜
        payday: response.data["userInfo"]["payday"] ?? state.payday,
        // 초당 수익
        earningsPerSecond:
            response.data["userInfo"]["amountPerSec"] ??
            state.earningsPerSecond,
        // 수익 설정 여부
        isearningsPerSecond:
            response.data["userInfo"]["hasSalary"] ?? state.isearningsPerSecond,
      );

      // 위시리스트(Star) 관련 데이터는 WishNotifier에 업데이트를 위임합니다.
      ref
          .read(wishViewModelProvider.notifier)
          .updateStarWishesFromServer(responseData);

      print("유저 저장 완료 ${responseData}");
    } catch (e) {
      print("유저 정보 불러오기 에러 $e");
    }
  }

  /// 사용자 정보를 불러옵니다.
  Future<void> loadProfile() async {
    try {
      final String? accessToken = await _storage.read(key: 'accessToken');

      final userService = ref.read(userServiceProvider);
      final response = await userService.loadProfile(accessToken!);
      final responseData = response.data as Map<String, dynamic>;

      state = state.copyWith(
        // 프로필 사진
        profileImage: response.data["profileImage"] ?? state.profileImage,

        // 닉네임
        name: response.data["nickname"] ?? state.name,

        // 월 수익
        monthlySalary: response.data["monthlySalary"] ?? state.monthlySalary,
      );

      print("프로필 저장 완료 ${responseData}");
    } catch (e) {
      print("프로필 정보 불러오기 에러 $e");
    }
  }

  /// 유저 정보를 부분적으로 또는 전체적으로 갱신하는 메소드입니다.
  /// 필요한 파라미터만 선택적으로 전달하여 사용할 수 있습니다.
  void loadUserInfo({
    int? amount,
    double? amountPerSec,
    bool? hasSalary,
    int? payday,
    bool? hasAgreedTerm,
    // 추후, 위시리스트 등이 포함될 수 있습니다.
  }) {
    state = state.copyWith(
      // 전달된 값이 null이 아니면 새로운 값으로, null이면 기존 상태값을 유지합니다.
      monthlySalary: amount ?? state.monthlySalary,
      payday: payday ?? state.payday,
      earningsPerSecond: amountPerSec ?? state.earningsPerSecond,
      isearningsPerSecond: hasSalary ?? state.isearningsPerSecond,
      hasAgreedTerm: hasAgreedTerm ?? state.hasAgreedTerm,
    );
  }

  /// 로컬에서 닉네임 정보를 업데이트하는 메소드
  void updateNickName({required String nickName}) {
    state = state.copyWith(name: nickName);
  }

  /// 급여 정보를 업데이트하는 메소드
  void updateSalaryInfo({
    required int newMonthlySalary,
    required int newPayday,
    required double newEarningsPerSecond,
  }) {
    // copyWith를 사용하여 상태를 불변성(immutable)을 유지하며 업데이트합니다.
    state = state.copyWith(
      monthlySalary: newMonthlySalary,
      payday: newPayday,
      earningsPerSecond: newEarningsPerSecond,
      isearningsPerSecond: true, // 수익 정보가 설정되었음을 표시
    );
  }

  /// 상태를 초기화하는 메소드
  void reset() {
    state = const UserState(); // 다시 초기 상태로 되돌립니다.
  }
}
