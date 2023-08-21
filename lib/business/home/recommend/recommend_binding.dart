import 'package:get/get.dart';

import 'recommend_logic.dart';

class RecommendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecommendLogic());
  }
}
