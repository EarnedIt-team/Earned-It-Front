import 'package:dio/dio.dart';
import 'package:earned_it/main.dart';
import 'package:earned_it/models/api_response.dart';
import 'package:earned_it/services/rest_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final checkinServiceProvider = Provider<CheckinService>((ref) {
  return CheckinService(restClient);
});

class CheckinService {
  final RestClient _restClient;

  CheckinService(this._restClient);

  /// 출석보상 후보(3개) 리스트를 가져옵니다.
  Future<ApiResponse> getCandidateList({required String accessToken}) async {
    try {
      String token = "Bearer $accessToken";

      final ApiResponse response = await _restClient.getCandidates(token);

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

  /// 출석보상으로 선택한 조각을 서버에 추가합니다.
  Future<ApiResponse> selectDailyCheck({
    required String accessToken,
    required String rewardToken,
    required int selectedItemId,
  }) async {
    try {
      String token = "Bearer $accessToken";

      final Map<String, dynamic> requestBody = <String, dynamic>{
        "rewardToken": rewardToken,
        "selectedItemId": selectedItemId,
      };

      final ApiResponse response = await _restClient.selectDailyCheck(
        token,
        requestBody,
      );

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
