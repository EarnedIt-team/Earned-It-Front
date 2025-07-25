import 'package:flutter/material.dart';
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
      appBar: AppBar(title: const Text("메인화면")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.push('/setSalary');
          },
          child: const Text("월 수익 설정"),
        ),
      ),
    );
  }
}
