import 'package:dio/dio.dart';
import 'package:earned_it/models/api_response.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  // 이메일 인증 코드 요청 API
  @POST("/api/auth/email/send")
  Future<ApiResponse> sendEmail(@Query('email') String email);

  // 인증 코드 검사 API
  @POST("/api/auth/email/verify")
  Future<ApiResponse> verifyEmail(@Body() Map<String, String> body);

  // 회원가입 API
  @POST("/api/auth/signup")
  Future<ApiResponse> signUpUser(@Body() Map<String, dynamic> body);
}
