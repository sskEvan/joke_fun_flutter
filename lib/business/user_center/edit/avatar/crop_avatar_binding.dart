import 'package:get/get.dart';

import 'crop_avatar_logic.dart';

class CropAvatarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CropAvatarLogic());
  }
}
