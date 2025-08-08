import 'dart:typed_data';

import 'package:earned_it/config/design.dart';
import 'package:earned_it/view_models/wish/wish_provider.dart';
import 'package:earned_it/views/loading_overlay_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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

    ref.listen<bool>(isOpenEditProfileImage, (previous, next) {
      if (next == true) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.all(context.middlePadding),
                child: Row(
                  children: [
                    // 👇 1. Column을 Expanded로 감싸서 가로 공간을 모두 차지하도록 함
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: double.infinity,
                            height: context.height(0.06),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                              ),
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder:
                                //         (BuildContext context) =>
                                //             ProImageEditor.asset(
                                //               '',
                                //               callbacks:
                                //                   ProImageEditorCallbacks(
                                //                     onImageEditingComplete: (
                                //                       Uint8List bytes,
                                //                     ) async {
                                //                       print("이미지 수정 완료");
                                //                     },
                                //                   ),
                                //             ),
                                //   ),
                                // );
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
                                // TODO: 기본 이미지로 변경하는 로직
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
        if (wishState.isLoading) overlayView(),
      ],
    );
  }
}
