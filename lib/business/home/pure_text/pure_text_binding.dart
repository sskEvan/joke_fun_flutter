import 'package:get/get.dart';

import 'pure_text_logic.dart';

class PureTextBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PureTextLogic());
  }
}
