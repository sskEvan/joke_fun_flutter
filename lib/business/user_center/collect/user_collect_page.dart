import 'package:flutter/material.dart';
import 'package:joke_fun_flutter/business/common/cpn_joke_item.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state_sliver_body.dart';

import 'user_collect_logic.dart';

class UserCollectPage extends CpnViewStateSliverBody<UserCollectLogic> {
  UserCollectPage({super.key});

  @override
  SliverList buildSliverList() {
    var items = controller.dataList;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return CpnJokeItem(
              item: items[index],
              index: index,
              parentKey: const ValueKey("UserCollectPage"));
        },
        childCount: items.length,
      ),
    );
  }
}
