import 'package:dio/dio.dart';
import 'package:earned_it/main.dart';
import 'package:earned_it/models/api_response.dart';
import 'package:earned_it/services/rest_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final forgotPasswordServiceProvider = Provider<ForgotPasswordService>((ref) {
  return ForgotPasswordService(restClient);
});

class ForgotPasswordService {
  final RestClient _restClient;

  ForgotPasswordService(this._restClient);

  /// 입력한 이메일로 비밀번호 재설정용 인증 코드를 서버에게 요청합니다.
  Future<ApiResponse> sendpasswordEmail(String email) async {
    try {
      final response = await _restClient.sendpasswordEmail(email);
      // 통신은 성공했지만, 처리가 되지 않았을 때
      if (response.code != "SUCCESS") {
        throw Exception("토큰이 만료되어 사용자 정보를 제거합니다.");
      }
      return response;
    } on DioException catch (e) {
      // 400 에러 등
      throw Exception(e.response!.data["message"]);
    } catch (e) {
      // DioException이 아닌 다른 예외 발생 시 (네트워크 연결 끊김 등)
      throw Exception("서버에서 에러가 발생했습니다.");
    }
  }

  /// 이메일로 받은 인증 코드를 서버에서 검증합니다.
  Future<ApiResponse> verifyPasswordEmail(String email, String token) async {
    try {
      final Map<String, String> requestBody = <String, String>{
        "email": email,
        "token": token,
      };

      final response = await _restClient.verifyPasswordEmail(requestBody);

      // 통신은 성공했지만, 처리가 되지 않았을 때
      if (response.code != "SUCCESS") {
        throw Exception("토큰이 만료되어 사용자 정보를 제거합니다.");
      }
      return response;
    } on DioException catch (e) {
      // 400 에러 등
      throw Exception(e.response!.data["message"]);
    } catch (e) {
      // DioException이 아닌 다른 예외 발생 시 (네트워크 연결 끊김 등)
      throw Exception("서버에서 에러가 발생했습니다.");
    }
  }

  /// 이메일과 새 비밀번호를 입력받아 비밀번호 변경을 서버에게 요청합니다.
  Future<ApiResponse> resetPassword(String email, String newPassword) async {
    try {
      final Map<String, String> requestBody = <String, String>{
        "email": email,
        "newPassword": newPassword,
      };

      final response = await _restClient.resetPassword(requestBody);

      // 통신은 성공했지만, 처리가 되지 않았을 때
      if (response.code != "SUCCESS") {
        throw Exception("토큰이 만료되어 사용자 정보를 제거합니다.");
      }
      return response;
    } on DioException catch (e) {
      // 400 에러 등
      throw Exception(e.response!.data["message"]);
    } catch (e) {
      // DioException이 아닌 다른 예외 발생 시 (네트워크 연결 끊김 등)
      throw Exception("서버에서 에러가 발생했습니다.");
    }
  }
}
