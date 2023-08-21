import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joke_fun_flutter/business/common/cpn_joke_item.dart';

import '../../../common/cpn/cpn_view_state_sliver_paging.dart';
import 'cpn/recommend_user/recommend_user_page.dart';
import 'follow_logic.dart';

class FollowPage extends CpnViewStateSliverPaging<FollowLogic> {
  FollowPage({Key? key}) : super(key: key);

  @override
  Widget? buildSliverScrollHeader() {
    return const RecommendUserPage();
  }

  @override
  SliverList buildSliverList() {
    var items = controller.dataList;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return CpnJokeItem(item: items[index], index: index, parentKey: const ValueKey("FollowPage"));
        },
        childCount: items.length,
      ),
    );
  }
}
