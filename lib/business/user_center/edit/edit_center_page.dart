import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/common/cpn/cpn_bottom_sheet_action_button.dart';
import 'package:joke_fun_flutter/business/user_center/edit/edit_center_logic.dart';
import 'package:joke_fun_flutter/common/cpn/app_bar.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_image.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state.dart';
import 'package:joke_fun_flutter/common/cpn/no_over_scroll_behavior.dart';
import 'package:joke_fun_flutter/common/ext/asset_ext.dart';
import 'package:joke_fun_flutter/common/ext/get_ext.dart';
import 'package:joke_fun_flutter/common/util/log_util.dart';
import 'package:joke_fun_flutter/common/util/media_util.dart';
import 'package:joke_fun_flutter/common/util/permisson_util.dart';
import 'package:joke_fun_flutter/common/util/user_manager.dart';
import 'package:joke_fun_flutter/router/routers.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';
import 'package:permission_handler/permission_handler.dart';

/// 个人信息编辑中心
class EditCenterPage extends CpnViewState<EditCenterLogic> {
  const EditCenterPage({Key? key}) : super(key: key, bindViewState: false);

  @override
  AppBar? buildAppBar() => commonAppBar(bottom: commonTitleBar(title: "个人资料"));

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 72.w,
        ),
        _avatar(context),
        SizedBox(
          height: 88.w,
        ),
        Divider(
          thickness: 16.w,
          color: ColorPalettes.instance.divider,
        ),
        _commonActionItem("昵称", UserManager.instance.nickname.value, () {
          AppRoutes.jumpPage(AppRoutes.userEditNicknamePage);
        }),
        _commonActionItem("签名", UserManager.instance.signature.value, () {
          AppRoutes.jumpPage(AppRoutes.userEditSignaturePage);
        }),
        _commonActionItem("性别", UserManager.instance.sex.value, () {
          _sexBottomSheet();
        }),
        _commonActionItem("生日", UserManager.instance.birthday.value, () {
          _birthdayBottomSheet();
        }),
      ],
    );
  }

  Widget _avatar(BuildContext context) {
    return Hero(
      tag: "user_avatar",
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _changeAvatarBottomSheet(context);
        },
        child: SizedBox(
          width: 220.w,
          height: 220.w,
          child: Stack(
            children: [
              cpnCircleImage(
                  url: decodeMediaUrl(UserManager.instance.avatar.value),
                  width: 220.w,
                  height: 220.w,
                  defaultPlaceHolderAssetName: "ic_default_avatar",
                  defaultErrorAssetName: "ic_default_avatar"),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                      margin: EdgeInsets.only(right: 8.w, bottom: 8.w),
                      alignment: Alignment.center,
                      width: 52.w,
                      height: 52.w,
                      decoration: BoxDecoration(
                          color: ColorPalettes.instance.primary,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.fromBorderSide(BorderSide(
                              color: ColorPalettes.instance.divider,
                              width: 2.w))),
                      child: Image.asset(
                        "ic_take_pic".webp,
                        width: 28.w,
                        height: 28.w,
                        color: Colors.white,
                      )))
            ],
          ),
        ),
      ),
    );
  }

  Widget _commonActionItem(String key, String? value, VoidCallback onClick) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding:
            EdgeInsets.only(left: 32.w, top: 32.w, bottom: 32.w, right: 32.w),
        child: Row(
          children: [
            Text(
              key,
              style: TextStyle(
                  fontSize: 32.w, color: ColorPalettes.instance.secondText),
            ),
            SizedBox(width: 32.w),
            Expanded(
              child: Text(
                value ?? "",
                textAlign: TextAlign.end,
                style: TextStyle(
                    fontSize: 32.w, color: ColorPalettes.instance.firstText),
              ),
            ),
            SizedBox(width: 32.w),
            Image.asset("ic_arrow_right".webp,
                width: 32.w,
                height: 32.w,
                color: ColorPalettes.instance.secondIcon),
          ],
        ),
      ),
    );
  }

  void _sexBottomSheet() {
    var data = ["男", "女"];
    logic.sex.value = UserManager.instance.sex.value.isNotEmpty
        ? UserManager.instance.sex.value
        : data[0];
    int initialIndex = max(0, data.indexOf(logic.sex.value));
    FixedExtentScrollController scrollController =
        FixedExtentScrollController(initialItem: initialIndex);
    Get.bottomSheet(
        SizedBox(
          height: 480.w,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 100.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 40.w, vertical: 16.w),
                      child: Text(
                        "请选择性别",
                        style: TextStyle(
                            fontSize: 36.w,
                            color: ColorPalettes.instance.firstText),
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        logic.updateSex();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 40.w, vertical: 16.w),
                        child: Text(
                          "完成",
                          style: TextStyle(
                              fontSize: 32.w,
                              fontWeight: FontWeight.w500,
                              color: ColorPalettes.instance.primary),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.w),
              Expanded(
                child: ScrollConfiguration(
                  behavior: NoOverScrollBehavior(),
                  child: ListWheelScrollView(
                    controller: scrollController,
                    itemExtent: 80.w,
                    diameterRatio: 1,
                    children: data
                        .map((value) => Obx(() => Container(
                              height: 72.w,
                              margin: EdgeInsets.symmetric(horizontal: 60.w),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: (value == logic.sex.value)
                                    ? ColorPalettes.instance.inputBackground
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20.w),
                              ),
                              child: Text(
                                value,
                                style: TextStyle(
                                    fontSize: 36.w,
                                    color: (value == logic.sex.value)
                                        ? ColorPalettes.instance.firstText
                                        : ColorPalettes.instance.thirdText),
                              ),
                            )))
                        .toList(),
                    onSelectedItemChanged: (value) {
                      logic.sex.value = data[value];
                      LogE(
                          "_sexBottomSheet onSelectedItemChanged--${logic.sex.value}");
                    },
                  ),
                ),
              ),
              SizedBox(height: 40.w),
            ],
          ),
        ),
        isScrollControlled: true,
        backgroundColor: ColorPalettes.instance.background,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.w),
                topRight: Radius.circular(32.w))));
  }

  void _birthdayBottomSheet() {
    String birthday = UserManager.instance.birthday.value;
    DateTime dateTime =
        birthday.isNotEmpty ? DateTime.parse(birthday) : DateTime.now();
    Get.bottomSheet(
        SizedBox(
          height: 600.w,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 100.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 40.w, vertical: 16.w),
                      child: Text(
                        "请选择出生日期",
                        style: TextStyle(
                            fontSize: 36.w,
                            color: ColorPalettes.instance.firstText),
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        logic.updateBirthday();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 40.w, vertical: 16.w),
                        child: Text(
                          "完成",
                          style: TextStyle(
                              fontSize: 32.w,
                              fontWeight: FontWeight.w500,
                              color: ColorPalettes.instance.primary),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.w),
              Expanded(
                  child: CupertinoDatePicker(
                initialDateTime: dateTime,
                mode: CupertinoDatePickerMode.date,
                dateOrder: DatePickerDateOrder.ymd,
                onDateTimeChanged: (date) {
                  LogE("onDateTimeChanged=${date}");
                  int month = date.month;
                  int day = date.day;
                  String monthStr = (month < 10) ? "0$month" : month.toString();
                  String dayStr = (day < 10) ? "0$day" : day.toString();
                  logic.birthday.value = "${date.year}-$monthStr-$dayStr";
                },
              )),
              SizedBox(height: 40.w),
            ],
          ),
        ),
        isScrollControlled: true,
        backgroundColor: ColorPalettes.instance.background,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.w),
                topRight: Radius.circular(32.w))));
  }

  void _changeAvatarBottomSheet(BuildContext context) {
    Get.bottomSheet(
        SizedBox(
          height: 374.w,
          child: Column(
            children: [
              CpnBottomSheetActionButton("相册", false, () {
                Get.hideBottomSheet();
                PermissionUtil.instance.checkPermission(
                    permissionList: [Permission.storage],
                    onSuccess: () {
                      logic.selectAvatarFromGallery(context, (imageFile) {
                        AppRoutes.jumpPage(AppRoutes.userEditCropAvatarPage,
                            arguments: imageFile);
                      });
                    });
              }),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 64.w),
                child: Container(
                    color: ColorPalettes.instance.divider, height: 2.w),
              ),
              CpnBottomSheetActionButton("拍照", false, () {
                Get.hideBottomSheet();
                PermissionUtil.instance.checkPermission(
                    permissionList: [Permission.camera],
                    onSuccess: () {
                      logic.selectAvatarFromCamera((imageFile) {
                        AppRoutes.jumpPage(AppRoutes.userEditCropAvatarPage,
                            arguments: imageFile);
                      });
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
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.w),
                topRight: Radius.circular(32.w))));
  }


}
