import 'package:get/get.dart';

import 'pic_preview_logic.dart';

class PicPreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PicPreviewLogic());
  }
}
