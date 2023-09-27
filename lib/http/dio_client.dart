import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:joke_fun_flutter/http/interceptor/token_expire_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'interceptor/params_interceptor.dart';

class DioClient {
  ///超时时间
  static const int CONNECT_TIMEOUT = 15000;
  static const int RECEIVE_TIMEOUT = 15000;

  static final DioClient _instance = DioClient._internal();

  factory DioClient() => _instance;

  late Dio dio;

  DioClient._internal() {
    // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(milliseconds: CONNECT_TIMEOUT),
      // 响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: const Duration(milliseconds: RECEIVE_TIMEOUT),
      // Http请求头.
      headers: {},
    );

    dio = Dio(options);
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback = (cert, host, port) {
        return true; // 返回true强制通过
      };
    };

    // 添加error拦截器
    // dio.interceptors.add(ErrorInterceptor());
    dio.interceptors.add(ParamsInterceptor());
    dio.interceptors.add(TokenExpireInterceptor());
    dio.interceptors.add(PrettyDioLogger(
      // 添加日志格式化工具类
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));
  }

  void init({
    String? baseUrl,
    int connectTimeout = CONNECT_TIMEOUT,
    int receiveTimeout = RECEIVE_TIMEOUT,
    Map<String, String>? headers,
    List<Interceptor>? interceptors,
  }) {
    dio.options = dio.options.copyWith(
      baseUrl: baseUrl,
      connectTimeout: Duration(milliseconds: connectTimeout),
      receiveTimeout: Duration(milliseconds: receiveTimeout),
      headers: headers ?? const {},
    );
    if (interceptors != null && interceptors.isNotEmpty) {
      dio.interceptors.addAll(interceptors);
    }
  }
}
