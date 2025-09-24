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
                    Text(
                      "이미지",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => wishEditNotifier.pickImage(context),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.secondary.withOpacity(0.1),
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
                                wishEditState.imageForUpload != null
                                    ? Image.file(
                                      File(wishEditState.imageForUpload!.path),
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
                                    : const Center(
                                      child: Icon(
                                        Icons.add_photo_alternate_outlined,
                                        size: 40,
                                        color: Colors.grey,
                                      ),
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
                      decoration: const InputDecoration(
                        hintText: '제품명을 입력하세요.',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
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
                      maxLength: 12,
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
                      decoration: const InputDecoration(
                        hintText: '브랜드나 제조사를 입력하세요.',
                        hintStyle: TextStyle(color: Colors.grey),
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
