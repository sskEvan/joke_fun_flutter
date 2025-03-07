import 'dart:io';

import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/common/cpn/app_bar.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_default_view_state.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state.dart';

import 'crop_avatar_logic.dart';

/// 裁剪上传头像页面
class CropAvatarPage extends CpnViewState<CropAvatarLogic> {
  const CropAvatarPage({Key? key}) : super(key: key, bindViewState: false);

  @override
  AppBar? buildAppBar() => commonAppBar(
      bottom: commonTitleBar(
          title: "上传头像",
          rightText: "完成",
          rightClick: () {
            logic.uploadImage();
          }));

  @override
  Widget buildBody(BuildContext context) {
    File originImageFile = Get.arguments;
    return CustomImageCrop(
      cropController: logic.cropController,
      shape: CustomCropShape.Square,
      cropPercentage: 0.75,
      canRotate: false,
      imageFit: CustomImageFit.fillVisibleWidth,
      customProgressIndicator: defaultLoadingWidget(),
      image: FileImage(originImageFile),
    );
  }
}
