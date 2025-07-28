import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "마이페이지",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                context.push('/setSalary');
              },
              child: const Text("월 수익 설정"),
            ),
            ElevatedButton(
              onPressed: () async {
                await const FlutterSecureStorage().delete(key: 'accessToken');
                await const FlutterSecureStorage().delete(key: 'refreshToken');
                await const FlutterSecureStorage().delete(key: 'userId');
                context.go('/login');
              },
              child: const Text("로그아웃"),
            ),
          ],
        ),
      ),
    );
  }
}
