import 'package:get/get.dart';

import 'message_logic.dart';

class MessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MessageLogic());
  }
}
