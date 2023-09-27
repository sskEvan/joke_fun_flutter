import 'package:flutter/material.dart';
import 'package:joke_fun_flutter/business/common/cpn/cpn_joke_item.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state_sliver_body.dart';

import 'user_collect_logic.dart';

/// 用户中心-收藏
class UserCollectPage extends CpnViewStateSliverBody<UserCollectLogic> {
  UserCollectPage({super.key, super.tag});

  @override
  Widget buildSliverList() {
    var items = logic.dataList;
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (c, i) =>
          CpnJokeItem(item: items[i], index: i, logic: logic),
    );
  }
}
