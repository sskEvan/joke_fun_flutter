import 'package:get/get.dart';

import 'setting_logic.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingLogic());
  }
}
