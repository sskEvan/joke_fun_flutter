import 'dart:async';

import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/common/event/attention_changed_event.dart';
import 'package:joke_fun_flutter/business/common/event/joke_comment_num_event.dart';
import 'package:joke_fun_flutter/business/common/event/joke_like_action_event.dart';
import 'package:joke_fun_flutter/common/util/event_bus_manager.dart';
import 'package:joke_fun_flutter/common/util/toast_util.dart';
import 'package:joke_fun_flutter/common/util/user_manager.dart';
import 'package:joke_fun_flutter/http/retrofit_client.dart';
import 'package:joke_fun_flutter/models/base_result.dart';
import 'package:joke_fun_flutter/router/routers.dart';

import '../../../common/view_state/view_state_paging_logic.dart';
import '../../../models/joke_detail_entity.dart';

/// 段子列表通用logic
abstract class JokeListLogic extends ViewStatePagingLogic {
  RxList<JokeDetailEntity> dataList = <JokeDetailEntity>[].obs;
  late StreamSubscription attentionChangeSubscription;
  late StreamSubscription jokeLikeActionSubscription;
  late StreamSubscription jokeCommentNumSubscription;

  @override
  void onInit() {
    super.onInit();
    attentionChangeSubscription =
        eventBus.on<AttentionChangeEvent>().listen((event) {
      var item = dataList.firstWhereOrNull(
          (element) => element.user?.userId.toString() == event.userId);
      if (item != null) {
        item.info?.isAttention = event.attention;
        dataList.refresh();
      }
    });
    jokeLikeActionSubscription =
        eventBus.on<JokeLikeActionEvent>().listen((event) {
      var item = dataList.firstWhereOrNull(
          (element) => element.joke?.jokesId == event.jokesId);
      if (item != null) {
        if (event.isLikeAction == true) {
          item.info?.isLike = event.value;
          if (event.value) {
            item.info?.likeNum = (item.info?.likeNum ?? 0) + 1;
          } else {
            item.info?.likeNum = (item.info?.likeNum ?? 0) - 1;
          }
        } else {
          item.info?.isUnlike = event.value;
          if (event.value) {
            item.info?.disLikeNum = (item.info?.disLikeNum ?? 0) + 1;
          } else {
            item.info?.disLikeNum = (item.info?.disLikeNum ?? 0) - 1;
          }
        }
        dataList.refresh();
      }
    });
    jokeCommentNumSubscription =
        eventBus.on<JokeCommentNumEvent>().listen((event) {
          var item = dataList.firstWhereOrNull(
                  (element) => element.joke?.jokesId == event.jokesId);
          if(item != null) {
            item.info?.commentNum = event.totalNum;
            dataList.refresh();
          }
    });
  }

  @override
  void loadData() async {
    sendRequest(requestFuture("1"), successCallback: (data) {
      dataList.clear();
      dataList.addAll(data!);
    });
  }

  @override
  void refreshPaging() async {
    sendRefreshPagingRequest(requestFuture("1"),
        successBlock: (data) {
      dataList.clear();
      dataList.addAll(data);
    });
  }

  @override
  void loadMorePaging() async {
    sendLoadMorePagingRequest(requestFuture("${curPage + 1}"),
        successBlock: (data) {
      dataList.addAll(data);
    });
  }

  void attentionUser(int? userId, bool noAttention) {
    sendRequest(
        RetrofitClient.instance.apiService
            .attentionUser(noAttention ? "1" : "0", "${userId ?? ""}"),
        bindViewState: false,
        needLogin: true,
        showLoadingDialog: true, successCallback: (data) {
      showToast(noAttention ? "关注成功" : "取消关注成功");
      eventBus.fire(AttentionChangeEvent(
          userId: userId?.toString(), attention: noAttention));
    });
  }

  void likeJokeAction(int? jokesId, bool? isLike) {
    sendRequest(
        RetrofitClient.instance.apiService
            .likeJoke("${jokesId ?? ""}", "${isLike ?? false}"),
        bindViewState: false,
        needLogin: true,
        emptyAsSuccess: true,
        showLoadingDialog: true, successCallback: (data) {
      eventBus.fire(JokeLikeActionEvent(
          jokesId: jokesId, isLikeAction: true, value: isLike ?? false));
    });
  }

  void unlikeJokeAction(int? jokesId, bool? isUnLike) {
    sendRequest(
        RetrofitClient.instance.apiService
            .unlikeJoke("${jokesId ?? ""}", "${isUnLike ?? false}"),
        bindViewState: false,
        needLogin: true,
        emptyAsSuccess: true,
        showLoadingDialog: true, successCallback: (data) {
      eventBus.fire(JokeLikeActionEvent(
          jokesId: jokesId, isLikeAction: false, value: isUnLike ?? false));
    });
  }

  @override
  void onClose() {
    attentionChangeSubscription.cancel();
    jokeLikeActionSubscription.cancel();
    jokeCommentNumSubscription.cancel();
    super.onClose();
  }

  Future<BaseResult<List<JokeDetailEntity>>> requestFuture(String pageNum);

}
