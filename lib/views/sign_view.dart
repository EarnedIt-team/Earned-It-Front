import 'package:flutter/material.dart';

class SignView extends StatefulWidget {
  const SignView({super.key});

  @override
  State<SignView> createState() => _SignViewState();
}

class _SignViewState extends State<SignView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("회원가입")));
  }
}
