import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/user_center/experience/cpn/list/experience_list_page.dart';
import 'package:joke_fun_flutter/business/user_center/experience/cpn/overview/cpn_experience_overview.dart';
import 'package:joke_fun_flutter/business/user_center/experience/experience_logic.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_nested_page.dart';
import 'package:joke_fun_flutter/common/ext/asset_ext.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';

/// 我的乐豆页面
class ExperiencePage extends CpnNestedPage<ExperienceLogic> {
  ExperiencePage({Key? key}) : super(key: key);

  var expandedHeight = 680.w;

  @override
  Widget buildNestedHeader(BuildContext context) {
    scrollController.addListener(() {
      double fraction = min(1, scrollController.offset / expandedHeight);
      logic.titleBarAlpha.value = fraction;
    });
    return Obx(() {
      return SliverAppBar(
          toolbarHeight: 88.w,
          backgroundColor: ColorPalettes.instance.pure,
          expandedHeight: expandedHeight,
          title: _titleBar(),
          automaticallyImplyLeading: false,
          pinned: true,
          elevation: 0,
          titleSpacing: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorPalettes.instance.pure
                .withOpacity(logic.titleBarAlpha.value),
          ),
          flexibleSpace: _flexibleSpace(context),
          bottom: PreferredSize(
              preferredSize: Size(double.infinity, 80.w),
              child: _experienceListHeader()));
    });
  }

  Widget _titleBar() {
    return PreferredSize(
        preferredSize: Size(double.infinity, 88.w),
        child: Container(
          width: double.infinity,
          height: 88.w,
          color: ColorPalettes.instance.pure
              .withOpacity(logic.titleBarAlpha.value),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 48.w),
              GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset("ic_back".webp,
                      width: 40.w,
                      height: 40.w,
                      color: Color.fromARGB(
                          255,
                          255 - (255 * logic.titleBarAlpha.value).toInt(),
                          255 - (255 * logic.titleBarAlpha.value).toInt(),
                          255 - (255 * logic.titleBarAlpha.value).toInt()))),
              SizedBox(width: 32.w),
              Opacity(
                opacity: logic.titleBarAlpha.value,
                child: Text(
                  "我的乐豆",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 36.w,
                      color: ColorPalettes.instance.firstText),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _flexibleSpace(BuildContext context) {
    return const FlexibleSpaceBar(
      collapseMode: CollapseMode.pin,
      background: CpnExperienceOverview(),
    );
  }

  Widget _experienceListHeader() {
    return Container(
      height: 80.w,
      color: ColorPalettes.instance.inputBackground,
      padding: EdgeInsets.symmetric(horizontal: 48.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("时间",
              style: TextStyle(
                  fontSize: 28.w, color: ColorPalettes.instance.firstText)),
          Text("明细",
              style: TextStyle(
                  fontSize: 28.w, color: ColorPalettes.instance.firstText)),
          Text("说明",
              style: TextStyle(
                  fontSize: 28.w, color: ColorPalettes.instance.firstText))
        ],
      ),
    );
  }

  @override
  Widget buildNestedBody(BuildContext context) {
    return CpnExperienceList();
  }

  @override
  double pinnedHeaderHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top + 88.w + 80.w;
  }
}
