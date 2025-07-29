import 'package:dio/dio.dart';
import 'package:earned_it/main.dart';
import 'package:earned_it/models/api_response.dart';
import 'package:earned_it/services/rest_client.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

final kakaologinServiceProvider = Provider<KakaoLoginService>((ref) {
  return KakaoLoginService(restClient);
});

class KakaoLoginService {
  final RestClient _restClient;

  KakaoLoginService(this._restClient);

  Future<ApiResponse> login() async {
    try {
      // 휴대폰에 카카오톡이 깔려있는지 bool 값으로 반환해주는 함수
      bool installed = await isKakaoTalkInstalled();

      // 깔려있다면 UserApi.instance.loginWithKakaoTalk() 으로 카카오톡 오픈 후 동의
      // 깔려있지 않다면 UserApi.instance.loginWithKakaoAccount() 으로 웹을 통한 인증
      OAuthToken token =
          installed
              ? await UserApi.instance.loginWithKakaoTalk()
              : await UserApi.instance.loginWithKakaoAccount();

      // 위 두가지 방법으로 인증 로그인 성공 후 유저 정보 가져오기
      User user = await UserApi.instance.me();

      // 서버로 유저 정보 전송하여 데이터베이스에 저장하기
      AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();

      final OAuthToken? tokens =
          await TokenManagerProvider.instance.manager.getToken();

      final Map<String, String> requestBody = <String, String>{
        "accessToken": tokens!.accessToken,
      };

      final ApiResponse response = await _restClient.kakaologin(requestBody);
      // 통신은 성공했지만, 처리가 되지 않았을 때
      if (response.code != "SUCCESS") {
        throw Exception(response.message);
      }
      return response;
    } on DioException catch (e) {
      throw Exception(e.response!.data["message"]);
    } catch (e) {
      if (e is PlatformException && e.code == 'CANCELED') {
        throw Exception('로그인을 취소했습니다.');
      } else {
        throw Exception('카카오톡 로그인 실패: $e');
      }
    }
  }
}
