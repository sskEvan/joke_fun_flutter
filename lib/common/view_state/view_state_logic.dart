import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/common/ext/get_ext.dart';
import 'package:joke_fun_flutter/common/util/toast_util.dart';
import 'package:joke_fun_flutter/common/util/user_manager.dart';
import 'package:joke_fun_flutter/common/view_state/view_state.dart';
import 'package:joke_fun_flutter/http/exception/request_exception.dart';
import 'package:joke_fun_flutter/router/routers.dart';

import '../../models/base_result.dart';
import '../util/log_util.dart';

typedef JudgeEmpty<T> = bool Function(T? value);
typedef JudgeNoMoreData<T> = bool Function(T? value);
typedef Convert<T, R> = R Function(T? value);

abstract class ViewStateLogic extends GetxController {
  final Rx<ViewState> viewState = ViewState().obs;

  void loadData() {}

  void sendRequest<T>(
    Future<BaseResult<T>> sendRequestBlock, {
    bool bindViewState = true,
    bool showLoadingDialog = false,
    bool needLogin = false,
    bool emptyAsSuccess = false,
    JudgeEmpty<BaseResult<T>>? judgeEmptyCallback,
    ValueChanged<T?>? successCallback,
    VoidCallback? emptyCallback,
    VoidCallback? failCallback,
  }) {
    if (needLogin && !UserManager.instance.isLogin()) {
      AppRoutes.jumpPage(AppRoutes.verifyCodeLoginPage);
      return;
    }
    if (bindViewState) {
      viewState.value = ViewStateLoading();
    }
    if (showLoadingDialog) {
      Get.showLoading();
    }
    sendRequestBlock.then((result) {
      if (result.isSuccess()) {
        if (showLoadingDialog) {
          Get.hideLoading();
        }
        bool isEmpty = (judgeEmptyCallback != null)
            ? judgeEmptyCallback(result)
            : result.isEmpty();

        if (!isEmpty || (emptyAsSuccess && isEmpty)) {
          if (bindViewState) {
            viewState.value = ViewStateSuccess(result.data);
          }
          if (successCallback != null) {
            successCallback(result.data);
          }
        } else {
          if (bindViewState) {
            viewState.value = ViewStateEmpty();
          }
          if (emptyCallback != null) {
            emptyCallback();
          }
        }
      } else {
        if (bindViewState) {
          viewState.value = ViewStateFail(result.code, result.msg);
        }
        if (showLoadingDialog) {
          Get.hideLoading();
          showToast("${result.msg}(${result.code})");
        }
        if (failCallback != null) {
          failCallback();
        }
      }
    }).catchError((e, staceTrace) {
      RequestException requestException = RequestException.create(e);
      if (bindViewState) {
        viewState.value =
            ViewStateError(requestException.code, requestException.message);
      }
      if (showLoadingDialog) {
        Get.hideLoading();
        showToast("${requestException.message}(${requestException.code})");
      }
      if (failCallback != null) {
        failCallback();
      }
      LogE("sendRequest catchError====>error:$e, staceTrace:$staceTrace}");
    });
  }

// void sendRequestConvert<T, R>(
//   Future<BaseResult<T>> sendRequestBlock, {
//   bool bindViewState = true,
//   bool showLoadingDialog = false,
//   bool needLogin = false,
//   bool emptyAsSuccess = false,
//   required Convert<T, R> convertBlock,
//   ValueChanged<R?>? successBlock,
//   VoidCallback? emptyCallback,
//   VoidCallback? failCallback,
// }) {
//   if (needLogin && !UserManager.instance.isLogin()) {
//     AppRoutes.jumpPage(AppRoutes.verifyCodeLoginPage);
//     return;
//   }
//   if (bindViewState) {
//     viewState.value = ViewStateLoading();
//   }
//   if (showLoadingDialog) {
//     Get.showLoading();
//   }
//   sendRequestBlock.then((result) {
//     if (result.isSuccess()) {
//       if (showLoadingDialog) {
//         Get.hideLoading();
//       }
//       bool isEmpty = result.isEmpty();
//       if (!isEmpty || (emptyAsSuccess && isEmpty)) {
//         R convertResult = convertBlock(result.data);
//         if (bindViewState) {
//           viewState.value = ViewStateSuccess(convertResult);
//         }
//         if (successBlock != null) {
//           successBlock(convertResult);
//         }
//       } else {
//         if (bindViewState) {
//           viewState.value = ViewStateEmpty();
//         }
//         if (emptyCallback != null) {
//           emptyCallback();
//         }
//       }
//     } else {
//       if (bindViewState) {
//         viewState.value = ViewStateFail(result.code, result.msg);
//       }
//       if (showLoadingDialog) {
//         Get.hideLoading();
//         showToast("${result.msg}(${result.code})");
//       }
//       if (failCallback != null) {
//         failCallback();
//       }
//     }
//   }).catchError((e) {
//     RequestException requestException = RequestException.create(e);
//     if (bindViewState) {
//       viewState.value =
//           ViewStateError(requestException.code, requestException.message);
//     }
//     if (showLoadingDialog) {
//       Get.hideLoading();
//       showToast("${requestException.message}(${requestException.code})");
//     }
//     if (failCallback != null) {
//       failCallback();
//     }
//     LogE("sendRequest catchError====>error:$e");
//   });
// }
}
