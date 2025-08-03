import 'package:earned_it/config/design.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationView extends StatelessWidget {
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
    // 기본값은 홈
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
  Widget build(BuildContext context) {
    return Scaffold(
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
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: ''),
        ],
        selectedIconTheme: IconThemeData(
          size: context.height(0.04),
        ), // 선택된 아이콘 크기
        unselectedIconTheme: IconThemeData(
          size: context.height(0.03),
        ), // 선택되지 않은 아이콘 크기
        selectedLabelStyle: const TextStyle(fontSize: 0),
        unselectedLabelStyle: const TextStyle(fontSize: 0),
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
      ),
    );
  }
}
