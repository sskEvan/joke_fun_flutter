import 'package:get/get.dart';

import 'my_logic.dart';

class MyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyLogic());
  }
}
