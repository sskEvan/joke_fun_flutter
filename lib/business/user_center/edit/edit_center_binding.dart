import 'package:get/get.dart';

import 'edit_center_logic.dart';

class EditCenterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditCenterLogic());
  }
}
