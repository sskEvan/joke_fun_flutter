import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/user_center/collect/user_collect_logic.dart';
import 'package:joke_fun_flutter/business/user_center/comment/user_comment_logic.dart';
import 'package:joke_fun_flutter/business/user_center/creation/user_creation_logic.dart';
import 'package:joke_fun_flutter/business/user_center/like/user_like_logic.dart';

import 'user_center_logic.dart';

class UserCenterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserCenterLogic());
    Get.lazyPut(() => UserLikeLogic());
    Get.lazyPut(() => UserCollectLogic());
    Get.lazyPut(() => UserCreationLogic());
    Get.lazyPut(() => UserCommentLogic());
  }
}
