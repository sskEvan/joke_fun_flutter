import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:joke_fun_flutter/common/ext/asset_ext.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';

AppBar commonAppBar(
    {Color statusBarColor = Colors.transparent,
    Color? backgroundColor,
    bool iconDark = true,
    PreferredSizeWidget? bottom}) {
  var isDarkStyle = ColorPalettes.instance.isDark();
  return AppBar(
    elevation: 0,
    toolbarHeight: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: (iconDark == true && !isDarkStyle)
          ? Brightness.dark
          : Brightness.light,
    ),
    backgroundColor: backgroundColor ?? ColorPalettes.instance.background,
    bottom: bottom,
  );
}

SliverAppBar commonSliverAppBar(
    {Color statusBarColor = Colors.transparent,
    Color? backgroundColor,
    bool iconDark = true,
    // Widget? leading,
    // double? leadingWidth,
    Widget? title,
    SystemUiOverlayStyle? systemUiOverlayStyle,
    double? toolbarHeight,
    double? expandedHeight,
    Widget? flexibleSpace,
    PreferredSizeWidget? bottom}) {
  var isDarkStyle = ColorPalettes.instance.isDark();
  return SliverAppBar(
    elevation: 0,
    automaticallyImplyLeading: false,
    // leading: leading,
    // leadingWidth: leadingWidth,
    titleSpacing: 0,
    toolbarHeight: toolbarHeight ?? 88.w,
    expandedHeight: expandedHeight ?? 240.w,
    title: title,
    pinned: true,
    systemOverlayStyle: systemUiOverlayStyle,
    flexibleSpace: flexibleSpace,
    backgroundColor: backgroundColor ?? ColorPalettes.instance.background,
    bottom: bottom,
  );
}

PreferredSizeWidget? commonTitleBar({
  String leftIcon = "ic_back",
  String title = "",
  String? rightIcon,
  String? rightText,
  Widget? rightWidget,
  GestureTapCallback? leftClick,
  GestureTapCallback? rightClick,
}) {
  Widget? right;
  if (rightText != null || rightIcon != null) {
    right = Container(
      width: 160.w,
      alignment: Alignment.centerRight,
      child: GestureDetector(
          onTap: rightClick,
          child: (rightIcon != null)
              ? Image.asset(rightIcon.webp, width: 40.w, height: 40.w)
              : Text(rightText!,
                  style: TextStyle(
                      color: ColorPalettes.instance.secondText,
                      fontSize: 32.w))),
    );
  } else {
    right = (rightWidget != null)
        ? Container(
            width: 160.w, alignment: Alignment.centerRight, child: rightWidget)
        : Container(width: 160.w);
  }
  return PreferredSize(
      preferredSize: Size(double.infinity, 88.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 32.w),
          Container(
              alignment: Alignment.centerLeft,
              width: 160.w,
              child: GestureDetector(
                  onTap: leftClick ?? Get.back,
                  child: Image.asset(leftIcon.webp,
                      width: 40.w,
                      height: 40.w,
                      color: ColorPalettes.instance.firstIcon))),
          Expanded(
              child: Center(
                  child: Text(title,
                      style: TextStyle(
                          color: ColorPalettes.instance.firstText,
                          fontSize: 36.w,
                          fontWeight: FontWeight.w500)))),
          right,
          SizedBox(width: 32.w),
        ],
      ));
}

void updateStatusBarColor(Color color, bool iconDark) {
  var isDarkStyle = ColorPalettes.instance.isDark();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color,
      statusBarIconBrightness: (iconDark == true && !isDarkStyle)
          ? Brightness.dark
          : Brightness.light));
}
