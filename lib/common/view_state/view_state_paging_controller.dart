import 'package:flutter/cupertino.dart';
import 'package:joke_fun_flutter/common/view_state/view_state.dart';
import 'package:joke_fun_flutter/common/view_state/view_state_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../http/exception/request_exception.dart';
import '../../models/base_result.dart';
import '../util/log_util.dart';

abstract class ViewStatePagingController extends ViewStateController {

  int curPage = 1;
  int pageSize = 10;

  void refreshPaging(RefreshController refreshController);

  void loadMorePaging(RefreshController refreshController);

  void sendRefreshPagingRequest<T>(
      Future<BaseResult<T>> sendRequestBlock, {
        required RefreshController refreshController,
        bool bindViewState = true,
        ValueChanged<T>? successBlock,
        VoidCallback? emptyCallback,
        VoidCallback? failCallback,
      }) {
    sendRequestBlock.then((result) {
      if (result.isSuccess()) {
        refreshController.refreshCompleted();
        curPage = 1;
        if (!result.isEmpty()) {
          if (successBlock != null) {
            successBlock(result.data!);
          }
        } else {
          if (bindViewState) {
            viewState.value = ViewStateEmpty();
          }
          emptyCallback;
        }
      } else {
        refreshController.refreshFailed();
        failCallback;
      }
    }).catchError((e) {
      refreshController.refreshFailed();
      failCallback;
      LogE("sendRefreshPagingRequest catchError====>error:$e");
    });
  }

  void sendLoadMorePagingRequest<T>(
      Future<BaseResult<T>> sendRequestBlock, {
        required RefreshController refreshController,
        bool bindViewState = true,
        ValueChanged<T>? successBlock,
        VoidCallback? emptyCallback,
        VoidCallback? failCallback,
      }) {
    sendRequestBlock.then((result) {
      if (result.isSuccess()) {
        curPage++;
        if (!result.isEmpty()) {
          if(!result.noMoreData(pageSize)) {
            refreshController.loadComplete();
          } else {
            refreshController.loadNoData();
          }
        } else {
          refreshController.loadNoData();
          emptyCallback;
        }
        if (successBlock != null && !result.isEmpty()) {
          successBlock(result.data!);
        }
      } else {
        refreshController.loadFailed();
        failCallback;
      }
    }).catchError((e) {
      refreshController.loadFailed();
      failCallback;
      LogE("sendLoadMorePagingRequest catchError====>error:$e");
    });
  }


}