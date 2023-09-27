import 'package:flutter/material.dart';
import 'package:joke_fun_flutter/business/common/cpn/cpn_joke_item.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state_paging.dart';

import 'fun_pic_logic.dart';

/// 首页-HomePage-趣图
class FunPicPage extends CpnViewStatePaging<FunPicLogic> {
  FunPicPage({Key? key}) : super(key: key);

  @override
  bool autoLoadData() => true;

  @override
  Widget buildPagingList() {
    var items = logic.dataList;
    return ListView.builder(
      cacheExtent: 0.0,
      physics: const ClampingScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (c, i) =>
          CpnJokeItem(item: items[i], index: i, logic: logic),
    );
  }
}
