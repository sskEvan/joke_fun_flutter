import 'package:dio/dio.dart';
import 'package:joke_fun_flutter/common/util/user_manager.dart';

class ParamsInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var headers = options.headers;
    String? token = UserManager.instance.loginEntity.value?.token;
    if(token != null) {
      headers['token'] = token;
    }
    headers['project_token'] = '42AA73E97A2F49EF8EBB8FE20414072E';
    headers['uk'] = '59a0378351f30f4384c5ecf0985b5c52';
    headers['channel'] = 'cretin_open_api';
    headers['app'] = '1.0.0;1;13';
    headers['device'] = 'HUAWEI;CDY-AN00';
    super.onRequest(options, handler);
  }
}