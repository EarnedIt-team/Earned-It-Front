import 'package:flutter/material.dart';

class WishSearchView extends StatefulWidget {
  const WishSearchView({super.key});

  @override
  State<WishSearchView> createState() => _WishSearchViewState();
}

class _WishSearchViewState extends State<WishSearchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const TextField(), centerTitle: false),
    );
  }
}
