import 'package:dio/dio.dart';
import 'package:earned_it/models/api_response.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("/api/auth/email/send")
  Future<ApiResponse> sendEmail(@Query('email') String email);
}
