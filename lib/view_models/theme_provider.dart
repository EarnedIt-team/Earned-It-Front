import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Notifier 클래스 정의
class ThemeNotifier extends Notifier<ThemeMode> {
  late SharedPreferences _prefs;

  @override
  ThemeMode build() {
    // 앱 시작 시 저장된 테마 로드
    _loadTheme();
    // 로드 전 기본값
    return ThemeMode.system;
  }

  // 저장된 테마를 로드하는 내부 함수
  void _loadTheme() async {
    _prefs = await SharedPreferences.getInstance();
    final themeStr = _prefs.getString('themeMode') ?? 'system';
    state = _stringToThemeMode(themeStr);
  }

  // 테마를 변경하고 기기에 저장하는 함수
  void changeTheme(ThemeMode themeMode) {
    _prefs.setString('themeMode', themeMode.name);
    state = themeMode;
  }

  // 문자열을 ThemeMode enum으로 변환
  ThemeMode _stringToThemeMode(String themeStr) {
    switch (themeStr) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}

// Provider 생성
final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  ThemeNotifier.new,
);
