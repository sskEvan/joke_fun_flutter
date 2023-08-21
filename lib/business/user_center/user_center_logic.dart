import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/user_center/collect/user_collect_page.dart';
import 'package:joke_fun_flutter/business/user_center/comment/user_comment_page.dart';
import 'package:joke_fun_flutter/business/user_center/creation/user_creation_page.dart';
import 'package:joke_fun_flutter/business/user_center/like/user_like_page.dart';
import 'package:joke_fun_flutter/common/cpn/keep_alive_wrapper.dart';
import 'package:joke_fun_flutter/common/util/log_util.dart';
import 'package:joke_fun_flutter/common/view_state/view_state_controller.dart';

class UserCenterLogic extends ViewStateController
    with GetSingleTickerProviderStateMixin {
  RxInt index = 0.obs;
  late TabController tabController;
  final List<String> tabs = ['创作', '喜欢', '评论', '收藏'];
  final titleBarAlpha = 0.0.obs;

  final Map<int, double> _scrollOffsetMap = {};
  ScrollController? scrollController;

  List<Widget> navPages = [
    KeepAliveWrapper(child: UserCreationPage()),
    KeepAliveWrapper(child: UserLikePage()),
    KeepAliveWrapper(child: UserCommentPage()),
    KeepAliveWrapper(child: UserCollectPage()),
  ];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
        initialIndex: index.value, vsync: this, length: tabs.length);
    tabController.addListener(_tabControllerListener);
  }

  @override
  void onClose() {
    super.onClose();
    tabController.removeListener(_tabControllerListener);
    tabController.dispose();
  }

  void _tabControllerListener() {
    index.value = tabController.index;
    LogE("_tabControllerListener change....index=${index}");
    scrollController?.jumpTo(_scrollOffsetMap[index.value] ?? 0.0);
  }

  void jumpToPage(int index) {
    this.index.value = index;
    tabController.animateTo(index);
  }

  void updateScrollOffset(double offset) {
    _scrollOffsetMap[index.value] = offset;
  }

}
