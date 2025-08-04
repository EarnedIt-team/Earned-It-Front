import 'package:earned_it/config/design.dart';
import 'package:earned_it/view_models/wish/wish_provider.dart';
import 'package:earned_it/views/loading_overlay_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// 2. StatelessWidget -> ConsumerWidget으로 변경
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
  // 3. build 메서드에 WidgetRef ref 파라미터 추가
  Widget build(BuildContext context, WidgetRef ref) {
    // 4. ref.watch를 통해 wishState를 가져옴
    final wishState = ref.watch(wishViewModelProvider);

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
