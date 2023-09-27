import 'package:flutter/material.dart';
import 'package:joke_fun_flutter/business/common/cpn/cpn_joke_item.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state_paging.dart';

import 'pure_text_logic.dart';

/// 首页-HomePage-纯文
class PureTextPage extends CpnViewStatePaging<PureTextLogic> {
   PureTextPage({Key? key}) : super(key: key);

   @override
  bool autoLoadData() => true;

  @override
  Widget buildPagingList() {
    var items = logic.dataList;
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (c, i) =>
          CpnJokeItem(item: items[i], index: i, logic: logic),
    );
  }

}
