import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  // 화면 너비 가져오기
  double get screenWidth => MediaQuery.of(this).size.width;

  // 화면 높이 가져오기
  double get screenHeight => MediaQuery.of(this).size.height;

  // 화면 너비의 특정 비율
  double width(double percent) => screenWidth * percent;

  // 화면 높이의 특정 비율
  double height(double percent) => screenHeight * percent;

  double get middleFont => screenWidth * 0.08;

  // // 패딩 (예: const EdgeInsets.symmetric(horizontal: context.width(0.05)))
  // EdgeInsets get horizontalPadding =>
  //     EdgeInsets.symmetric(horizontal: screenWidth * 0.05);
  // EdgeInsets get verticalPadding =>
  //     EdgeInsets.symmetric(vertical: screenHeight * 0.02);

  // // 텍스트 스케일 팩터 (접근성 설정에 따라 폰트 크기 조절)
  // double get textScaleFactor => MediaQuery.of(this).textScaleFactor;
}
