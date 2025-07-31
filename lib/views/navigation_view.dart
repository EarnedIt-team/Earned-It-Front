import 'package:earned_it/config/design.dart';
import 'package:earned_it/views/home/home_view.dart';
import 'package:earned_it/views/puzzle/puzzle_view.dart';
import 'package:earned_it/views/setting/setting_view.dart';
import 'package:earned_it/views/wish/wish_view.dart';
import 'package:flutter/material.dart';

// 네비게이션바
class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Widget> _navigationList = <Widget>[
    const HomeView(),
    const WishView(),
    const PuzzleView(),
    const SettingView(),
  ];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _navigationList.elementAt(_selectedIndex)),
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedIconTheme: IconThemeData(
          size: context.height(0.04),
        ), // 선택된 아이콘 크기
        unselectedIconTheme: IconThemeData(
          size: context.height(0.03),
        ), // 선택되지 않은 아이콘 크기
        selectedLabelStyle: const TextStyle(fontSize: 0),
        unselectedLabelStyle: const TextStyle(fontSize: 0),
      ),
    );
  }
}
