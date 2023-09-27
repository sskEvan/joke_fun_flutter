import 'package:get/get.dart';

import 'publish_logic.dart';

class PublishBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PublishLogic());
  }
}
