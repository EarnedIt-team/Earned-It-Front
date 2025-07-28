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
        title: Text("퍼즐", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
    );
  }
}
