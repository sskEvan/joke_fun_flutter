import 'package:get/get.dart';
import 'package:get/get_core/src/get_interface.dart';
import 'package:get/get_core/src/get_main.dart';

import '../cpn/loading_dialog.dart';

extension GetExt on GetInterface {

  ///显示dialog
  showLoading() {
    if (Get.isDialogOpen != null && Get.isDialogOpen!) {
      Get.back();
    }
    Get.dialog(const LoadingDialog(),
        transitionDuration: const Duration(milliseconds: 50),
        barrierDismissible: false);
  }

  ///隐藏dialog
  hideLoading() {
    if (Get.isDialogOpen != null && Get.isDialogOpen!) {
      Get.back();
    }
  }

}