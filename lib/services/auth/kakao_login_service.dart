import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class KakaoLoginService {
  Future<void> login() async {
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
      // print("토큰 값 : ${tokenInfo.id}");

      final OAuthToken? tokens =
          await TokenManagerProvider.instance.manager.getToken();
      print("토큰 : ${tokens?.accessToken}");
    } catch (e) {
      if (e is PlatformException && e.code == 'CANCELED') {
        throw Exception('로그인을 취소했습니다.');
      } else {
        print('카카오톡 회원가입 실패: $e');
      }
    }
  }
}
