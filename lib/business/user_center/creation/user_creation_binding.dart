import 'package:get/get.dart';

import 'user_creation_logic.dart';

class UserCreationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserCreationLogic());
  }
}
