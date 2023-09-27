import 'package:flutter/material.dart';
import 'package:joke_fun_flutter/business/common/cpn/cpn_joke_item.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state_sliver_body.dart';

import 'attention_list_logic.dart';

/// 首页-HomePage-关注-关注段子列表组件
class CpnAttentionList extends CpnViewStateSliverBody<AttentionListLogic> {
  CpnAttentionList({Key? key}) : super(key: key);

  @override
  bool lazyLoadData() => true;

  @override
  Widget buildSliverList() {
    var items = logic.dataList;
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (c, i) => CpnJokeItem(
          item: items[i],
          index: i,
          logic: logic,
          videoPlayHelper: logic),
    );
  }

  @override
  void scrollNotificationCallback(ScrollNotification scrollNotification) {
    logic.scrollNotificationCallback(scrollNotification);
  }
}
