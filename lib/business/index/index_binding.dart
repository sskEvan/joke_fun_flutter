import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/common/logic/video_player_controller.dart';
import 'package:joke_fun_flutter/business/discovery/discovery_logic.dart';
import 'package:joke_fun_flutter/business/home/follow/cpn/recommend_user/recommend_user_logic.dart';
import 'package:joke_fun_flutter/business/home/follow/follow_logic.dart';
import 'package:joke_fun_flutter/business/home/fresh/fresh_logic.dart';
import 'package:joke_fun_flutter/business/home/fun_pic/fun_pic_logic.dart';
import 'package:joke_fun_flutter/business/home/home_logic.dart';
import 'package:joke_fun_flutter/business/home/pure_text/pure_text_logic.dart';
import 'package:joke_fun_flutter/business/home/recommend/recommend_logic.dart';
import 'package:joke_fun_flutter/business/message/message_logic.dart';
import 'package:joke_fun_flutter/business/my/my_logic.dart';

import 'index_logic.dart';

class IndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IndexLogic());
    Get.lazyPut(() => HomeLogic());
    Get.lazyPut(() => FollowLogic());
    Get.lazyPut(() => RecommendUserLogic());
    Get.lazyPut(() => RecommendLogic());
    Get.lazyPut(() => FreshLogic());
    Get.lazyPut(() => PureTextLogic());
    Get.lazyPut(() => FunPicLogic());
    Get.lazyPut(() => DiscoveryLogic());
    Get.lazyPut(() => MessageLogic());
    Get.lazyPut(() => MyLogic());
    Get.lazyPut(() => VideoListPlayerController());
  }
}
