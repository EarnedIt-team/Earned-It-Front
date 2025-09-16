import 'package:earned_it/config/design.dart';
import 'package:earned_it/view_models/setting/set_public_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ✨ 1. ConsumerStatefulWidget으로 변경
class SetPublicView extends ConsumerStatefulWidget {
  const SetPublicView({super.key});

  @override
  ConsumerState<SetPublicView> createState() => _SetPublicViewState();
}

class _SetPublicViewState extends ConsumerState<SetPublicView> {
  // ✨ 2. 로컬 상태 변수(_isPublic, _isLoading, _handleSave)를 모두 제거합니다.
  // initState도 ViewModel에서 초기값을 관리하므로 필요 없습니다.

  @override
  Widget build(BuildContext context) {
    // ✨ 3. ViewModel의 상태를 watch하여 UI를 빌드합니다.
    final settingState = ref.watch(setPublicViewModelProvider);
    final isPublic = settingState.isPublic;
    final isLoading = settingState.isLoading;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          "공개 범위 설정",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(context.middlePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "다른 사용자에게 내 정보가 표시되는 기준이 됩니다.\n\n참고로, 불건전한 정보가 포함된 프로필 및 위시아이템은 다른 사용자의 신고 대상이 될 수 있으며, 이로 인해 서비스 이용이 제한될 수 있음을 알려드립니다.",
                      style: TextStyle(
                        fontSize: context.width(0.038),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildInfoSection(
                      context: context,
                      title: '프로필',
                      description:
                          '닉네임, 사진, 월 급여, 초당 수익 및 사용자가 지정한 Star 위시아이템이 다른 사용자에게 노출됩니다.',
                      imagePath: 'assets/images/setting/publicEx1.png',
                    ),
                    _buildInfoSection(
                      context: context,
                      title: '위시리스트',
                      description:
                          '페이지 상단에 다른 사용자들의 프로필 아이콘이 랜덤으로 나타납니다. 공개 설정 시, 내 프로필도 이곳에 노출되어 다른 사용자들이 방문할 수 있게 됩니다.',
                      imagePath: 'assets/images/setting/publicEx2.png',
                    ),
                    _buildInfoSection(
                      context: context,
                      title: '랭킹',
                      description:
                          '공개 시: 닉네임 및 사진 전체 공개\n비공개 시: 닉네임 일부 숨김 및 사진 비공개 + 방문 제한',
                      imagePath: 'assets/images/setting/publicEx3.png',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    // ✨ 4. onPressed에서 ViewModel의 함수를 호출합니다.
                    onPressed:
                        isLoading
                            ? null
                            : () => ref
                                .read(setPublicViewModelProvider.notifier)
                                .updatePublicStatus(context, true),
                    icon:
                        isLoading && isPublic
                            ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                            : Icon(
                              Icons.public,
                              color: isPublic ? Colors.white : primaryColor,
                            ),
                    label: Text(
                      '공개',
                      style: TextStyle(
                        color: isPublic ? Colors.white : primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor:
                          isPublic ? primaryColor : Colors.transparent,
                      side: BorderSide(color: primaryColor),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    // ✨ 4. onPressed에서 ViewModel의 함수를 호출합니다.
                    onPressed:
                        isLoading
                            ? null
                            : () => ref
                                .read(setPublicViewModelProvider.notifier)
                                .updatePublicStatus(context, false),
                    icon:
                        isLoading && !isPublic
                            ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                            : Icon(
                              Icons.lock_outline,
                              color: !isPublic ? Colors.white : Colors.grey,
                            ),
                    label: Text(
                      '비공개',
                      style: TextStyle(
                        color: !isPublic ? Colors.white : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor:
                          !isPublic ? Colors.grey[600] : Colors.transparent,
                      side: BorderSide(color: Colors.grey.shade400),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// 설명 섹션을 만드는 헬퍼 위젯
  Widget _buildInfoSection({
    required BuildContext context,
    required String title,
    required String description,
    required String imagePath,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: context.width(0.045),
              fontWeight: FontWeight.bold,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: context.width(0.04),
              color: Colors.grey,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(imagePath),
          ),
        ],
      ),
    );
  }
}
