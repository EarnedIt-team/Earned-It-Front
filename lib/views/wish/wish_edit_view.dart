import 'dart:io';
import 'package:earned_it/config/design.dart';
import 'package:earned_it/models/wish/wish_model.dart';
import 'package:earned_it/view_models/wish/wish_edit_provider.dart';
import 'package:earned_it/view_models/wish/wish_provider.dart';
import 'package:earned_it/views/loading_overlay_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// 커스텀 포맷터
class NumberInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat.decimalPattern('ko_KR');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // 1. 쉼표를 제거하여 순수 숫자 문자열을 얻습니다.
    String plainNumber = newValue.text.replaceAll(',', '');

    // 순수 숫자의 길이가 12자를 초과하는지 확인합니다.
    if (plainNumber.length > 12) {
      // 12자를 초과하면, 이전 값(oldValue)을 그대로 반환하여 입력을 막습니다.
      // 이렇게 하면 13번째 문자가 입력되지 않습니다.
      return oldValue;
    }

    // 3. 순수 숫자를 정수로 변환합니다.
    final number = int.tryParse(plainNumber) ?? 0;

    // 4. 쉼표를 포함하여 포맷팅합니다.
    final String formatted = _formatter.format(number);

    // 5. 포맷팅된 텍스트와 올바른 커서 위치를 포함하여 새로운 값을 반환합니다.
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class WishEditView extends ConsumerStatefulWidget {
  final WishModel wishItem; // 수정할 아이템을 전달받음
  const WishEditView({super.key, required this.wishItem});

  @override
  ConsumerState<WishEditView> createState() => _WishEditViewState();
}

class _WishEditViewState extends ConsumerState<WishEditView> {
  @override
  void initState() {
    super.initState();
    // 위젯이 생성될 때 한 번만 ViewModel을 초기 데이터로 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(wishEditViewModelProvider.notifier);
      notifier.initialize(widget.wishItem);

      // 초기 가격에 쉼표 포맷 적용
      final priceText = notifier.priceController.text;
      if (priceText.isNotEmpty) {
        final formattedPrice =
            NumberInputFormatter()
                .formatEditUpdate(
                  TextEditingValue.empty,
                  TextEditingValue(text: priceText),
                )
                .text;
        notifier.priceController.value = TextEditingValue(
          text: formattedPrice,
          selection: TextSelection.collapsed(offset: formattedPrice.length),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final wishState = ref.watch(wishViewModelProvider);
    final wishEditState = ref.watch(wishEditViewModelProvider);
    final wishEditNotifier = ref.read(wishEditViewModelProvider.notifier);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: const Text(
                "위시아이템 수정",
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
                    Row(
                      children: [
                        Text(
                          "이미지",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: context.width(0.04),
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                        if (wishEditState.itemImage != null) ...[
                          Spacer(),
                          TextButton(
                            style: TextButton.styleFrom(
                              side: const BorderSide(
                                width: 1,
                                color: Colors.blueAccent,
                              ),
                            ),
                            onPressed: () {
                              wishEditNotifier.pickImage(context);
                            },
                            child: const Text(
                              "변경",
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                          ),
                          const SizedBox(width: 10),
                          TextButton(
                            style: TextButton.styleFrom(
                              side: const BorderSide(
                                width: 1,
                                color: Colors.red,
                              ),
                            ),
                            onPressed: () {
                              wishEditNotifier.resetImage();
                            },
                            child: const Text(
                              "초기화",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap:
                          () =>
                              wishEditState.itemImage != null
                                  ? wishEditNotifier.editImage(context)
                                  : wishEditNotifier.pickImage(context),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Theme.of(
                                context,
                              ).colorScheme.secondary.withOpacity(0.3),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child:
                                wishEditState.itemImage != null
                                    ? Image.file(
                                      File(wishEditState.itemImage!.path),
                                      fit: BoxFit.contain,
                                    )
                                    : (wishEditState
                                            .initialWish
                                            ?.itemImage
                                            .isNotEmpty ??
                                        false)
                                    ? Image.network(
                                      wishEditState.initialWish!.itemImage,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, progress) =>
                                              progress == null
                                                  ? child
                                                  : const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Center(
                                                child: Icon(
                                                  Icons.error_outline,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                    )
                                    : Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add_photo_alternate_outlined,
                                            size: context.width(0.12),
                                            color: primaryGradientEnd,
                                          ),
                                          const SizedBox(height: 10),
                                          const Text(
                                            "탭하여 이미지 추가",
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                          ),
                        ),
                      ),
                    ),
                    if (wishEditState.itemImage != null) ...[
                      const SizedBox(height: 5),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "*이미지를 탭하면 수정할 수 있습니다.",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 24),
                    Text(
                      "이름",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.width(0.04),
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                    TextField(
                      maxLength: 50,
                      textAlign: TextAlign.end,
                      controller: wishEditNotifier.nameController,
                      decoration: InputDecoration(
                        hintText: '제품명을 입력하세요.',
                        hintStyle: const TextStyle(color: Colors.grey),
                        counterText:
                            '${wishEditNotifier.nameController.text.replaceAll(',', '').length}/50',
                        counterStyle: const TextStyle(
                          fontSize: 12.0,
                          color: Color.fromARGB(255, 136, 136, 136),
                        ),
                      ),
                      inputFormatters: [
                        // 첫 글자로 공백이 오는 것을 막음 (정규식: ^ -> 시작, \s -> 공백)
                        FilteringTextInputFormatter.deny(RegExp(r'^\s')),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "금액",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.width(0.04),
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                    TextField(
                      // maxLength: 12,
                      textAlign: TextAlign.end,
                      controller: wishEditNotifier.priceController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        NumberInputFormatter(),
                      ],
                      decoration: InputDecoration(
                        hintText: '제품 금액을 입력하세요.',
                        hintStyle: const TextStyle(color: Colors.grey),
                        suffixText:
                            wishEditNotifier.priceController.text.isNotEmpty
                                ? '원'
                                : null,
                        suffixStyle: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                        ),
                        errorText:
                            wishEditNotifier.priceController.text.isNotEmpty &&
                                    !wishEditState.canSubmit
                                ? wishEditState.priceError
                                : null,
                        counterText:
                            '${wishEditNotifier.priceController.text.replaceAll(',', '').length}/12',
                        counterStyle: const TextStyle(
                          fontSize: 12.0,
                          color: Color.fromARGB(255, 136, 136, 136),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "회사",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.width(0.04),
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                    TextField(
                      maxLength: 20,
                      textAlign: TextAlign.end,
                      controller: wishEditNotifier.vendorController,
                      decoration: InputDecoration(
                        hintText: '브랜드나 제조사를 입력하세요.',
                        hintStyle: const TextStyle(color: Colors.grey),
                        counterText:
                            '${wishEditNotifier.vendorController.text.replaceAll(',', '').length}/20',
                        counterStyle: const TextStyle(
                          fontSize: 12.0,
                          color: Color.fromARGB(255, 136, 136, 136),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "구매 링크 (선택)",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.width(0.04),
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                    TextField(
                      textAlign: TextAlign.end,
                      controller: wishEditNotifier.urlController,
                      keyboardType: TextInputType.url,
                      decoration: const InputDecoration(
                        hintText: 'ex. https://naver.com',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: context.height(0.03)),
                    Text(
                      '*구매 링크를 입력하지 않으면 추후 "구매하기"를 진행했을 때, 해당 위시아이템 이름을 기반으로 다나와 사이트에 연결됩니다.',
                      style: TextStyle(
                        fontSize: context.width(0.035),
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: context.height(0.01)),
                    (wishState.starWishes.length < 5) ||
                            (widget.wishItem.starred)
                        ? CheckboxListTile(
                          title: Text(
                            "TOP5에 등록하기",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? primaryColor
                                      : const Color.fromARGB(255, 216, 155, 50),
                            ),
                          ),
                          subtitle: Text(
                            "나의 대표 위시 아이템으로 등록합니다.",
                            style: TextStyle(
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          ),
                          value: wishEditState.isTop5,
                          onChanged: wishEditNotifier.toggleIsTop5,
                          activeColor: primaryGradientStart,
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                        )
                        : Text(
                          "*Star 위시리스트는 최대 5개만 가능합니다.",
                          style: TextStyle(
                            fontSize: context.width(0.035),
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                          textAlign: TextAlign.center,
                        ),
                    SizedBox(height: context.height(0.03)),
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
                      backgroundColor: primaryGradientEnd,
                    ),
                    onPressed:
                        wishEditState.canSubmit
                            ? () => wishEditNotifier.submitUpdate(context)
                            : null,
                    child: Text(
                      "수정 완료",
                      style: TextStyle(
                        color:
                            wishEditState.canSubmit
                                ? Colors.black
                                : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (wishEditState.isLoading) overlayView(),
        ],
      ),
    );
  }
}
