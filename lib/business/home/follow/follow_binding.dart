import 'package:get/get.dart';

import 'follow_logic.dart';

class FollowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FollowLogic());
  }
}
