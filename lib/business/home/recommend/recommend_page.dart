import 'package:flutter/material.dart';
import 'package:joke_fun_flutter/business/common/cpn/cpn_joke_item.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state_paging.dart';

import 'recommend_logic.dart';

/// 首页-HomePage-推荐
class RecommendPage extends CpnViewStatePaging<RecommendLogic> {
  RecommendPage({Key? key}) : super(key: key);

  @override
  bool autoLoadData() => true;

  @override
  Widget buildPagingList() {
    var items = logic.dataList;
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (c, i) => CpnJokeItem(
          item: items[i], index: i, logic: logic, videoPlayHelper: logic),
    );
  }

  @override
  void scrollNotificationCallback(ScrollNotification scrollNotification) {
    logic.scrollNotificationCallback(scrollNotification);
  }
}
