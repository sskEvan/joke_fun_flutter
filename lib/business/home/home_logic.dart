import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/home/follow/follow_page.dart';
import 'package:joke_fun_flutter/business/home/fresh/fresh_page.dart';
import 'package:joke_fun_flutter/business/home/fun_pic/fun_pic_page.dart';
import 'package:joke_fun_flutter/common/cpn/keep_alive_wrapper.dart';
import 'package:joke_fun_flutter/common/view_state/view_state_controller.dart';

import 'pure_text/pure_text_page.dart';
import 'recommend/recommend_page.dart';



class HomeLogic extends ViewStateController with GetSingleTickerProviderStateMixin {
  RxInt index = 0.obs;

  late TabController tabController;

  final List<Widget> navPages = [
    KeepAliveWrapper(child: FollowPage()),
    KeepAliveWrapper(child: RecommendPage()),
    KeepAliveWrapper(child: FreshPage()),
    KeepAliveWrapper(child: PureTextPage()),
    KeepAliveWrapper(child: FunPicPage()),
  ];

  final List<String> tabs = ['关注', '推荐', '新鲜', '纯文', '趣图'];
  
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
        initialIndex: index.value,
        vsync: this,
        length: tabs.length);
  }

  void jumpToPage(int index) {
    this.index.value = index;
    tabController.animateTo(index);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
