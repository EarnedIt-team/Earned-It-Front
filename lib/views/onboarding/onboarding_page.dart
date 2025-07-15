import 'package:earned_it/config/design.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const OnboardingPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // 페이지 내용을 세로 중앙 정렬
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          fit: BoxFit.contain,
          width: context.width(0.7),
          height: context.height(0.35),
          errorBuilder: (
            BuildContext context,
            Object error,
            StackTrace? stackTrace,
          ) {
            return const Icon(
              Icons.image_not_supported,
              size: 100,
              color: Colors.grey,
            );
          },
        ),
        SizedBox(height: context.height(0.05)), // 이미지와 제목 사이 간격
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: context.width(0.07),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: context.height(0.02)), // 제목과 설명 사이 간격
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: context.regularFont,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
