import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/common/cpn/cpn_bottom_sheet_action_button.dart';
import 'package:joke_fun_flutter/common/ext/get_ext.dart';
import 'package:joke_fun_flutter/common/util/toast_util.dart';

import '../../../theme/color_palettes.dart';

/// 显示段子更多操作底部弹框
void showJokeMoreSheet() {
  Get.bottomSheet(
      SizedBox(
        height: 496.w,
        child: Column(
          children: [
            CpnBottomSheetActionButton("举报发布者", false, () {
              showToast("todo...");
              Get.hideBottomSheet();
            }),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 64.w),
              child:
                  Container(color: ColorPalettes.instance.divider, height: 2.w),
            ),
            CpnBottomSheetActionButton("举报此内容", false, () {
              showToast("todo...");
              Get.hideBottomSheet();
            }),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 64.w),
              child:
                  Container(color: ColorPalettes.instance.divider, height: 2.w),
            ),
            CpnBottomSheetActionButton("对此不感兴趣", false, () {
              showToast("todo...");
              Get.hideBottomSheet();
            }),
            Container(color: ColorPalettes.instance.divider, height: 12.w),
            CpnBottomSheetActionButton("取消", true, () {
              showToast("todo...");
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
