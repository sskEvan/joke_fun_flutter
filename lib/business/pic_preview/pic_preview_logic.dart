import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:joke_fun_flutter/common/cpn/app_bar.dart';
import 'package:joke_fun_flutter/common/util/media_util.dart';
import 'package:joke_fun_flutter/common/util/string_util.dart';
import 'package:joke_fun_flutter/common/util/toast_util.dart';
import 'package:joke_fun_flutter/common/view_state/view_state_logic.dart';
import 'package:path_provider/path_provider.dart';

class PicPreviewLogic extends ViewStateLogic {
  late PageController pageController;
  late List<String> urlList;
  late int initialIndex;
  RxInt curIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic> arguments = Get.arguments;
    urlList = arguments["urlList"];
    initialIndex = arguments["index"];
    curIndex.value = initialIndex;
    pageController = PageController(initialPage: initialIndex);
  }

  @override
  void onClose() {
    pageController.dispose();
    updateStatusBarColor(Colors.transparent, true);
    super.onClose();
  }

  void savePic() async {
    try {
      String url = decodeMediaUrl(urlList[curIndex.value]);
      Directory documentsDir = await getApplicationDocumentsDirectory();
      Directory galleryDir = Directory('${documentsDir.path}/gallery');
      if (!galleryDir.existsSync()) {
        galleryDir.create();
      }
      String name = generateMd5(url);
      File picFile = File('${galleryDir.path}/$name');
      if (picFile.existsSync()) {
        picFile.delete();
      }
      picFile.create();
      final response = await Dio().download(url, picFile.path);
      debugPrint("response==> $response,statusCode=${response.statusCode}");
      if (response.statusCode == 200) {
        Map<dynamic, dynamic> result = await ImageGallerySaver.saveFile(picFile.path,
            isReturnPathOfIOS: true);
        debugPrint("result==>   $result");
        if (result["isSuccess"] == true) {
          showToast("保存成功");
        } else {
          showToast("保存失败");
        }
      } else {
        showToast("保存失败");
      }
    } catch(e) {
      showToast("保存失败");
    }
  }
}
