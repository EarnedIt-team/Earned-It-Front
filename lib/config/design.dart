import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension ContextExtension on BuildContext {
  // 화면 너비 가져오기
  double get screenWidth => MediaQuery.of(this).size.width;

  // 화면 높이 가져오기
  double get screenHeight => MediaQuery.of(this).size.height;

  // 화면 너비의 특정 비율
  double width(double percent) => screenWidth * percent;

  // 화면 높이의 특정 비율
  double height(double percent) => screenHeight * percent;

  // 작은 폰트 크기
  double get smallFont => screenWidth * 0.03;

  // 보통 폰트 크기
  double get regularFont => screenWidth * 0.04;

  // 중간 폰트 크기
  double get middleFont => screenWidth * 0.08;

  // 중간 패딩 크기
  double get middlePadding => screenHeight * 0.02;

  // 로그인 화면 패딩 크기
  double get loginPadding => screenHeight * 0.04;

  // 버튼 패딩 크기
  double get buttonPadding => screenHeight * 0.015;

  // 성공 컬러
  Color get successColor => Colors.green;

  // 테마에 맞는 그림자 색상
  Color get shadowColor {
    // 현재 테마의 밝기를 확인
    final isDarkMode = Theme.of(this).brightness == Brightness.dark;

    // 다크 모드일 때는 약간 밝은 그림자를, 라이트 모드일 때는 어두운 그림자를 반환
    return isDarkMode
        ? Colors.white.withValues(alpha: 0.15) // 다크 모드용 그림자
        : const Color.fromARGB(66, 125, 125, 125); // 라이트 모드용 그림자
  }

  // // 패딩 (예: const EdgeInsets.symmetric(horizontal: context.width(0.05)))
  // EdgeInsets get horizontalPadding =>
  //     EdgeInsets.symmetric(horizontal: screenWidth * 0.05);
  // EdgeInsets get verticalPadding =>
  //     EdgeInsets.symmetric(vertical: screenHeight * 0.02);

  // // 텍스트 스케일 팩터 (접근성 설정에 따라 폰트 크기 조절)
  // double get textScaleFactor => MediaQuery.of(this).textScaleFactor;
}

// 사용할 메인 컬러
const Color primaryColor = Color(0xFFFFB73D);

// ==================================
// 라이트 모드 테마
// ==================================
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Mainfonts',
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      // 1. 상태 바 아이콘을 '어둡게' 설정 (정상 표시)
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,

      // 2. 하단 내비게이션 바 배경 및 아이콘 설정
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
    elevation: 0,
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
  ),
);

// ==================================
// 다크 모드 테마
// ==================================
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Mainfonts',
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      // 1. 상태 바 아이콘을 '밝게' 설정 (정상 표시)
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,

      // 2. 하단 내비게이션 바 배경 및 아이콘 설정
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
    elevation: 0,
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
  ),
);
