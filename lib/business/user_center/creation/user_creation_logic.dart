import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/user_center/creation/pic_text/user_creation_pic_text_page.dart';
import 'package:joke_fun_flutter/business/user_center/creation/video/user_creation_video_page.dart';
import 'package:joke_fun_flutter/common/cpn/keep_alive_wrapper.dart';

class UserCreationLogic extends GetxController
    with GetTickerProviderStateMixin {
  RxInt index = 0.obs;
  late TabController tabController;
  late String userId;
  final List<String> tabs = ["文字&图片", "视频"];
  late List<Widget> navPages;
  final String? tag;

  UserCreationLogic({this.tag});

  void init(String userId) {
    this.userId = userId;
    tabController = TabController(
        initialIndex: index.value, vsync: this, length: tabs.length);

    navPages = [
      KeepAliveWrapper(child: UserCreationPicTextPage(userId: userId, tag: tag)),
      KeepAliveWrapper(child: UserCreationVideoPage(userId: userId, tag: tag)),
    ];
  }

  void jumpToPage(int index) {
    this.index.value = index;
    tabController.animateTo(index);
  }
}
