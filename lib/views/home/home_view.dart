import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Earned !t")),
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
