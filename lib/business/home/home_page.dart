import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/common/ext/asset_ext.dart';
import 'package:joke_fun_flutter/router/routers.dart';

import '../../common/cpn/app_bar.dart';
import '../../theme/color_palettes.dart';
import 'home_logic.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<HomeLogic>();

    return Obx(() => Scaffold(
        appBar: commonAppBar(
            backgroundColor: ColorPalettes.instance.pure,
            bottom: PreferredSize(
                preferredSize: Size(double.infinity, 100.w),
                child: _topBar(logic))),
        backgroundColor: ColorPalettes.instance.background,
        body: TabBarView(
            controller: logic.tabController,
            children: logic.navPages,
            )));
  }

  Widget _topBar(HomeLogic logic) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(child: _tabBar(logic)),
        InkWell(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 40.w),
              child: Image.asset("ic_search".png,
                  width: 40.w,
                  height: 40.w,
                  color: ColorPalettes.instance.firstIcon)),
          onTap: () {
            Get.toNamed(AppRoutes.searchPage);
          },
        )
      ],
    );
  }

  Widget _tabBar(HomeLogic logic) {
    return TabBar(
      controller: logic.tabController,
      indicatorSize: TabBarIndicatorSize.label,
      isScrollable: false,
      indicatorColor: Colors.transparent,
      labelPadding: const EdgeInsets.all(0),
      labelColor: ColorPalettes.instance.primary,
      unselectedLabelColor: ColorPalettes.instance.secondText,
      labelStyle: TextStyle(fontSize: 36.w, fontWeight: FontWeight.bold),
      unselectedLabelStyle:
          TextStyle(fontSize: 32.w, fontWeight: FontWeight.normal),
      //未选中时标签的颜色
      onTap: (int index) {
        logic.jumpToPage(index); //点击标签时切换页面
      },
      tabs: logic.tabs.map((tab) {
        return Container(
          height: 72.w,
          alignment: Alignment.center,
          child: Text(
            tab,
            textAlign: TextAlign.center,
          ),
        );
      }).toList(),
    );
  }
}
