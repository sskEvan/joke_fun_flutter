import 'package:get/get.dart';

import 'user_collect_logic.dart';

class UserCollectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserCollectLogic());
  }
}
