import 'package:get/get.dart';

import 'discovery_logic.dart';

class DiscoveryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DiscoveryLogic());
  }
}
