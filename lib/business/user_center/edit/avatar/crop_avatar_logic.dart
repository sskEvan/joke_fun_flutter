import 'dart:io';

import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/common/ext/get_ext.dart';
import 'package:joke_fun_flutter/common/util/string_util.dart';
import 'package:joke_fun_flutter/common/util/user_manager.dart';
import 'package:joke_fun_flutter/common/view_state/view_state_logic.dart';
import 'package:path_provider/path_provider.dart';

// import 'package:joke_fun_flutter/common/util/log_util.dart';
// import 'package:joke_fun_flutter/http/retrofit_client.dart';
// import 'package:qiniu_flutter_sdk/qiniu_flutter_sdk.dart';

class CropAvatarLogic extends ViewStateLogic {
  final cropController = CustomImageCropController();

  // final PutController putController = PutController();

  void uploadImage() async {
    Get.showLoading();
    final image = await cropController.onCropImage();
    if (image != null) {
      Directory documentsDir = await getApplicationDocumentsDirectory();
      Directory avatarDir = Directory('${documentsDir.path}/avatar');
      if (!avatarDir.existsSync()) {
        avatarDir.create();
      }
      String name =
          generateMd5("avatar_crop_${DateTime.now().millisecondsSinceEpoch}") +
              ".png";
      File avatarFile = File('${avatarDir.path}/$name');
      if (avatarFile.existsSync()) {
        avatarFile.delete();
      }
      avatarFile.create();
      await avatarFile.writeAsBytes(image.bytes).then((file) {
        UserManager.instance.updateAvatar(file.absolute.path);
        Get.hideLoading();
        Get.back();
      });

      // await avatarFile.writeAsBytes(image.bytes).then((file) {
      //   sendRequest(RetrofitClient.instance.apiService.getQiNiuToken(name, "1"),
      //       bindViewState: false,
      //       showLoadingDialog: false, successBlock: (value) {
      //     // 上传七牛云
      //     uploadToQiNiu(value!.token!, file);
      //   }, emptyCallback: () {
      //     Get.hideLoading();
      //   }, failCallback: () {
      //     Get.hideLoading();
      //   });
      // });
    }
  }

  // void uploadToQiNiu(String token, File file) {
  //   // 创建 storage 对象
  //   Storage storage = Storage();
  //   // 使用 storage 的 putFile 对象进行文件上传
  //   storage.putFile(file, token,
  //       options: PutOptions(
  //         // key: key,
  //         controller: putController,
  //       ))
  //     ..then((value) {
  //       _handleUploadSuccess(file);
  //       Get.hideLoading();
  //       Get.back();
  //     })
  //     ..catchError((e) {
  //       _handleUploadSuccess(file);
  //       Get.hideLoading();
  //       Get.back();
  //     });
  // }
  //
  // /// 由于不知道七牛云的key，这里实际上是上传失败的，当上传成功处理，完成正常流程
  // void _handleUploadSuccess(File file) {
  //   LogE("ssk _handleUploadSuccess path=${file.absolute.path}");
  //   UserManager.instance.updateAvatar(file.absolute.path);
  // }

  @override
  void onClose() {
    cropController.dispose();
    // putController.cancel();
    super.onClose();
  }
}
