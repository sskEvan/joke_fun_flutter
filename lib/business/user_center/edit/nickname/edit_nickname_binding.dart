import 'package:get/get.dart';

import 'edit_nickname_logic.dart';

class EditNicknameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditNicknameLogic());
  }
}
