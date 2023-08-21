import 'dart:io';

import 'package:dio/dio.dart';

import '../../common/util/log_util.dart';
import '../exception/request_exception.dart';


// ///错误处理拦截器
// class ErrorInterceptor extends Interceptor {
//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     // error统一处理
//     RequestException exception = RequestException.create(err);
//     // 错误提示
//     LogE('DioError===: ${exception.toString()}');
//     super.onError(err, handler);
//   }
// }