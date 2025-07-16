import 'package:earned_it/config/router_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    // riverpod 동작을 위한 최상단 배치 (ProviderScope)
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // go_router 사용을 위함
    return MaterialApp.router(
      debugShowCheckedModeBanner: false, // 디버그 배너
      // 라이트 모드
      theme: ThemeData(fontFamily: 'Mainfonts', brightness: Brightness.light),
      routerConfig: routes,
    );
  }
}
