import 'package:dio/dio.dart';
import 'package:joke_fun_flutter/common/util/log_util.dart';
import 'package:joke_fun_flutter/common/util/toast_util.dart';
import 'package:joke_fun_flutter/router/routers.dart';

class TokenExpireInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data["code"] == 202) {
      /// 登录过期
      LogE("TokenExpireInterceptor 登录过期");
      showToast("当前登录信息已过期，请重新登录");
      AppRoutes.jumpPage(AppRoutes.verifyCodeLoginPage);
    }
    super.onResponse(response, handler);
  }
}
