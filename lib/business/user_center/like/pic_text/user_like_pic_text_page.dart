import 'package:flutter/material.dart';
import 'package:joke_fun_flutter/business/common/cpn/cpn_joke_item.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state_sliver_body.dart';

import 'user_like_pic_text_logic.dart';

/// 用户中心-喜欢-图文列表
class UserLikePicTextPage  extends CpnViewStateSliverBody<UserLikePicTextLogic> {
  final String userId;

  UserLikePicTextPage({Key? key, this.userId = "", super.tag}) : super(key: key);

  

  @override
  void preInit() {
    super.preInit();
    logic.targetUserId = userId;
  }

  @override
  Widget buildSliverList() {
    var items = logic.dataList;
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (c, i) => CpnJokeItem(item: items[i], index: i, logic: logic, showUserInfo: false),
    );
  }
}
