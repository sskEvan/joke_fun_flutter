import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joke_fun_flutter/common/ext/get_ext.dart';
import 'package:joke_fun_flutter/common/util/user_manager.dart';
import 'package:joke_fun_flutter/common/view_state/view_state_logic.dart';
import 'package:joke_fun_flutter/http/retrofit_client.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class EditCenterLogic extends ViewStateLogic {
  RxString sex = "".obs;
  RxString birthday = "".obs;

  void updateSex() {
    sendRequest(
        RetrofitClient.instance.apiService.updateUserInfo(sex.value, "3"),
        bindViewState: false,
        showLoadingDialog: true,
        emptyAsSuccess: true,
        successCallback: (value) {
          UserManager.instance.updateSex(sex.value);
          Get.hideBottomSheet();
        });
  }

  void updateBirthday() {
    sendRequest(
        RetrofitClient.instance.apiService.updateUserInfo(birthday.value, "4"),
        bindViewState: false,
        showLoadingDialog: true,
        emptyAsSuccess: true,
        successCallback: (value) {
          UserManager.instance.updateBirthday(birthday.value);
          Get.hideBottomSheet();
        });
  }

  void selectAvatarFromGallery(BuildContext context, ValueChanged<File> callback) async {
    await AssetPicker.pickAssets(context,
        pickerConfig: AssetPickerConfig(
          maxAssets: 1,
            requestType: RequestType.image,
            themeColor: ColorPalettes.instance.primary,
            textDelegate: const AssetPickerTextDelegate()))
        .then((List<AssetEntity>? list) async {
      if (list != null) {
        File? imgFile = await list[0].file;
        if (imgFile != null) {
          callback(imgFile);
        }
      }
    });
  }

  void selectAvatarFromCamera(ValueChanged<File> callback) async {
    await ImagePicker().pickImage(source: ImageSource.camera).then((value) {
      if (value != null) {
        callback(File(value.path));
      }
    });
  }
}
