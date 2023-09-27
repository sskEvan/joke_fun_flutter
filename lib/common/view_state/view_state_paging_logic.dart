import 'package:flutter/cupertino.dart';
import 'package:joke_fun_flutter/common/view_state/view_state.dart';
import 'package:joke_fun_flutter/common/view_state/view_state_logic.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../models/base_result.dart';
import '../util/log_util.dart';

abstract class ViewStatePagingLogic extends ViewStateLogic {
  int curPage = 1;
  int pageSize = 10;
  RefreshController? refreshController;

  void refreshPaging();

  void loadMorePaging();

  void sendRefreshPagingRequest<T>(
    Future<BaseResult<T>> sendRequestBlock, {
    bool bindViewState = true,
    ValueChanged<T>? successBlock,
    VoidCallback? emptyCallback,
    VoidCallback? failCallback,
  }) {
    sendRequestBlock.then((result) {
      if (result.isSuccess()) {
        refreshController?.refreshCompleted();
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
        refreshController?.refreshFailed();
        failCallback;
      }
    }).catchError((e) {
      refreshController?.refreshFailed();
      failCallback;
      LogE("sendRefreshPagingRequest catchError====>error:$e");
    });
  }

  void sendLoadMorePagingRequest<T>(
    Future<BaseResult<T>> sendRequestBlock, {
    bool bindViewState = true,
    JudgeNoMoreData<BaseResult<T>>? judgeNoMoreDataBlock,
    ValueChanged<T>? successBlock,
    VoidCallback? emptyCallback,
    VoidCallback? failCallback,
  }) {
    sendRequestBlock.then((result) {
      if (result.isSuccess()) {
        curPage++;
        if (!result.isEmpty()) {
          bool isNoMoreData = (judgeNoMoreDataBlock != null)
              ? judgeNoMoreDataBlock(result)
              : result.noMoreData(pageSize);
          if (!isNoMoreData) {
            refreshController?.loadComplete();
          } else {
            refreshController?.loadNoData();
          }
        } else {
          refreshController?.loadNoData();
          emptyCallback;
        }
        if (successBlock != null && !result.isEmpty()) {
          successBlock(result.data!);
        }
      } else {
        refreshController?.loadFailed();
        failCallback;
      }
    }).catchError((e) {
      refreshController?.loadFailed();
      failCallback;
      LogE("sendLoadMorePagingRequest catchError====>error:$e");
    });
  }
}
