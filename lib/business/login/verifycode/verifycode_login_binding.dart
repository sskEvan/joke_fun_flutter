import 'package:get/get.dart';

import 'verifycode_login_logic.dart';

class VerifyCodeLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerifyCodeLoginLogic());
  }
}
