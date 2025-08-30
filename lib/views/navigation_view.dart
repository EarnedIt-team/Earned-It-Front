import 'package:earned_it/config/design.dart';
import 'package:earned_it/models/user/user_state.dart';
import 'package:earned_it/view_models/checkedIn_provider.dart';
import 'package:earned_it/view_models/piece_provider.dart';
import 'package:earned_it/view_models/setting/set_profileimage_provider.dart';
import 'package:earned_it/view_models/setting/state_auth_provider.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:earned_it/view_models/wish/wish_order_provider.dart';
import 'package:earned_it/view_models/wish/wish_provider.dart';
import 'package:earned_it/views/checkedIn_Modal.dart';
import 'package:earned_it/views/loading_overlay_view.dart';
import 'package:earned_it/views/puzzle/piece_detail_modal.dart';
import 'package:earned_it/views/wish/wish_order_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final isOpenEditProfileImage = StateProvider<bool>((ref) => false);
final isOpenReSign = StateProvider<bool>((ref) => false);
final isAgreedReSign = StateProvider<bool>((ref) => false);
final isOpenCheckedIn = StateProvider<bool>((ref) => false);
final hasCheckedIn = StateProvider<bool>(
  (ref) => false,
); // 사용자가 오늘은 더이상 출석체크를 원치 않을 때,
// 조각을 선택해서 상세정보를 요청하는가?
final isOpenPieceInfo = StateProvider<bool>((ref) => false);
final isOpenSwapList = StateProvider<bool>(
  (ref) => false,
); // Star 위시리스트 순서 변경 modal 여부

class NavigationView extends ConsumerWidget {
  final Widget child;

  const NavigationView({super.key, required this.child});

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/wish')) {
      return 1;
    } else if (location.startsWith('/puzzle')) {
      return 2;
    } else if (location.startsWith('/setting')) {
      return 3;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/wish');
        break;
      case 2:
        context.go('/puzzle');
        break;
      case 3:
        context.go('/setting');
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishState = ref.watch(wishViewModelProvider);
    final puzzleState = ref.watch(pieceProvider);
    final userState = ref.watch(userProvider);
    final isImageLoading = ref.watch(
      profileImageLoadingProvider,
    ); // 설정에서 이미지 정보 처리 시,
    final isAuthLoading = ref.watch(
      stateAuthLoadingProvider,
    ); // 설정에서 계정 정보 처리 시,

    /// 출석체크
    ref.listen<UserState>(userProvider, (previous, next) async {
      // 1. async 추가
      final String currentLocation = GoRouterState.of(context).uri.toString();
      final isCheckedIn = next.isCheckedIn;

      // 조건 1: 이미 출석체크를 했으면 모달을 띄우지 않음
      if (isCheckedIn) return;

      // 👇 2. 오늘 하루 보지 않기를 선택했는지 확인하는 로직 추가
      final prefs = await SharedPreferences.getInstance();
      final lastHiddenDate = prefs.getString('hideCheckedInModalDate');
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final hasHiddenToday = lastHiddenDate == today;

      // 최종 조건: 홈 화면이고, 출석체크를 안했고, 오늘 하루 보지 않기를 선택하지 않았을 때
      if (currentLocation == '/home' && !isCheckedIn && !hasHiddenToday) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          enableDrag: false,
          isDismissible: false,
          builder: (context) => const CheckedInModal(),
        );
      }
    });

    /// 출석체크
    ref.listen<bool>(isOpenCheckedIn, (previous, next) {
      if (next == true) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          enableDrag: false,
          isDismissible: false,
          // 👇 builder에서 새로 만든 위젯을 반환합니다.
          builder: (context) => const CheckedInModal(),
        ).whenComplete(() {
          ref.read(isOpenCheckedIn.notifier).state = false;
        });
        ;
      }
    });

    /// Star 위시리스트 순서 변경 Modal
    ref.listen<bool>(isOpenSwapList, (previous, next) {
      if (next == true) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          // 👇 builder에서 새로 만든 위젯을 반환합니다.
          builder: (context) => const WishOrderModal(),
        ).whenComplete(() {
          ref.read(isOpenSwapList.notifier).state = false;
          ref.read(wishOrderViewModelProvider.notifier).reset();
        });
        ;
      }
    });

    /// 조각 상세정보
    ref.listen<bool>(isOpenPieceInfo, (previous, next) {
      if (next == true) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          // 👇 builder에서 새로 만든 위젯을 반환합니다.
          builder:
              (context) => PieceDetailModal(
                pieceInfo: ref.read(pieceProvider).selectedPiece!,
              ),
        ).whenComplete(() {
          ref.read(isOpenPieceInfo.notifier).state = false;
        });
        ;
      }
    });

    ref.listen<bool>(isOpenEditProfileImage, (previous, next) {
      if (next == true) {
        showModalBottomSheet(
          context: context,
          // ... (BottomSheet UI는 동일)
          builder: (BuildContext context) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.all(context.middlePadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                      height: context.height(0.06),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                        ),
                        // 👇 2. onPressed에서 ViewModel의 메서드 호출
                        onPressed: () {
                          ref
                              .read(profileImageViewModelProvider)
                              .pickAndEditImage(context);
                        },
                        child: const Text(
                          "앨범에서 선택",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      height: context.height(0.06),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          ref
                              .read(profileImageViewModelProvider)
                              .deleteProfileImage(context);
                        },
                        child: const Text(
                          "기본 이미지로 변경",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ).whenComplete(() {
          ref.read(isOpenEditProfileImage.notifier).state = false;
        });
      }
    });

    // ref.listen을 사용하여 회원 탈퇴 BottomSheet를 띄웁니다.
    ref.listen<bool>(isOpenReSign, (previous, next) {
      if (next == true) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            // BottomSheet 내부의 상태(체크박스)를 관리하기 위해 StatefulBuilder 사용
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
                return SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(context.middlePadding),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // 1. 제목
                        const Text(
                          "회원 탈퇴 안내",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // 2. 내용 (요약된 탈퇴 정책)
                        Text(
                          '• 탈퇴 시, 계정은 30일간 보관되며 이 기간 내에 다시 로그인하면 계정이 복구됩니다.\n\n'
                          '• 30일이 지나면 계정 정보는 복구할 수 없게 되며, 동일한 이메일로 재가입이 가능합니다.\n\n'
                          '• 모든 개인 정보는 관련 법령에 따라 3년 후 완전히 삭제됩니다.',
                          style: TextStyle(
                            height: 1.5,
                            fontSize: context.width(0.035),
                          ), // 줄 간격 조절
                        ),
                        const SizedBox(height: 16),

                        // 3. 동의 체크박스
                        CheckboxListTile(
                          title: Text(
                            "위 내용을 모두 확인했으며, 회원 탈퇴에 동의합니다.",
                            style: TextStyle(
                              fontSize: context.width(0.035),
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          value: ref.read(isAgreedReSign.notifier).state,
                          onChanged: (bool? value) {
                            // StatefulBuilder의 setState를 호출하여 BottomSheet 내부만 갱신
                            setModalState(() {
                              ref.read(isAgreedReSign.notifier).state =
                                  value ?? false;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          activeColor: primaryColor,
                        ),
                        const SizedBox(height: 24),

                        // 4. 회원 탈퇴 버튼
                        SizedBox(
                          width: double.infinity,
                          height: context.height(0.06),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              // disabledBackgroundColor: Colors.grey.shade400,
                            ),
                            // isAgreed 값에 따라 버튼 활성화/비활성화
                            onPressed:
                                ref.read(isAgreedReSign.notifier).state
                                    ? () {
                                      context.pop();
                                      ref
                                          .read(stateAuthViewModelProvider)
                                          .resign(context);
                                    }
                                    : null,
                            child: Text(
                              "회원 탈퇴",
                              style: TextStyle(
                                color:
                                    ref.read(isAgreedReSign.notifier).state
                                        ? Colors.white
                                        : Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ).whenComplete(() {
          // BottomSheet가 닫힐 때 Provider 상태를 false로 변경
          ref.read(isOpenReSign.notifier).state = false;
          ref.read(isAgreedReSign.notifier).state = false;
        });
      }
    });

    return Stack(
      children: [
        Scaffold(
          body: child,
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), // 왼쪽 상단 모서리 둥글게
              topRight: Radius.circular(30), // 오른쪽 상단 모서리 둥글게
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor:
                  Theme.of(context).brightness == Brightness.dark
                      ? lightDarkColor
                      : Colors.white,
              fixedColor: primaryGradientEnd,
              unselectedItemColor: Colors.grey,
              elevation: 0,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: ''),
                BottomNavigationBarItem(
                  icon: Icon(Icons.local_mall),
                  label: '',
                ),
                BottomNavigationBarItem(icon: Icon(Icons.extension), label: ''),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: '',
                ),
              ],
              selectedIconTheme: IconThemeData(size: context.height(0.04)),
              unselectedIconTheme: IconThemeData(size: context.height(0.03)),
              selectedLabelStyle: const TextStyle(fontSize: 0),
              unselectedLabelStyle: const TextStyle(fontSize: 0),
              currentIndex: _calculateSelectedIndex(context),
              onTap: (index) => _onItemTapped(index, context),
            ),
          ),
        ),
        if (wishState.isLoading ||
            isImageLoading ||
            isAuthLoading ||
            puzzleState.isLoading)
          overlayView(),
      ],
    );
  }
}
