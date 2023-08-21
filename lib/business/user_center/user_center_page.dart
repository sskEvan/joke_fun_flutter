import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/user_center/user_center_logic.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_sliver_page.dart';
import 'package:joke_fun_flutter/common/ext/asset_ext.dart';
import 'package:joke_fun_flutter/models/user_info_entity.dart';
import 'package:joke_fun_flutter/router/routers.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../common/cpn/cpn_image.dart';
import '../../common/util/media_util.dart';
import '../../common/util/user_manager.dart';
import '../../models/login_entity.dart';

class UserCenterPage extends CpnSliverPage {
  UserCenterPage({Key? key}) : super(key: key);

  final controller = Get.find<UserCenterLogic>();
  final expandedHeight = 660.w;
  double nicknameWidgetBottom = 0.0;

  @override
  Widget buildSliverAppBar(BuildContext context) {
    final titleBarBottom = MediaQuery.of(context).padding.top + 88.w;
    scrollController.addListener(() {
      double maxScrollOffset = nicknameWidgetBottom - titleBarBottom;
      double fraction =
          max(0, min(1, scrollController.offset / maxScrollOffset));
      controller.titleBarAlpha.value = fraction;
      controller.updateScrollOffset(scrollController.offset);
    });
    controller.scrollController = scrollController;
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
                .withOpacity(controller.titleBarAlpha.value),
          ),
          flexibleSpace: _flexibleSpace(context),
          bottom: PreferredSize(
              preferredSize: Size(double.infinity, 100.w), child: _tabBar())
      );
    });
  }

  Widget _titleBar() {
    User? user = UserManager().loginEntity.value?.userInfo;
    return PreferredSize(
        preferredSize: Size(double.infinity, 88.w),
        child: Container(
          width: double.infinity,
          height: 88.w,
          color: ColorPalettes.instance.pure
              .withOpacity(controller.titleBarAlpha.value),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 32.w),
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset("ic_back".webp,
                      width: 40.w,
                      height: 40.w,
                      color: Color.fromARGB(
                          255,
                          255 - (255 * controller.titleBarAlpha.value).toInt(),
                          255 - (255 * controller.titleBarAlpha.value).toInt(),
                          255 -
                              (255 * controller.titleBarAlpha.value).toInt()))),
              SizedBox(width: 32.w),
              Opacity(
                opacity: controller.titleBarAlpha.value,
                child: Row(
                  children: [
                    cpnCircleBorderNetworkImage(
                        url: decodeMediaUrl(user?.avatar),
                        border: Border.fromBorderSide(BorderSide(
                            color: ColorPalettes.instance.primary, width: 2.w)),
                        size: 60.w,
                        defaultPlaceHolderAssetName: "ic_default_avatar",
                        defaultErrorAssetName: "ic_default_avatar"),
                    SizedBox(
                      width: 16.w,
                    ),
                    Text(
                      user?.nickname ?? "",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 32.w,
                          color: ColorPalettes.instance.firstText),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _flexibleSpace(BuildContext context) {
    return FlexibleSpaceBar(
      collapseMode: CollapseMode.pin,
      background: Stack(
        children: [
          _blurBackground(),
          _cardBackground(),
          _flexibleContent(context)
        ],
      ),
    );
  }

  Widget _blurBackground() {
    User? user = UserManager().loginEntity.value?.userInfo;
    return SizedBox(
      width: double.infinity,
      height: 360.w,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 30.w, sigmaY: 30.w),
        child: cpnNetworkImage(
            url: decodeMediaUrl(user?.avatar),
            width: 360.w,
            height: 360.w,
            defaultPlaceHolderAssetName: "ic_default_avatar",
            defaultErrorAssetName: "ic_default_avatar"),
      ),
    );
  }

  Widget _cardBackground() {
    return Container(
        margin: EdgeInsets.only(top: 290.w),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: ColorPalettes.instance.pure,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.w),
                topRight: Radius.circular(32.w))));
  }

  Widget _flexibleContent(BuildContext context) {
    User? user = UserManager().loginEntity.value?.userInfo;
    UserInfo? userInfo = Get.arguments;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 56.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VisibilityDetector(
                key: const Key("user_Center_page"),
                onVisibilityChanged: (VisibilityInfo info) {
                  if (info.visibleBounds.bottom > 0) {
                    nicknameWidgetBottom = info.visibleBounds.bottom;
                  }
                },
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 220.w),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Hero(
                            tag: "user_avatar",
                            child: cpnCircleBorderNetworkImage(
                                url: decodeMediaUrl(user?.avatar),
                                border: Border.fromBorderSide(BorderSide(
                                    color: ColorPalettes.instance.primary,
                                    width: 4.w)),
                                size: 180.w,
                                defaultPlaceHolderAssetName: "ic_default_avatar",
                                defaultErrorAssetName: "ic_default_avatar"),
                          ),
                          _editButton()
                        ],
                      ),
                      SizedBox(height: 16.w),
                      Text(
                        user?.nickname ?? "",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 44.w,
                            color: ColorPalettes.instance.firstText),
                      ),
                    ]),
              ),
              SizedBox(
                height: 16.w,
              ),
              Text(
                user?.signature ?? "期待您的创作～",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 26.w,
                    color: ColorPalettes.instance.firstText),
              ),
              SizedBox(
                height: 32.w,
              ),
              Row(
                children: [
                  _userAttributesItem("关注", userInfo?.attentionNum),
                  SizedBox(width: 48.w),
                  _userAttributesItem("粉丝", userInfo?.fansNum),
                  SizedBox(width: 48.w),
                  _userAttributesItem("乐豆", userInfo?.experienceNum),
                ],
              ),
              SizedBox(
                height: 32.w,
              ),
            ],
          ),
        ),
        Container(
          height: 12.w,
          color: ColorPalettes.instance.divider,
        ),
      ],
    );
  }

  Widget _userAttributesItem(String name, int? count) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${count ?? "--"}",
          style: TextStyle(
              fontSize: 32.w, color: ColorPalettes.instance.firstText),
        ),
        SizedBox(width: 16.w),
        Text(
          name,
          style: TextStyle(
              fontSize: 28.w, color: ColorPalettes.instance.secondText),
        ),
      ],
    );
  }

  Widget _editButton() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.userEditCenterPage);
      },
      child: Container(
        margin: EdgeInsets.only(top: 80.w),
        width: 160.w,
        height: 56.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: ColorPalettes.instance.secondary,
            borderRadius: BorderRadius.circular(28.w)),
        child: Text(
          "编辑资料",
          style: TextStyle(fontSize: 28.w, color: Colors.white),
        ),
      ),
    );
  }

  Widget _tabBar() {
    return TabBar(
      controller: controller.tabController,
      indicatorSize: TabBarIndicatorSize.tab,
      isScrollable: false,
      indicator: UnderlineTabIndicator(
          borderRadius: BorderRadius.circular(4.w),
          insets: EdgeInsets.symmetric(horizontal: 72.w),
          borderSide:
              BorderSide(width: 4.w, color: ColorPalettes.instance.primary)),
      labelPadding: const EdgeInsets.all(0),
      labelColor: ColorPalettes.instance.primary,
      unselectedLabelColor: ColorPalettes.instance.secondText,
      labelStyle: TextStyle(fontSize: 36.w, fontWeight: FontWeight.bold),
      unselectedLabelStyle:
          TextStyle(fontSize: 32.w, fontWeight: FontWeight.normal),
      //未选中时标签的颜色
      onTap: (int index) {
        controller.jumpToPage(index); //点击标签时切换页面
      },
      tabs: controller.tabs.map((tab) {
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

  @override
  Widget buildSliverBody(BuildContext context) {
    controller.tabController.addListener(() {

    });
    return TabBarView(
      controller: controller.tabController,
      children: controller.navPages,
    );
  }
}
