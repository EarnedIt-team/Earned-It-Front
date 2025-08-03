import 'dart:io';
import 'package:earned_it/config/design.dart';
import 'package:earned_it/view_models/wish_add_provider.dart';
import 'package:earned_it/views/loading_overlay_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// 커스텀 포맷터는 그대로 유지
class NumberInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat.decimalPattern('ko_KR');
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue.copyWith(text: '');
    final plainNumber = newValue.text.replaceAll(',', '');
    final number = int.tryParse(plainNumber) ?? 0;
    final formatted = _formatter.format(number);
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class WishAddView extends ConsumerWidget {
  const WishAddView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishAddState = ref.watch(wishAddViewModelProvider);
    final wishAddNotifier = ref.read(wishAddViewModelProvider.notifier);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: const Text(
                "위시아이템 추가",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: false,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.middlePadding),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: context.middlePadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "이미지",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.width(0.04),
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => wishAddNotifier.pickImage(context),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.secondary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Theme.of(
                                context,
                              ).colorScheme.secondary.withValues(alpha: 0.3),
                            ),
                          ),
                          child:
                              wishAddState.itemImage != null
                                  ? ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(
                                      File(wishAddState.itemImage!.path),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                  : const Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_photo_alternate_outlined,
                                          size: 40,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "탭하여 이미지 추가",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "이름",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.width(0.04),
                      ),
                    ),
                    TextField(
                      textAlign: TextAlign.end,
                      controller: wishAddNotifier.nameController,
                      decoration: const InputDecoration(
                        hintText: '제품명을 입력하세요.',
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "회사",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.width(0.04),
                      ),
                    ),
                    TextField(
                      textAlign: TextAlign.end,
                      controller: wishAddNotifier.vendorController,
                      decoration: const InputDecoration(
                        hintText: '브랜드나 제조사를 입력하세요.',
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "금액",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.width(0.04),
                      ),
                    ),
                    TextField(
                      textAlign: TextAlign.end,
                      controller: wishAddNotifier.priceController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        NumberInputFormatter(),
                      ],
                      decoration: InputDecoration(
                        hintText: '제품 금액을 입력하세요.',
                        suffixText:
                            wishAddNotifier.priceController.text.isNotEmpty
                                ? '원'
                                : null,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "구매 링크 (선택)",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.width(0.04),
                      ),
                    ),
                    TextField(
                      textAlign: TextAlign.end,
                      controller: wishAddNotifier.urlController,
                      keyboardType: TextInputType.url,
                      decoration: const InputDecoration(
                        hintText: '제품 구매 링크를 입력하세요.',
                      ),
                    ),
                    const SizedBox(height: 24),
                    CheckboxListTile(
                      title: const Text(
                        "TOP5에 등록하기",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text("나의 대표 위시 아이템으로 등록합니다."),
                      value: wishAddState.isTop5,
                      onChanged: wishAddNotifier.toggleIsTop5,
                      activeColor: primaryColor,
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: context.middlePadding,
                  right: context.middlePadding,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: context.height(0.06),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      // 버튼 비활성화 시 스타일
                      // disabledBackgroundColor: Colors.grey.shade300,
                    ),
                    // 👇 ViewModel의 canSubmit 상태에 따라 버튼 활성화/비활성화
                    onPressed:
                        wishAddState.canSubmit
                            ? () => wishAddNotifier.submitWishItem(context)
                            : null,
                    child: Text(
                      "추가 하기",
                      style: TextStyle(
                        color:
                            wishAddState.canSubmit ? Colors.black : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // 로딩 오버레이
          if (wishAddState.isLoading) overlayView(),
        ],
      ),
    );
  }
}
