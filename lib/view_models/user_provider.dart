import 'package:earned_it/models/user/user_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = NotifierProvider<UserNotifier, UserState>(
  UserNotifier.new,
);

class UserNotifier extends Notifier<UserState> {
  @override
  UserState build() {
    // Notifier가 처음 생성될 때의 초기 상태를 반환합니다.
    // UserState의 기본값(@Default)들이 사용됩니다.
    return const UserState();
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
