import 'package:flutter/material.dart';

class WishView extends StatefulWidget {
  const WishView({super.key});

  @override
  State<WishView> createState() => _WishViewState();
}

class _WishViewState extends State<WishView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "위시리스트",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
    );
  }
}
