import 'package:get/get.dart';

import 'edit_signature_logic.dart';

class EditSignatureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditSignatureLogic());
  }
}
