import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:joke_fun_flutter/business/setting/setting_logic.dart';
import 'package:joke_fun_flutter/common/ext/asset_ext.dart';
import 'package:joke_fun_flutter/common/ext/get_ext.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';

/// app主题色设置底部弹框
void showThemeSettingBottomSheet() {
  final logic = Get.find<SettingLogic>();
  List<Widget> children = [];
  children.addAll(logic.palettesStyles
      .map((element) => _themeSettingItem(element))
      .toList());
  Get.bottomSheet(
      Column(
        children: [
          _themeSettingTitle(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: children,
              ),
            ),
          )
        ],
      ),
      backgroundColor: ColorPalettes.instance.background,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.w),
              topRight: Radius.circular(32.w))));
}

Widget _themeSettingTitle() {
  return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 32.w),
      height: 100.w,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "主题色设置",
              style: TextStyle(
                  fontSize: 32.w, color: ColorPalettes.instance.firstText),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                Get.hideBottomSheet();
              },
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Image.asset(
                  "ic_close".webp,
                  width: 32.w,
                  height: 32.w,
                  color: ColorPalettes.instance.firstIcon,
                ),
              ),
            ),
          )
        ],
      ));
}

Widget _themeSettingItem(PalettesStyle palettesStyle) {
  final logic = Get.find<SettingLogic>();
  bool isSelected = palettesStyle.index == logic.curPalettesIndex.value;
  return InkWell(
    onTap: () {
      logic.changeTheme(palettesStyle);
      Get.hideBottomSheet();
    },
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 48.w),
      child: Column(
        children: [
          Container(
            height: 100.w,
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 48.w,
                    height: 48.w,
                    color: palettesStyle.index == 0
                        ? Colors.black
                        : ColorPalettes
                            .instance.palettes[palettesStyle]!.primary),
                const Expanded(child: SizedBox()),
                isSelected
                    ? Image.asset("ic_check".webp,
                        width: 40.w,
                        height: 40.w,
                        color: ColorPalettes
                            .instance.palettes[palettesStyle]!.primary)
                    : const SizedBox.shrink()
              ],
            ),
          ),
          Container(color: ColorPalettes.instance.divider, height: 1.w)
        ],
      ),
    ),
  );
}
