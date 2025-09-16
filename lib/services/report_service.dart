import 'package:dio/dio.dart';
import 'package:earned_it/main.dart';
import 'package:earned_it/models/api_response.dart';
import 'package:earned_it/services/rest_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportServiceProvider = Provider<ReportService>((ref) {
  return ReportService(restClient);
});

class ReportService {
  final RestClient _restClient;

  ReportService(this._restClient);

  /// 지정한 사용자에게 신고를 진행합니다.
  Future<ApiResponse> sendReport({
    required String accessToken,
    required int reportedUserId,
    required String reasonCode,
    String? reasonText,
  }) async {
    try {
      final String token = "Bearer $accessToken";

      // 1. API 요청 본문(body) 생성
      final Map<String, dynamic> body = {
        'reportedUserId': reportedUserId,
        'reasonCode': reasonCode,
      };

      // 2. reasonText가 있을 경우에만 body에 추가
      if (reasonText != null && reasonText.isNotEmpty) {
        body['reasonText'] = reasonText;
      }

      // 3. RestClient에 정의된 올바른 함수 호출
      final ApiResponse response = await _restClient.reportUser(token, body);

      if (response.code != "SUCCESS") {
        throw Exception(response.message);
      }
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "요청 처리 중 에러가 발생했습니다.");
    } catch (e) {
      throw Exception("서버에서 에러가 발생했습니다.");
    }
  }
}
