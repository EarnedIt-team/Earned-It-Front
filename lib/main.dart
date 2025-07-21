import 'package:earned_it/config/router_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_template.dart';

void main() async {
  await dotenv.load(fileName: 'assets/.env');

  WidgetsFlutterBinding.ensureInitialized(); // 비동기 작업을 실행하기 전에 위젯 시스템을 초기화
  KakaoSdk.init(nativeAppKey: dotenv.get('KAKAO_API_KEY')); // 카카오 초기화
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
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Mainfonts',
        brightness: Brightness.light,
      ),
      routerConfig: routes,
    );
  }
}
