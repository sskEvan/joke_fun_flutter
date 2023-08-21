import 'package:get/get.dart';

import 'user_comment_logic.dart';

class UserCommentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserCommentLogic());
  }
}
