import 'dart:typed_data';

import 'package:earned_it/config/design.dart';
import 'package:earned_it/view_models/setting/set_profileimage_provider.dart';
import 'package:earned_it/view_models/setting/state_auth_provider.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:earned_it/view_models/wish/wish_provider.dart';
import 'package:earned_it/views/loading_overlay_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

final isOpenEditProfileImage = StateProvider<bool>((ref) => false);

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
    final isImageLoading = ref.watch(
      profileImageLoadingProvider,
    ); // 설정에서 이미지 정보 처리 시,
    final isAuthLoading = ref.watch(
      stateAuthLoadingProvider,
    ); // 설정에서 계정 정보 처리 시,

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

    return Stack(
      children: [
        Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : Colors.white,
            elevation: 0,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.local_mall), label: ''),
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
        if (wishState.isLoading || isImageLoading || isAuthLoading)
          overlayView(),
      ],
    );
  }
}
