import 'package:get/get.dart';

import 'fresh_logic.dart';

class FreshBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FreshLogic());
  }
}
