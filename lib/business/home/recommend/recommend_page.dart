import 'package:flutter/material.dart';
import 'package:get/get_instance/src/get_instance.dart';
import 'package:joke_fun_flutter/business/common/cpn_joke_item.dart';
import 'package:joke_fun_flutter/business/common/logic/video_player_controller.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state_paging.dart';

import 'recommend_logic.dart';


class RecommendPage extends CpnViewStatePaging<RecommendLogic> {
  RecommendPage({Key? key}) : super(key: key);

  VideoListPlayerController videoController = GetInstance().find<VideoListPlayerController>();

  @override
  Widget buildPagingList() {
    print("-------------buildPagingList---------------- \n");
    var items = controller.dataList;
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (c, i) => CpnJokeItem(item: items[i], index: i),
    );
  }

  @override
  void scrollNotificationCallback(ScrollNotification scrollNotification) {
    print("scrollNotificationCallback scrollNotification=${scrollNotification}\n");
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
