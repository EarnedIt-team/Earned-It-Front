import 'package:dio/dio.dart';
import 'package:earned_it/main.dart';
import 'package:earned_it/models/api_response.dart';
import 'package:earned_it/services/rest_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginServiceProvider = Provider<LoginService>((ref) {
  return LoginService(restClient);
});

class LoginService {
  final RestClient _restClient;

  LoginService(this._restClient);
}
