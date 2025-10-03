import 'dart:io';

import 'package:dio/dio.dart';
import 'package:earned_it/config/design.dart';
import 'package:earned_it/config/router_config.dart';
import 'package:earned_it/services/rest_client.dart';
import 'package:earned_it/view_models/theme_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

late RestClient restClient;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
late AndroidNotificationChannel channel;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/.env');
  KakaoSdk.init(nativeAppKey: dotenv.env['KAKAO_API_KEY']);

  final dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['BASE_URL']!,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  restClient = RestClient(dio);

  await initializeDateFormatting('ko', null);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // iOS 포그라운드 알림 설정
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  // --- FCM 관련 로직을 이곳으로 모으고 순서를 정리합니다 ---
  // 1. FirebaseMessaging 인스턴스 생성
  if (Platform.isIOS) {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // 2. (iOS 필수) 사용자에게 알림 권한 요청
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    Future.delayed(Duration(seconds: 2));

    // 3. (iOS 필수) APNs 토큰이 준비될 때까지 기다림
    await messaging.getAPNSToken();

    // 4. FCM 토큰 가져오기
    // final fcmToken = await messaging.getToken();
    // print('FCM Token: $fcmToken');
  }

  // 5. 모든 준비가 끝난 후 토픽 구독
  try {
    await FirebaseMessaging.instance.subscribeToTopic('global_notifications');
    print('Successfully subscribed to topic: global_notifications');
  } catch (e) {
    print('Failed to subscribe to topic: $e');
  }
  // --- FCM 로직 정리 끝 ---

  // 안드로이드 포그라운드 알림을 위한 로컬 알림 설정
  channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(channel);

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // 포그라운드 메시지 리스너
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    // Android이고 알림 내용이 있을 때만 로컬 알림 표시
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: '@mipmap/ic_launcher',
          ),
        ),
      );
      print('Foreground message received & local notification shown');
    }
  });

  // 백그라운드 메시지 탭 리스너
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
    if (message?.notification != null) {
      print(message!.notification!.title);
      print(message.notification!.body);
      print("background message clicked");
    }
  });

  // 종료 상태 메시지 탭 리스너
  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    if (message?.notification != null) {
      print(message!.notification!.title);
      print(message.notification!.body);
      print("terminated message clicked");
    }
  });

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeMode themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      routerConfig: routes,
    );
  }
}
