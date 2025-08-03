import 'package:earned_it/config/design.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        title: const Row(
          spacing: 10,
          children: <Widget>[
            Icon(Icons.local_mall),
            Text("위시리스트", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              context.push('/addWish');
            },
            icon: const Icon(Icons.add_circle, color: primaryColor),
          ),
        ],
        actionsPadding: const EdgeInsets.symmetric(horizontal: 15),
      ),
    );
  }
}
