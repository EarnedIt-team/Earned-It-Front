import 'package:earned_it/config/design.dart';
import 'package:earned_it/config/exception.dart';
import 'package:earned_it/config/toastMessage.dart';
import 'package:earned_it/services/report_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

enum ReportReason {
  inappropriateProfile('INAPPROPRIATE_PROFILE', '불건전한 프로필/닉네임/위시 사용'),
  advertisingProfile('ADVERTISING_PROFILE', '광고 목적의 프로필/닉네임/위시'),
  violentContent('VIOLENT_CONTENT', '폭력적인 요소 포함'),
  other('OTHER', '기타');

  const ReportReason(this.code, this.displayName);
  final String code;
  final String displayName;
}

/// 신고 모달을 화면에 표시하는 함수
/// 신고 성공 시 true, 그 외에는 false 또는 null을 반환합니다.
Future<bool?> showReportModal(
  BuildContext context, {
  required int userIdToReport,
}) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // ✨ Riverpod Provider를 사용하기 위해 Consumer로 감싸줍니다.
        child: ProviderScope(
          child: _ReportModalContent(userIdToReport: userIdToReport),
        ),
      );
    },
  );
}

/// 모달 내부에 들어갈 실제 UI 위젯
class _ReportModalContent extends ConsumerStatefulWidget {
  final int userIdToReport;

  const _ReportModalContent({required this.userIdToReport});

  @override
  ConsumerState<_ReportModalContent> createState() =>
      _ReportModalContentState();
}

class _ReportModalContentState extends ConsumerState<_ReportModalContent> {
  ReportReason? _selectedReason;
  final _memoController = TextEditingController();
  // API 호출 중 로딩 상태를 관리하는 변수
  bool _isLoading = false;

  @override
  void dispose() {
    _memoController.dispose();
    super.dispose();
  }

  // 실제 신고를 서버에 전송하는 함수
  Future<void> _submitReport() async {
    // '기타' 사유 선택 시, 메모가 비어있는지 확인
    if (_selectedReason == ReportReason.other &&
        _memoController.text.trim().isEmpty) {
      toastMessage(
        context,
        "'기타' 사유를 선택한 경우, 상세 내용을 반드시 입력해야 합니다.",
        type: ToastmessageType.errorType,
      );
      return;
    }

    setState(() {
      _isLoading = true; // 로딩 시작
    });

    try {
      final reportService = ref.read(reportServiceProvider);
      const storage = FlutterSecureStorage();
      final accessToken = await storage.read(key: 'accessToken');

      if (accessToken == null) {
        throw Exception('로그인이 필요합니다.');
      }

      await reportService.sendReport(
        accessToken: accessToken,
        reportedUserId: widget.userIdToReport,
        reasonCode: _selectedReason!.code,
        reasonText: _memoController.text,
      );

      // 성공 시
      if (mounted) {
        toastMessage(context, "신고가 정상적으로 접수되었습니다.");
        context.pop();
      }
    } catch (e) {
      // 실패 시
      if (mounted) {
        toastMessage(
          context,
          e.toDisplayString(),
          type: ToastmessageType.errorType,
        );
      }
    } finally {
      // 성공/실패와 관계없이 로딩 종료
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color:
            Theme.of(context).brightness == Brightness.dark
                ? lightDarkColor
                : lightColor2,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 5,
            children: [
              Image.asset(
                'assets/images/siren_icon.png',
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
              ),
              Text(
                '유저 신고',
                style: TextStyle(
                  fontSize: context.width(0.05),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          Column(
            children:
                ReportReason.values.map((reason) {
                  return RadioListTile<ReportReason>(
                    title: Text(
                      reason.displayName,
                      style: TextStyle(
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                    value: reason,
                    groupValue: _selectedReason,
                    onChanged: (value) {
                      setState(() {
                        _selectedReason = value;
                      });
                    },
                  );
                }).toList(),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _memoController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: '상세 내용을 입력해주세요. (선택 사항)',
              hintStyle: TextStyle(
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
              ),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed:
                  _selectedReason == null || _isLoading ? null : _submitReport,
              child:
                  _isLoading
                      ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                      : Text(
                        '신고하기',
                        style: TextStyle(
                          fontSize: context.width(0.04),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
