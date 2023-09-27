import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/common/event/attention_changed_event.dart';
import 'package:joke_fun_flutter/business/common/event/joke_comment_num_event.dart';
import 'package:joke_fun_flutter/business/common/event/joke_like_action_event.dart';
import 'package:joke_fun_flutter/business/common/logic/joke_list_video_play_helper_mixin.dart';
import 'package:joke_fun_flutter/business/joke_detail/comment/joke_detail_comment_page.dart';
import 'package:joke_fun_flutter/business/joke_detail/like/joke_detail_like_page.dart';
import 'package:joke_fun_flutter/common/cpn/keep_alive_wrapper.dart';
import 'package:joke_fun_flutter/common/util/event_bus_manager.dart';
import 'package:joke_fun_flutter/common/util/toast_util.dart';
import 'package:joke_fun_flutter/common/view_state/view_state_logic.dart';
import 'package:joke_fun_flutter/http/retrofit_client.dart';
import 'package:joke_fun_flutter/models/joke_detail_entity.dart';

class JokeDetailLogic extends ViewStateLogic
    with GetSingleTickerProviderStateMixin {
  final RxInt index = 0.obs;
  final RxList<String> tabs = <String>[].obs;
  final RxList<Widget> navPages = <Widget>[].obs;
  final String? tag;
  RxDouble expandedHeight = Get.height.obs;
  GlobalKey globalKey = GlobalKey();
  late Rx<JokeDetailEntity> jokeDetailEntity;
  late StreamSubscription attentionChangeSubscription;
  late StreamSubscription jokeLikeActionSubscription;
  late StreamSubscription jokeCommentNumSubscription;
  JokeListVideoPlayHelperMixin? videoPlayHelper;

  JokeDetailLogic({this.tag});

  late TabController tabController = TabController(
      initialIndex: index.value, vsync: this, length: tabs.length);

  @override
  void onInit() {
    super.onInit();
    var args = Get.arguments;
    JokeDetailEntity entity = args["jokeDetailEntity"];
    jokeDetailEntity = entity.obs;
    videoPlayHelper = args["videoPlayHelper"];
    tabs.value = ['评论', '点赞'];

    navPages.value = [
      KeepAliveWrapper(
          child: JokeDetailCommentPage(
              tag: tag,
              jokeId: jokeDetailEntity.value.joke?.jokesId ?? 0,
              totalCount: jokeDetailEntity.value.info?.commentNum ?? 0)),
      KeepAliveWrapper(
          child: JokeDetailLikePage(
              tag: tag, jokeId: jokeDetailEntity.value.joke?.jokesId ?? 0)),
    ];

    attentionChangeSubscription =
        eventBus.on<AttentionChangeEvent>().listen((event) {
      jokeDetailEntity.refresh();
    });
    jokeLikeActionSubscription =
        eventBus.on<JokeLikeActionEvent>().listen((event) {
      jokeDetailEntity.refresh();
    });
    jokeCommentNumSubscription =
        eventBus.on<JokeCommentNumEvent>().listen((event) {
      jokeDetailEntity.refresh();
    });
  }

  void jumpToPage(int index) {
    tabController.animateTo(index);
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
}
