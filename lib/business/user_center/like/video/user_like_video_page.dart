import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joke_fun_flutter/business/common/cpn/cpn_video_cover_item.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state_sliver_body.dart';

import 'user_like_video_logic.dart';

/// 用户中心-喜欢-视频列表
class UserLikeVideoPage extends CpnViewStateSliverBody<UserLikeVideoLogic> {
  final String userId;

  UserLikeVideoPage({Key? key, this.userId = "", super.tag}) : super(key: key);

  @override
  void preInit() {
    super.preInit();
    logic.targetUserId = userId;
  }

  @override
  Widget buildSliverList() {
    var items = logic.dataList;
    return GridView.builder(
      physics: const ClampingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.75,
          mainAxisSpacing: 4.w,
          crossAxisSpacing: 4.w),
      itemCount: items.length,
      itemBuilder: (c, i) => CpnVideoCoverItem(item: items[i], index: i),
    );
  }
}
