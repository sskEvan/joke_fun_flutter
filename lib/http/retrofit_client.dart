import 'package:joke_fun_flutter/http/api/api_service.dart';

class RetrofitClient {
  RetrofitClient._();

  static RetrofitClient get instance => _getInstance();
  static RetrofitClient? _instance;

  static RetrofitClient _getInstance() {
    _instance ??= RetrofitClient._();
    return _instance!;
  }

  ApiService apiService = ApiService();
}