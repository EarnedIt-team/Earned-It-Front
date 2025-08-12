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
    return imagePath.isNotEmpty
        ? Column(
          mainAxisAlignment: MainAxisAlignment.start, // 페이지 내용을 하단에 정렬
          children: [
            SizedBox(height: context.height(0.15)),

            Padding(
              padding: EdgeInsets.only(
                left: context.middlePadding,
                right: context.middlePadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: context.width(0.09),
                      fontWeight: FontWeight.bold,
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? primaryGradientEnd
                              : Colors.white,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: context.height(0.01)), // 제목과 설명 사이 간격
                  Text(
                    description,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: context.width(0.04),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            Spacer(),

            SizedBox(
              width: double.infinity,
              height: context.height(0.5),
              child: Image.asset(
                width: double.infinity,
                imagePath,
                fit: BoxFit.cover,
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
            ),
          ],
        )
        : Padding(
          padding: EdgeInsets.symmetric(horizontal: context.middlePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.width(0.08),
                  fontWeight: FontWeight.bold,
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? primaryGradientEnd
                          : Colors.white,
                  height: 1.2,
                ),
              ),
              SizedBox(height: context.height(0.01)), // 제목과 설명 사이 간격
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.width(0.035),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
  }
}
