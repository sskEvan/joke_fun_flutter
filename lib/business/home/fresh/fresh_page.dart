import 'package:flutter/material.dart';
import 'package:get/get_instance/src/get_instance.dart';
import 'package:joke_fun_flutter/business/common/cpn_joke_item.dart';
import 'package:joke_fun_flutter/business/common/logic/video_player_controller.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state_paging.dart';

import 'fresh_logic.dart';

class FreshPage extends CpnViewStatePaging<FreshLogic> {
  FreshPage({Key? key}) : super(key: key);

  VideoListPlayerController videoController =
      GetInstance().find<VideoListPlayerController>();

  @override
  Widget buildPagingList() {
    var items = controller.dataList;
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (c, i) => CpnJokeItem(
          item: items[i],
          index: i,
          parentKey: const ValueKey("FreshPage")),
    );
  }

  @override
  void scrollNotificationCallback(ScrollNotification scrollNotification) {
    if(scrollNotification is ScrollStartNotification || scrollNotification is ScrollUpdateNotification) {
      videoController.isScrolling = true;
    } else {
      if(videoController.isScrolling = true) {
        videoController.isScrolling = false;
        videoController.updatePlayIndex();
      }
    }
  }

}
