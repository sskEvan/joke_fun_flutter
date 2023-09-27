import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/user_center/collect/user_collect_logic.dart';
import 'package:joke_fun_flutter/business/user_center/comment/user_comment_logic.dart';
import 'package:joke_fun_flutter/business/user_center/creation/pic_text/user_creation_pic_text_logic.dart';
import 'package:joke_fun_flutter/business/user_center/creation/user_creation_logic.dart';
import 'package:joke_fun_flutter/business/user_center/creation/video/user_creation_video_logic.dart';
import 'package:joke_fun_flutter/business/user_center/like/pic_text/user_like_pic_text_logic.dart';
import 'package:joke_fun_flutter/business/user_center/like/user_like_logic.dart';
import 'package:joke_fun_flutter/business/user_center/like/video/user_like_video_logic.dart';

import 'user_center_logic.dart';

class UserCenterBinding extends Bindings {
  final String? tag;
  UserCenterBinding({this.tag});

  @override
  void dependencies() {
    Get.lazyPut(() => UserCreationLogic(tag: tag), tag: tag);
    Get.lazyPut(() => UserCreationPicTextLogic(), tag: tag);
    Get.lazyPut(() => UserCreationVideoLogic(), tag: tag);

    Get.lazyPut(() => UserLikeLogic(tag: tag), tag: tag);
    Get.lazyPut(() => UserLikePicTextLogic(), tag: tag);
    Get.lazyPut(() => UserLikeVideoLogic(), tag: tag);

    Get.lazyPut(() => UserCollectLogic(), tag: tag);
    Get.lazyPut(() => UserCommentLogic(), tag: tag);
    Get.lazyPut(() => UserCenterLogic(tag: tag), tag: tag);
  }
}
