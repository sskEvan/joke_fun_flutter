import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';

import 'user_creation_logic.dart';

/// 用户中心-创作
class UserCreationPage extends StatelessWidget {
  final String userId;
  final String? tag;

  const UserCreationPage({super.key, this.tag, this.userId = ""});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<UserCreationLogic>(tag: tag);
    logic.init(userId);
    return Column(children: [
      _tabBar(logic),
      Expanded(
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: logic.tabController,
          children: logic.navPages,
        ),
      )
    ]);
  }

  Widget _tabBar(UserCreationLogic logic) {
    return Container(
        height: 100.w,
        padding: EdgeInsets.only(left: 32.w),
        alignment: Alignment.centerLeft,
        child: TabBar(
            controller: logic.tabController,
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            indicator: UnderlineTabIndicator(
                borderRadius: BorderRadius.circular(12.w),
                insets: EdgeInsets.symmetric(horizontal: 20.w),
                borderSide:
                BorderSide(width: 44.w, color: ColorPalettes.instance.inputBackground)),
            labelPadding: const EdgeInsets.all(0),
            labelColor: ColorPalettes.instance.firstText,
            unselectedLabelColor: ColorPalettes.instance.secondText,
            labelStyle: TextStyle(fontSize: 26.w, fontWeight: FontWeight.bold),
            unselectedLabelStyle:
            TextStyle(fontSize: 26.w, fontWeight: FontWeight.normal),
            //未选中时标签的颜色
            onTap: (int index) {
              logic.jumpToPage(index); //点击标签时切换页面
            },
            tabs: logic.tabs.map((tab) {
                return Container(
                  height: 40.w,
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  alignment: Alignment.center,
                  child: Text(
                    tab,
                    textAlign: TextAlign.center,
                  ),
                );
            }).toList(),
          ),
    );
  }
}
