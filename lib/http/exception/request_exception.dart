import 'package:dio/dio.dart';

import '../../common/util/log_util.dart';

class RequestException implements Exception {

  static const int CODE_UNKOWN_ERROR = 101;
  static const int CODE_NEWWORK_ERROR = 102;

  final String? message;
  final int? code;

  RequestException([
    this.code,
    this.message,
  ]);

  @override
  String toString() {
    return "$code$message";
  }

  factory RequestException.create(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.cancel:
          {
            return RequestException(-1, "请求取消");
          }
        case DioExceptionType.connectionError:
          {
            return RequestException(CODE_NEWWORK_ERROR, "连接超时");
          }
        case DioExceptionType.sendTimeout:
          {
            return RequestException(CODE_NEWWORK_ERROR, "请求超时");
          }
        case DioExceptionType.receiveTimeout:
          {
            return RequestException(CODE_NEWWORK_ERROR, "响应超时");
          }
        case DioExceptionType.badResponse:
          {
            try {
              int? errCode = error.response?.statusCode;
              // String errMsg = error.response.statusMessage;
              // return ErrorEntity(code: errCode, message: errMsg);
              switch (errCode) {
                case 400:
                  {
                    return RequestException(errCode, "请求语法错误");
                  }
                case 401:
                  {
                    return RequestException(errCode, "没有权限");
                  }
                case 403:
                  {
                    return RequestException(errCode, "服务器拒绝执行");
                  }
                case 404:
                  {
                    return RequestException(errCode, "无法连接服务器");
                  }
                case 405:
                  {
                    return RequestException(errCode, "请求方法被禁止");
                  }
                case 500:
                  {
                    return RequestException(errCode, "服务器内部错误");
                  }

                case 502:
                  {
                    return RequestException(errCode, "无效的请求");
                  }

                case 503:
                  {
                    return RequestException(errCode, "服务器挂了");
                  }

                case 505:
                  {
                    return RequestException(errCode, "不支持HTTP协议请求");
                  }

                default:
                  {
                    LogW(error.response?.statusMessage ?? "");
                    return RequestException(
                        errCode, error.response?.statusMessage);
                  }
              }
            } on Exception catch (_) {
              return RequestException(CODE_UNKOWN_ERROR, "未知错误");
            }
          }

        default:
          {
            return RequestException(CODE_NEWWORK_ERROR, "网络连接异常");
          }
      }
    } else {
      return RequestException(CODE_UNKOWN_ERROR, "未知错误");
    }
  }
}
