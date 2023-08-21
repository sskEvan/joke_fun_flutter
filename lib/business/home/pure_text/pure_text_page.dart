import 'package:flutter/material.dart';
import 'package:joke_fun_flutter/business/common/cpn_joke_item.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state_paging.dart';

import 'pure_text_logic.dart';

class PureTextPage extends CpnViewStatePaging<PureTextLogic> {
   PureTextPage({Key? key}) : super(key: key);

  @override
  Widget buildPagingList() {
    var items = controller.dataList;
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (c, i) =>
          CpnJokeItem(item: items[i], index: i),
    );
  }

}
