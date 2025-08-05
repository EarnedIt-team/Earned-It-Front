import 'package:earned_it/config/design.dart';
import 'package:flutter/material.dart';

class PuzzleView extends StatefulWidget {
  const PuzzleView({super.key});

  @override
  State<PuzzleView> createState() => _PuzzleViewState();
}

class _PuzzleViewState extends State<PuzzleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          spacing: 10,
          children: <Widget>[
            Icon(Icons.extension),
            Text("퍼즐", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: context.middlePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "현재까지 누적 금액",
              style: TextStyle(
                fontSize: context.height(0.02),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "123,345,678원",
              style: TextStyle(fontSize: context.height(0.035)),
            ),
            const SizedBox(height: 10),
            Text(
              "완성한 테마 : 3 / 6 (50%)",
              style: TextStyle(fontSize: context.height(0.015)),
            ),
            Text(
              "획득한 조각 : 3 / 30 (75%)",
              style: TextStyle(fontSize: context.height(0.015)),
            ),
          ],
        ),
      ),
    );
  }
}
