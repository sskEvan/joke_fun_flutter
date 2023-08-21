import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state_sliver_body.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state_sliver_list.dart';

import '../../common/cpn_joke_item.dart';
import 'user_like_logic.dart';

class UserLikePage extends CpnViewStateSliverBody<UserLikeLogic> {
  UserLikePage({super.key});

  @override
  SliverList buildSliverList() {
    var items = controller.dataList;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return CpnJokeItem(
              item: items[index],
              index: index,
              parentKey: const ValueKey("UserLikePage"));
        },
        childCount: items.length,
      ),
    );
  }
  // @override
  // SliverList buildSliverList() {
  //   return SliverList(
  //     delegate: SliverChildBuilderDelegate(
  //       (context, index) {
  //         return Container(
  //           height: 50.w,
  //           child: Text("$index"),
  //         );
  //       },
  //       childCount: 100,
  //     ),
  //   );
  // }
}
