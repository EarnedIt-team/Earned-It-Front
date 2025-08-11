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
                    const Text(
                      "이미지",
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                                      fit: BoxFit.cover,
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
                    const Text(
                      "이름",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      textAlign: TextAlign.end,
                      controller: wishEditNotifier.nameController,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "회사",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      textAlign: TextAlign.end,
                      controller: wishEditNotifier.vendorController,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "금액",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      textAlign: TextAlign.end,
                      controller: wishEditNotifier.priceController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        NumberInputFormatter(),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "구매 링크 (선택)",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      textAlign: TextAlign.end,
                      controller: wishEditNotifier.urlController,
                      keyboardType: TextInputType.url,
                    ),
                    const SizedBox(height: 24),
                    wishState.starWishes.length <= 5 && wishEditState.isTop5
                        ? CheckboxListTile(
                          title: const Text(
                            "TOP5에 등록하기",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: const Text("나의 대표 위시 아이템으로 등록합니다."),
                          value: wishEditState.isTop5,
                          onChanged: wishEditNotifier.toggleIsTop5,
                          activeColor: primaryColor,
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                        )
                        : SizedBox(
                          width: double.infinity,
                          child: Text(
                            "* Star 위시리스트는 최대 5개만 가능합니다.",
                            style: TextStyle(
                              fontSize: context.width(0.035),
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                            ),
                            textAlign: TextAlign.center,
                          ),
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
