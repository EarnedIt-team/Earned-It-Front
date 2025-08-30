import 'package:earned_it/config/design.dart';
import 'package:earned_it/view_models/setting/state_auth_provider.dart';
import 'package:earned_it/view_models/theme_provider.dart';
import 'package:earned_it/view_models/user_provider.dart';
import 'package:earned_it/view_models/wish/wish_provider.dart';
import 'package:earned_it/views/navigation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingView extends ConsumerStatefulWidget {
  const SettingView({super.key});

  @override
  ConsumerState<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends ConsumerState<SettingView> {
  @override
  void initState() {
    super.initState();
    // 👇 2. initState에서 로딩 상태를 제어하도록 수정
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(userProvider.notifier).loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentThemeMode = ref.watch(themeProvider);
    final userState = ref.watch(userProvider);
    final numberFormat = NumberFormat('#,###', 'ko_KR');

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Row(
          children: <Widget>[
            Icon(Icons.account_circle),
            SizedBox(width: 10), // spacing -> SizedBox로 수정
            Text("마이페이지", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        centerTitle: false,
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.middlePadding),
        child: ListView(
          children: <Widget>[
            SizedBox(height: context.height(0.015)),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              height: context.height(0.2),
              decoration: BoxDecoration(
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? lightDarkColor
                        : Colors.white,
                border: Border.all(width: 1, color: primaryGradientStart),
                borderRadius: BorderRadius.circular(context.width(0.03)),
              ),

              child: Row(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: context.width(0.3),
                    height: context.height(0.2),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(context.width(0.03)),
                    ),
                    child:
                        // 프로필 이미지가 존재 할 경우,
                        userState.profileImage.isNotEmpty
                            ? ClipRRect(
                              borderRadius: BorderRadius.circular(
                                context.width(0.03),
                              ),
                              child: Image.network(
                                userState.profileImage,
                                fit: BoxFit.cover,
                                width: context.width(0.2),
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey.shade200,
                                    child: const Icon(
                                      Icons.image_not_supported_outlined,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                              ),
                            )
                            // 프로필 이미지가 없을 경우,
                            : ClipRRect(
                              borderRadius: BorderRadius.circular(
                                context.width(0.03),
                              ),
                              child: Image.asset(
                                "assets/images/default_profile.png",
                                fit: BoxFit.cover,
                                width: context.width(0.2),
                              ),
                            ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: context.middlePadding / 2,
                        right: context.middlePadding,
                        top: context.middlePadding / 4,
                        bottom: context.middlePadding / 4,
                      ),
                      child: Container(
                        height: context.height(0.2), // 첫 번째 컨테이너와 높이를 맞춰줍니다.
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            context.width(0.03),
                          ),
                        ),
                        // 예시 텍스트
                        child: Column(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "신분증",
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? Colors.white
                                                : Colors.black,
                                        fontSize: context.width(0.04),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 5),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "이름",
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? Colors.white
                                                : Colors.black,
                                        fontSize: context.width(0.045),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      userState.name.isEmpty
                                          ? "로그인이 필요합니다."
                                          : userState.name,
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? Colors.white
                                                : Colors.black,
                                        fontSize: context.width(0.035),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "월급",
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? Colors.white
                                                : Colors.black,
                                        fontSize: context.width(0.045),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "${numberFormat.format(userState.monthlySalary)} 원",
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? Colors.white
                                                : Colors.black,
                                        fontSize: context.width(0.035),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            Spacer(),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset(
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? "assets/images/logo_light.png"
                                      : "assets/images/logo_light_color.png",
                                  width: context.width(0.17),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- 프로필 섹션 ---
            const SizedBox(height: 15),
            if (userState.isLogin == true) _buildSectionHeader("프로필"),
            if (userState.isLogin == true)
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: context.middlePadding / 2,
                ),
                leading: Icon(
                  Icons.edit_outlined,
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                ),
                title: Text(
                  '닉네임 수정',
                  style: TextStyle(
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: primaryGradientEnd,
                ),
                onTap: () {
                  context.push('/editName');
                },
              ),
            if (userState.isLogin == true)
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: context.middlePadding / 2,
                ),
                leading: Icon(
                  Icons.photo_camera_outlined,
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                ),
                title: Text(
                  '프로필 사진 변경',
                  style: TextStyle(
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: primaryGradientEnd,
                ),
                onTap: () {
                  ref.read(isOpenEditProfileImage.notifier).state = true;
                },
              ),
            if (userState.isLogin == true)
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: context.middlePadding / 2,
                ),
                leading: Icon(
                  Icons.attach_money_outlined,
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                ),
                title: Text(
                  "월 수익 설정",
                  style: TextStyle(
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: primaryGradientEnd,
                ),
                onTap: () {
                  context.push('/setSalary');
                },
              ),
            // --- 앱 설정 섹션 ---
            _buildSectionHeader("앱 설정"),
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: context.middlePadding / 2,
              ),
              leading: Icon(
                Icons.brightness_6_outlined,
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
              ),
              title: Text(
                '테마 설정',
                style: TextStyle(
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                ),
              ),
              trailing: Text(
                _themeModeToString(currentThemeMode),
                style: TextStyle(
                  fontSize: context.width(0.035),
                  color: primaryGradientEnd,
                ),
              ),
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
            // --- 계정 섹션 ---
            _buildSectionHeader("계정"),
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: context.middlePadding / 2,
              ),
              leading: Icon(
                Icons.description_outlined,
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
              ),
              title: Text(
                '이용약관',
                style: TextStyle(
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                ),
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: primaryGradientStart,
              ),
              onTap: () async {
                String urls = dotenv.env['TERMS_URL']!;
                final Uri url = Uri.parse(urls); // 실제 약관 URL로 변경
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
            ),
            if (userState.isLogin == true)
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: context.middlePadding / 2,
                ),
                leading: const Icon(Icons.logout, color: Colors.orange),
                title: const Text(
                  "로그아웃",
                  style: TextStyle(color: Colors.orange),
                ),
                onTap: () async {
                  showDialog(
                    context: context,
                    builder:
                        (ctx) => AlertDialog(
                          title: const Text('로그아웃'),
                          content: const Text('정말로 로그아웃 하시겠습니까?'),
                          actions: [
                            TextButton(
                              child: const Text(
                                '로그아웃',
                                style: TextStyle(color: Colors.grey),
                              ),
                              onPressed: () {
                                context.pop();
                                ref
                                    .read(stateAuthViewModelProvider)
                                    .signout(context);
                              },
                            ),
                            TextButton(
                              child: const Text('취소'),
                              onPressed: () => Navigator.of(ctx).pop(),
                            ),
                          ],
                        ),
                  );
                },
              ),
            if (userState.isLogin == true)
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: context.middlePadding / 2,
                ),
                leading: const Icon(
                  Icons.person_remove_outlined,
                  color: Colors.deepOrange,
                ),
                title: const Text(
                  "회원탈퇴",
                  style: TextStyle(color: Colors.deepOrange),
                ),
                onTap: () {
                  ref.read(isOpenReSign.notifier).state = true;
                },
              ),
            if (userState.name.isEmpty)
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: context.middlePadding / 2,
                ),
                leading: Icon(
                  Icons.login,
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                ),
                title: Text(
                  "로그인",
                  style: TextStyle(
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
                onTap: () {
                  context.go("/login");
                },
              ),
            if (userState.name.isEmpty)
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: context.middlePadding / 2,
                ),
                leading: Icon(
                  Icons.person_add,
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                ),
                title: Text(
                  "회원가입",
                  style: TextStyle(
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
                onTap: () {
                  context.push("/sign");
                },
              ),
          ],
        ),
      ),
    );
  }

  // 3. 헬퍼 메서드들을 State 클래스 안으로 이동
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.middlePadding / 2,
        top: context.middlePadding / 2,
        bottom: context.middlePadding,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    );
  }

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
