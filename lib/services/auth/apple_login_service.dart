import 'package:earned_it/main.dart';
import 'package:earned_it/models/api_response.dart';
import 'package:earned_it/services/rest_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

final appleloginServiceProvider = Provider<AppleLoginService>((ref) {
  return AppleLoginService(restClient);
});

class AppleLoginService {
  final RestClient _restClient;

  AppleLoginService(this._restClient);

  Future<ApiResponse> login() async {
    try {
      final AuthorizationCredentialAppleID
      credentialAppleID = await SignInWithApple.getAppleIDCredential(
        scopes: <AppleIDAuthorizationScopes>[
          AppleIDAuthorizationScopes.email, // 이메일
          // AppleIDAuthorizationScopes.fullName, // 이름은 사용하지 않음
        ],
        // (Android & Web)에서 실행 시 필요.
        // Android 같은 경우에는, 백앤드 서버 콜백이 필요로 하기 때문
        // webAuthenticationOptions:
        //     kIsWeb
        //         ? WebAuthenticationOptions(
        //           clientId:
        //               'YOUR_WEB_CLIENT_ID', // Apple Developer Portal의 Service ID (예: com.example.webauth)
        //           redirectUri: Uri.parse(
        //             'YOUR_WEB_REDIRECT_URI', // Apple Developer Portal에 등록된 리다이렉트 URI (예: https://your-server.com/callbacks/sign_in_with_apple)
        //           ),
        //         )
        //         : null,
      );

      print('Apple 로그인 성공:');
      print('User ID: ${credentialAppleID.userIdentifier}');
      print('Email: ${credentialAppleID.email}');
      print(
        'Identity Token: ${credentialAppleID.identityToken}',
      ); // 이 토큰을 서버로 보내 검증해야 합니다.
      print(
        'Authorization Code: ${credentialAppleID.authorizationCode}',
      ); // 이 코드도 서버로 보내 검증 가능
      // 서버로 Apple 인증 정보 전송 관련 로직

      final Map<String, String> requestBody = <String, String>{
        "idToken": credentialAppleID.identityToken!,
      };

      final ApiResponse response = await _restClient.applelogin(requestBody);
      // 통신은 성공했지만, 처리가 되지 않았을 때
      if (response.code != "SUCCESS") {
        throw Exception(response.message);
      }
      return response;
    } on SignInWithAppleAuthorizationException catch (e) {
      // Apple 로그인 실패 시 오류 처리
      print('Apple 로그인 실패: ${e.code} - ${e.message}');

      if (e.code == AuthorizationErrorCode.canceled) {
        throw Exception('로그인을 취소했습니다.');
      } else if (e.code == AuthorizationErrorCode.notHandled) {
        throw Exception('로그인을 처리할 수 없습니다.');
      }
      throw Exception('Apple 로그인 실패: ${e.message}');
    } catch (e) {
      // 그 외 알 수 없는 오류
      print('알 수 없는 오류 발생: $e');
      throw Exception('애플 로그인 실패: $e');
    }
  }
}
