import 'package:earned_it/view_models/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpod import
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

// 1. StatefulWidget을 ConsumerWidget으로 변경
class SettingView extends ConsumerWidget {
  const SettingView({super.key});

  @override
  // 2. build 메서드에 WidgetRef ref 파라미터 추가
  Widget build(BuildContext context, WidgetRef ref) {
    // 현재 테마 모드를 가져옴
    final currentThemeMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          spacing: 10,
          children: <Widget>[
            Icon(Icons.account_circle),
            Text("마이페이지", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        centerTitle: false,
      ),
      // 3. 설정 목록에 더 적합한 ListView로 변경
      body: ListView(
        children: <Widget>[
          // 4. 테마 설정 옵션 ListTile 추가
          ListTile(
            leading: const Icon(Icons.brightness_6_outlined),
            title: const Text('테마'),
            subtitle: Text(_themeModeToString(currentThemeMode)),
            onTap: () {
              showDialog(
                context: context,
                builder:
                    (_) => AlertDialog(
                      title: const Text('테마 선택'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:
                            ThemeMode.values.map((theme) {
                              return RadioListTile<ThemeMode>(
                                title: Text(_themeModeToString(theme)),
                                value: theme,
                                groupValue: currentThemeMode,
                                onChanged: (newTheme) {
                                  if (newTheme != null) {
                                    // 테마 변경 및 저장
                                    ref
                                        .read(themeProvider.notifier)
                                        .changeTheme(newTheme);
                                  }
                                  context.pop();
                                },
                              );
                            }).toList(),
                      ),
                    ),
              );
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.attach_money_outlined),
            title: const Text("월 수익 설정"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              context.push('/setSalary');
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("로그아웃", style: TextStyle(color: Colors.red)),
            onTap: () async {
              // 로그아웃 확인 다이얼로그 추가 (사용자 실수 방지)
              showDialog(
                context: context,
                builder:
                    (ctx) => AlertDialog(
                      title: const Text('로그아웃'),
                      content: const Text('정말로 로그아웃 하시겠습니까?'),
                      actions: [
                        TextButton(
                          child: const Text('취소'),
                          onPressed: () => Navigator.of(ctx).pop(),
                        ),
                        TextButton(
                          child: const Text(
                            '로그아웃',
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () async {
                            await const FlutterSecureStorage().deleteAll();
                            if (context.mounted) {
                              context.go('/login');
                            }
                          },
                        ),
                      ],
                    ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ThemeMode를 사용자 친화적인 문자열로 변환하는 헬퍼 함수
  String _themeModeToString(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return '라이트 모드';
      case ThemeMode.dark:
        return '다크 모드';
      default:
        return '시스템 설정 따름';
    }
  }
}
