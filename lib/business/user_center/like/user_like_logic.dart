import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/user_center/like/pic_text/user_like_pic_text_page.dart';
import 'package:joke_fun_flutter/business/user_center/like/video/user_like_video_page.dart';
import 'package:joke_fun_flutter/common/cpn/keep_alive_wrapper.dart';

class UserLikeLogic extends GetxController
    with GetTickerProviderStateMixin {
  RxInt index = 0.obs;
  late TabController tabController;
  late String userId;
  final List<String> tabs = ["文字&图片", "视频"];
  late List<Widget> navPages;
  final String? tag;

  UserLikeLogic({this.tag});


  void init(String userId) {
    this.userId = userId;
    tabController = TabController(
        initialIndex: index.value, vsync: this, length: tabs.length);

    navPages = [
      KeepAliveWrapper(child: UserLikePicTextPage(userId: userId, tag: tag)),
      KeepAliveWrapper(child: UserLikeVideoPage(userId: userId, tag: tag)),
    ];
    super.onInit();
  }

  void jumpToPage(int index) {
    this.index.value = index;
    tabController.animateTo(index);
  }
}
