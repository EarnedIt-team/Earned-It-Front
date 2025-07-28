import 'package:dio/dio.dart';
import 'package:earned_it/main.dart';
import 'package:earned_it/models/api_response.dart';
import 'package:earned_it/services/auth/login_service.dart';
import 'package:earned_it/services/rest_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingServiceProvider = Provider<SettingService>((ref) {
  return SettingService(restClient);
});

class SettingService {
  final RestClient _restClient;

  SettingService(this._restClient);

  /// 사용자의 월 수익을 설정합니다.
  Future<ApiResponse> setSalary(
    String userId,
    String accessToken,
    int amount,
    int payday,
  ) async {
    try {
      final Map<String, int> requestBody = <String, int>{
        "amount": amount,
        "payday": payday,
      };

      final ApiResponse response = await _restClient.setSalary(
        userId,
        accessToken,
        requestBody,
      );
      return response;
      // 400 에러 등
    } on DioException catch (e) {
      rethrow;
    } catch (e) {
      // DioException이 아닌 다른 예외 발생 시 (네트워크 연결 끊김 등)
      throw Exception("서버에서 에러가 발생했습니다.");
    }
  }
}
