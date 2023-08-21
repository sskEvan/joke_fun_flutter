import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/common/ext/get_ext.dart';
import 'package:joke_fun_flutter/common/view_state/view_state.dart';
import 'package:joke_fun_flutter/http/exception/request_exception.dart';

import '../../models/base_result.dart';
import '../mixin/toast_mixin.dart';
import '../util/log_util.dart';

typedef JudgeEmpty<T> = bool Function(T? value);

abstract class ViewStateController extends GetxController with ToastMixin {
  final Rx<ViewState> viewState = ViewState().obs;

  void loadData() {}

  void sendRequest<T>(
    Future<BaseResult<T>> sendRequestBlock, {
    bool bindViewState = true,
    bool showLoadingDialog = false,
    JudgeEmpty<T>? judgeEmptyBlock,
    ValueChanged<T?>? successBlock,
    VoidCallback? emptyCallback,
    VoidCallback? failCallback,
  }) {
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
        bool isEmpty = false;
        if(judgeEmptyBlock != null) {
          isEmpty = judgeEmptyBlock(result.data);
        } else {
          isEmpty = result.isEmpty();
        }
        if (!isEmpty) {
          if (bindViewState) {
            viewState.value = ViewStateSuccess(result.data);
          }
          if (successBlock != null) {
            successBlock(result.data);
          }
        } else {
          if (bindViewState) {
            viewState.value = ViewStateEmpty();
          }
          emptyCallback;
        }
      } else {
        if (bindViewState) {
          viewState.value = ViewStateFail(result.code, result.msg);
        }
        if (showLoadingDialog) {
          Get.hideLoading();
          showToast("${result.msg}(${result.code})");
        }
        failCallback;
      }
    }).catchError((e) {
      RequestException requestException = RequestException.create(e);
      if (bindViewState) {
        viewState.value =
            ViewStateError(requestException.code, requestException.message);
      }
      if (showLoadingDialog) {
        Get.hideLoading();
        showToast("${requestException.message}(${requestException.code})");
      }
      failCallback;
      LogE("sendRequest catchError====>error:$e");
    });
  }
}
