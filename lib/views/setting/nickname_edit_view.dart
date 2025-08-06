import 'package:earned_it/config/design.dart';
import 'package:earned_it/view_models/setting/edit_nickname_provider.dart';
import 'package:earned_it/views/loading_overlay_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NicknameEditView extends ConsumerWidget {
  const NicknameEditView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nicknameEditState = ref.watch(nicknameEditViewModelProvider);
    final nicknameEditNotifier = ref.read(
      nicknameEditViewModelProvider.notifier,
    );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: const Text(
                "닉네임 수정",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: false,
            ),
            body: Padding(
              padding: EdgeInsets.all(context.middlePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "새로운 닉네임을 입력해주세요.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: nicknameEditNotifier.nicknameController,
                    autofocus: true,
                    maxLength: 15, // 닉네임 최대 길이 제한
                    decoration: InputDecoration(
                      hintText: "닉네임 입력",
                      // 유효성 검사 결과에 따라 에러 메시지 표시
                      errorText: nicknameEditState.validationError,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const Spacer(), // 버튼을 화면 하단으로 밀어냄
                ],
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: context.middlePadding,
                  right: context.middlePadding,
                  bottom: context.height(0.01),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: context.height(0.06),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                    ),
                    onPressed:
                        nicknameEditState.canSubmit
                            ? () => nicknameEditNotifier.submitUpdate(context)
                            : null,
                    child: Text(
                      "수정하기",
                      style: TextStyle(
                        color:
                            nicknameEditState.canSubmit
                                ? Colors.black
                                : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (nicknameEditState.isLoading) overlayView(),
        ],
      ),
    );
  }
}
