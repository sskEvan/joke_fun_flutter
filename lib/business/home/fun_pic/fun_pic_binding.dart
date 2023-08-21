import 'package:get/get.dart';

import 'fun_pic_logic.dart';

class FunPicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FunPicLogic());
  }
}
