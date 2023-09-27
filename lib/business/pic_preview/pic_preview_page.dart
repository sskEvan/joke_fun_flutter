import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/common/cpn/cpn_bottom_sheet_action_button.dart';
import 'package:joke_fun_flutter/business/pic_preview/pic_preview_logic.dart';
import 'package:joke_fun_flutter/common/cpn/app_bar.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_image.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state.dart';
import 'package:joke_fun_flutter/common/ext/get_ext.dart';
import 'package:joke_fun_flutter/common/util/media_util.dart';
import 'package:joke_fun_flutter/common/util/permisson_util.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

/// 照片预览页面
class PicPreviewPage extends CpnViewState<PicPreviewLogic> {
  const PicPreviewPage({Key? key}) : super(key: key, bindViewState: false);

  @override
  AppBar? buildAppBar() {
    return commonAppBar(
        statusBarColor: Colors.black,
        backgroundColor: Colors.black,
        iconDark: false,
        bottom: commonTitleBar(
            title: "${logic.curIndex.value + 1}/${logic.urlList.length}",
            contentColor: Colors.white));
  }

  @override
  Color backgroundColor() => Colors.black;

  @override
  Widget buildBody(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        _showSavePicBottomSheet();
      },
      onTap: () {
        Get.back();
      },
      child: PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return _getGalleryPageOptions(logic.urlList[index]);
        },
        itemCount: logic.urlList.length,
        loadingBuilder: (context, event) => Center(
          child: SizedBox(
            width: 48.w,
            height: 48.w,
            child: CircularProgressIndicator(
              value: (event == null || event.expectedTotalBytes == 0)
                  ? 0
                  : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
            ),
          ),
        ),
        pageController: logic.pageController,
        onPageChanged: (index) {
          logic.curIndex.value = index;
        },
      ),
    );
  }

  void _showSavePicBottomSheet() {
    Get.bottomSheet(
        SizedBox(
          height: 252.w,
          child: Column(
            children: [
              CpnBottomSheetActionButton("保存到相册", false, () {
                Get.hideBottomSheet();
                PermissionUtil.instance.checkPermission(
                    permissionList: [Permission.storage],
                    onSuccess: () {
                      logic.savePic();
                    });
              }),
              Container(color: ColorPalettes.instance.divider, height: 12.w),
              CpnBottomSheetActionButton("取消", true, () {
                Get.hideBottomSheet();
              })
            ],
          ),
        ),
        isScrollControlled: true,
        backgroundColor: ColorPalettes.instance.background,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.w),
                topRight: Radius.circular(32.w))));
  }

  PhotoViewGalleryPageOptions _getGalleryPageOptions(String url) {
    return isNetworkImage(decodeMediaUrl(url))
        ? PhotoViewGalleryPageOptions(
            imageProvider: CachedNetworkImageProvider(decodeMediaUrl(url)),
            maxScale: 4.0,
            minScale: 0.15,
            heroAttributes: PhotoViewHeroAttributes(tag: url),
          )
        : PhotoViewGalleryPageOptions(
            imageProvider: FileImage(File(url)),
            maxScale: 4.0,
            minScale: 0.15,
            heroAttributes: PhotoViewHeroAttributes(tag: url),
          );
  }
}
