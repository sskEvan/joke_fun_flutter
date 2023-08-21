import 'package:get/get.dart';

import 'recommend_user_logic.dart';

class RecommendUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecommendUserLogic());
  }
}
