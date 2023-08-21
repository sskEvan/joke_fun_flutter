import 'package:get/get.dart';

import 'user_like_logic.dart';

class UserLikeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserLikeLogic());
  }
}
