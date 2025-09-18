import 'package:dio/dio.dart';
import 'package:earned_it/config/design.dart';
import 'package:earned_it/config/router_config.dart';
import 'package:earned_it/services/rest_client.dart';
import 'package:earned_it/view_models/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart'; // 최신 패키지명으로 수정

late RestClient restClient;

void main() async {
  // main 함수에서 비동기 작업을 안전하게 실행하기 위한 설정
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: 'assets/.env');

  // 카카오 SDK 초기화
  KakaoSdk.init(nativeAppKey: dotenv.env['KAKAO_API_KEY']);

  final dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['BASE_URL']!,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  // 개발 중 로그 확인을 위한 인터셉터 추가
  dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));

  restClient = RestClient(dio);

  await initializeDateFormatting('ko', null);
  runApp(const ProviderScope(child: MyApp()));
}

// 1. StatelessWidget -> ConsumerWidget으로 변경
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  // 2. ConsumerWidget의 build 메서드는 WidgetRef를 파라미터로 받습니다.
  Widget build(BuildContext context, WidgetRef ref) {
    // themeProvider를 watch하여 테마 변경을 실시간으로 감지
    final ThemeMode themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      // 3. Provider에서 가져온 themeMode 변수를 연결
      themeMode: themeMode,
      routerConfig: routes,
    );
  }
}
