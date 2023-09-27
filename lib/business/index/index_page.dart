import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/common/ext/asset_ext.dart';
import 'package:joke_fun_flutter/router/routers.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';
import 'package:lottie/lottie.dart';

import 'index_logic.dart';

/// 首页
class IndexPage extends StatelessWidget {
  IndexPage({Key? key}) : super(key: key);

  final List<BottomNavigationBarItem> bottomNavigationBarItems = [
    _customBottomNavigationBarItem("nav_home".png, "nav_home".lottie, "主页"),
    _customBottomNavigationBarItem(
        "nav_discovery".png, "nav_discovery".lottie, "发现"),
    _customBottomNavigationBarItem(null, null, "发布"),
    _customBottomNavigationBarItem(
        "nav_message".png, "nav_message".lottie, "消息"),
    _customBottomNavigationBarItem("nav_my".png, "nav_my".lottie, "我的"),
  ];

  static BottomNavigationBarItem _customBottomNavigationBarItem(
      String? defaultImage, String? activeImage, String label) {
    return BottomNavigationBarItem(
        icon: defaultImage == null
            ? const Icon(null)
            : Image.asset(defaultImage,
                width: 44.w,
                height: 44.w,
                color: ColorPalettes.instance.secondIcon),
        activeIcon: activeImage == null
            ? const Icon(null)
            : Obx(() {
                return RepaintBoundary(
                  child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        // Color(0xFFF0484E),
                        ColorPalettes.instance.primary,
                        BlendMode.srcIn,
                      ),
                      child: Lottie.asset(activeImage,
                          repeat: false, width: 44.w, height: 44.w)),
                );
              }),
        label: label);
  }

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<IndexLogic>();

    return Obx(() => Scaffold(
          body: PageView(
            controller: logic.pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: logic.navPages,
          ),
          backgroundColor: const Color(0xFFEEEEEE),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
          //要实现中间的按钮凸起效果，这行起作用
          bottomNavigationBar: BottomNavigationBar(
            elevation: 8.0,
            backgroundColor: ColorPalettes.instance.background,
            type: BottomNavigationBarType.fixed,
            currentIndex: logic.index.value,
            fixedColor: ColorPalettes.instance.primary,
            unselectedItemColor: ColorPalettes.instance.secondText,
            items: bottomNavigationBarItems,
            onTap: (int index) {
              logic.navigate(index);
            },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: ColorPalettes.instance.primary,
            elevation: 8.0,
            child: Image.asset("nav_push".png,
                width: 72.w, height: 72.w, color: Colors.white),
            onPressed: () {
              AppRoutes.jumpPage(AppRoutes.publishPage, needLogin: true);
            },
          ),
        ));
  }
}
