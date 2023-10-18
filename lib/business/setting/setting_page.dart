import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/setting/sheet/theme_setting_sheet.dart';
import 'package:joke_fun_flutter/common/cpn/app_bar.dart';
import 'package:joke_fun_flutter/common/ext/asset_ext.dart';
import 'package:joke_fun_flutter/common/util/toast_util.dart';
import 'package:joke_fun_flutter/common/util/user_manager.dart';
import 'package:joke_fun_flutter/router/routers.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';

import 'setting_logic.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);

  final logic = Get.find<SettingLogic>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          appBar: commonAppBar(bottom: commonTitleBar(title: "设置")),
          backgroundColor: ColorPalettes.instance.background,
          body: _settingBody());
    });
  }

  Widget _settingBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _divider(),
          _commonSettingMoreItem("编辑资料", () {
            AppRoutes.jumpPage(AppRoutes.userEditCenterPage);
          }),
          _commonSettingMoreItem("账号与安全", () {
            showToast("todo...");
          }),
          _commonSettingMoreItem("隐私设置", () {
            showToast("todo...");
          }),
          _divider(),
          _commonSettingSwitchItem("视频自动播放", logic.switchVideoAutoPlay.value,
              (value) {
            logic.switchVideoAutoPlay.value = value;
            showToast("todo...");
          }),
          _commonSettingSwitchItem(
              "数据网络直接播放视频", logic.switchMobileNetworkVideoPlay.value, (value) {
            logic.switchMobileNetworkVideoPlay.value = value;
            showToast("todo...");
          }),
          _commonSettingMoreItem("清除缓存", () {
            showToast("todo...");
          }),
          _commonSettingMoreItem("主题色", () {
            showThemeSettingBottomSheet();
          },
              Container(
                  width: 36.w,
                  height: 36.w,
                  margin: EdgeInsets.only(right: 32.w),
                  color: ColorPalettes.instance.palettesStyle.value.index == 0
                      ? Colors.black
                      : ColorPalettes
                          .instance
                          .palettes[ColorPalettes.instance.palettesStyle.value]!
                          .primary)),
          _commonSettingMoreItem("关于JokeFun", () {
            _showAboutDialog();
          }),
          _divider(),
          _logoutButton()
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
        width: double.infinity,
        height: 16.w,
        color: ColorPalettes.instance.divider);
  }

  Widget _commonSettingMoreItem(String name, VoidCallback onClick,
      [Widget? subWidget]) {
    return InkWell(
      onTap: onClick,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 32.w, right: 16.w),
            height: 120.w,
            alignment: Alignment.center,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                        fontSize: 32.w,
                        color: ColorPalettes.instance.firstText),
                  ),
                ),
                (subWidget == null) ? const SizedBox.shrink() : subWidget,
                Image.asset("ic_arrow_right".webp,
                    width: 40.w,
                    height: 40.w,
                    color: ColorPalettes.instance.secondIcon),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 32.w),
              width: double.infinity,
              height: 1.w,
              color: ColorPalettes.instance.divider)
        ],
      ),
    );
  }

  Widget _commonSettingSwitchItem(
      String name, bool switchValue, ValueChanged<bool> callback) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 32.w, right: 16.w),
          height: 120.w,
          alignment: Alignment.center,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                      fontSize: 32.w, color: ColorPalettes.instance.firstText),
                ),
              ),
              CupertinoSwitch(
                // 当前 switch 的开关
                value: switchValue,
                activeColor: ColorPalettes.instance.primary,
                // 点击或者拖拽事件
                onChanged: (value) {
                  callback(value);
                },
              )
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 32.w),
            width: double.infinity,
            height: 1.w,
            color: ColorPalettes.instance.divider)
      ],
    );
  }

  void _showAboutDialog() {
    Get.dialog(Center(
      child: Center(
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: ColorPalettes.instance.background,
                borderRadius: BorderRadius.all(Radius.circular(32.w))),
            padding: EdgeInsets.symmetric(vertical: 48.w, horizontal: 32.w),
            width: 580.w,
            height: 500.w,
            child: Material(
              color: ColorPalettes.instance.background,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("关于",
                      style: TextStyle(
                          fontSize: 32.w,
                          color: ColorPalettes.instance.firstText,
                          fontWeight: FontWeight.bold)),
                  Center(
                    child: Text(
                        "JokeFun使用Flutter开发，数据源来自【MZCretin】大佬的开源项目【段子乐】，项目UI和页面跳转很大程度也借鉴了【段子乐APP】，这里特别感谢【MZCretin】大佬。仅供学习分享使用，他人如何使用与本应用无关。",
                        style: TextStyle(
                            fontSize: 28.w,
                            color: ColorPalettes.instance.secondText)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 72.w,
                      width: 400.w,
                      decoration: BoxDecoration(
                          color: ColorPalettes.instance.primary,
                          borderRadius:
                              BorderRadius.all(Radius.circular(36.w))),
                      child: Text(
                        "知道了",
                        style: TextStyle(color: Colors.white, fontSize: 30.w),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    ));
  }

  Widget _logoutButton() {
    return UserManager.instance.isLogin()
        ? Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 100.w, horizontal: 32.w),
            height: 100.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: ColorPalettes.instance.primary,
                borderRadius: BorderRadius.circular(56.w)),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                child: Text("退出登录",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.w,
                        fontWeight: FontWeight.w600)),
              ),
              onTap: () {
                showToast("todo...");
              },
            ),
          )
        : const SizedBox.shrink();
  }
}
