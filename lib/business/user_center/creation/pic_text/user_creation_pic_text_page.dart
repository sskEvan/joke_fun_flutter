import 'package:flutter/material.dart';
import 'package:joke_fun_flutter/business/common/cpn/cpn_joke_item.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state_sliver_body.dart';

import 'user_creation_pic_text_logic.dart';

/// 用户中心-创作-图文
class UserCreationPicTextPage
    extends CpnViewStateSliverBody<UserCreationPicTextLogic> {
  final String userId;

  UserCreationPicTextPage({Key? key, this.userId = "", super.tag}) : super(key: key);

  

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
