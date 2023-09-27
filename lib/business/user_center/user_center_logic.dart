import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/common/event/attention_changed_event.dart';
import 'package:joke_fun_flutter/business/user_center/collect/user_collect_page.dart';
import 'package:joke_fun_flutter/business/user_center/comment/user_comment_page.dart';
import 'package:joke_fun_flutter/business/user_center/creation/user_creation_page.dart';
import 'package:joke_fun_flutter/business/user_center/like/user_like_page.dart';
import 'package:joke_fun_flutter/common/cpn/keep_alive_wrapper.dart';
import 'package:joke_fun_flutter/common/util/event_bus_manager.dart';
import 'package:joke_fun_flutter/common/view_state/view_state_logic.dart';
import 'package:joke_fun_flutter/http/retrofit_client.dart';
import 'package:joke_fun_flutter/models/user_center_entity.dart';

import '../../common/util/user_manager.dart';

class UserCenterLogic extends ViewStateLogic
    with GetSingleTickerProviderStateMixin {

  final String? tag;
  RxInt index = 0.obs;
  late TabController tabController;
  late String userId;

  final titleBarAlpha = 0.0.obs;
  final userCenterEntity = Rxn<UserCenterEntity?>();
  final isAttention = Rxn<bool?>();
  late StreamSubscription attentionChangeSubscription;

  final RxList<String> tabs = <String>[].obs;
  final RxList<Widget> navPages = <Widget>[].obs;

  UserCenterLogic({this.tag});

  @override
  void onInit() {
    super.onInit();
    Map<String, String?>? params = Get.arguments;
    int preIndex = int.parse(params?["index"] ?? "0");
    userId = params?["userId"] ??
        UserManager.instance.loginEntity.value?.userInfo?.userId?.toString() ??
        "";
    index.value = preIndex;
    if (isSelf()) {
      tabs.value = ['创作', '喜欢', '评论', '收藏'];
      navPages.value = [
        KeepAliveWrapper(child: UserCreationPage(userId: userId, tag: tag)),
        KeepAliveWrapper(child: UserLikePage(userId: userId, tag: tag)),
        KeepAliveWrapper(child: UserCommentPage(tag: tag)),
        KeepAliveWrapper(child: UserCollectPage(tag: tag)),
      ];
    } else {
      tabs.value = ['创作', '喜欢'];
      navPages.value = [
        KeepAliveWrapper(child: UserCreationPage(userId: userId, tag: tag)),
        KeepAliveWrapper(child: UserLikePage(userId: userId, tag: tag)),
      ];
    }
    tabController = TabController(
        initialIndex: index.value, vsync: this, length: tabs.length);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        index.value = tabController.index;
      }
    });
    attentionChangeSubscription =
        eventBus.on<AttentionChangeEvent>().listen((event) {
          isAttention.value = event.attention;
          _refreshUserInfo();
        });
  }

  bool isSelf() {
    return userId ==
        UserManager.instance.loginEntity.value?.userInfo?.userId.toString();
  }

  String nickName() {
    return isSelf()
        ? UserManager.instance.nickname.value
        : userCenterEntity.value?.nickname ?? "--";
  }

  String signature() {
    return isSelf()
        ? UserManager.instance.signature.value
        : userCenterEntity.value?.sigbature ?? "--";
  }

  String? avatar() {
    return isSelf()
        ? UserManager.instance.avatar.value
        : userCenterEntity.value?.avatar;
  }

  @override
  void onReady() {
    super.onReady();
    _refreshUserInfo();
  }

  void _refreshUserInfo() {
    sendRequest(RetrofitClient.instance.apiService.getTargetUserInfo(userId),
        successCallback: (value) {
          userCenterEntity.value = value!;

          /// 关注状态 0 没有关注 1 他关注我了 2 我关注他了 3 相互关注
          isAttention.value =
              value.attentionState == 2 || value.attentionState == 3;
          if (isSelf()) {
            tabs.value = [
              '创作(${value.jokesNum ?? "0"})',
              '喜欢(${value.jokeLikeNum ?? "0"})',
              '评论(${value.commentNum ?? "0"})',
              '收藏(${value.collectNum ?? "0"})'
            ];
          } else {
            tabs.value = [
              '创作(${value.jokesNum ?? "0"})',
              '喜欢(${value.jokeLikeNum ?? "0"})'
            ];
          }
        });
  }

  void jumpToPage(int index) {
    tabController.animateTo(index);
  }

  void attentionUser() {
    if (isAttention.value != null) {
      sendRequest(
          RetrofitClient.instance.apiService
              .attentionUser(isAttention.value == true ? "0" : "1", userId),
          bindViewState: false,
          needLogin: true,
          showLoadingDialog: true, successCallback: (data) {
        eventBus.fire(
            AttentionChangeEvent(userId: userId, attention: !isAttention.value!));
      });
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    attentionChangeSubscription.cancel();
    super.onClose();
  }
}
