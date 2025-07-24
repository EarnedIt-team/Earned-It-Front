import 'package:flutter/material.dart';

// 로딩 오버레이
Widget overlayView() {
  return Positioned.fill(
    child: Container(
      color: Colors.black.withValues(alpha: 0.5), // 불투명도 50% 검은색 배경
      child: const Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    ),
  );
}
