import 'package:flutter/material.dart';
import 'package:joke_fun_flutter/business/common/cpn_joke_item.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state_paging.dart';

import 'fun_pic_logic.dart';

class FunPicPage extends CpnViewStatePaging<FunPicLogic> {
  FunPicPage({Key? key}) : super(key: key);


  @override
  Widget buildPagingList() {
    var items = controller.dataList;
    return ListView.builder(
      cacheExtent: 0.0,
      physics: const ClampingScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (c, i) =>
          CpnJokeItem(item: items[i], index: i),
    );
  }
}
