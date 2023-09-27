import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/user_center/user_center_logic.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_image.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_nested_page.dart';
import 'package:joke_fun_flutter/common/ext/asset_ext.dart';
import 'package:joke_fun_flutter/common/util/media_util.dart';
import 'package:joke_fun_flutter/router/routers.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// 用户中心页面
class UserCenterPage extends CpnNestedPage<UserCenterLogic> {
  UserCenterPage({super.key, super.tag});

  final expandedHeight = 660.w;
  double nicknameWidgetBottom = 0.0;

  @override
  Widget buildNestedHeader(BuildContext context) {
    final titleBarBottom = MediaQuery.of(context).padding.top + 88.w;
    scrollController.addListener(() {
      double maxScrollOffset = nicknameWidgetBottom - titleBarBottom;
      double fraction =
          max(0, min(1, scrollController.offset / maxScrollOffset));
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
              preferredSize: Size(double.infinity, 100.w), child: _tabBar()));
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
              SizedBox(width: 32.w),
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
                child: Row(
                  children: [
                    cpnCircleBorderImage(
                        url: decodeMediaUrl(logic.avatar()),
                        border: Border.fromBorderSide(BorderSide(
                            color: ColorPalettes.instance.primary, width: 2.w)),
                        size: 60.w,
                        defaultPlaceHolderAssetName: "ic_default_avatar",
                        defaultErrorAssetName: "ic_default_avatar"),
                    SizedBox(
                      width: 16.w,
                    ),
                    Text(
                      logic.nickName(),
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
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 30.w, sigmaY: 30.w),
        child: cpnImage(
            url: decodeMediaUrl(logic.avatar()),
            width: double.infinity,
            height: double.infinity,
            boxFit: BoxFit.fitWidth,
            defaultPlaceHolderAssetName: "ic_default_avatar",
            defaultErrorAssetName: "ic_default_avatar"),
      ),
    );
  }

  Widget _cardBackground() {
    return Container(
        margin: EdgeInsets.only(top: 280.w),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: ColorPalettes.instance.pure,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.w),
                topRight: Radius.circular(32.w))));
  }

  Widget _flexibleContent(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 56.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VisibilityDetector(
                  key: const Key("user_center_page"),
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
                              child: cpnCircleBorderImage(
                                  url: decodeMediaUrl(logic.avatar()),
                                  border: Border.fromBorderSide(BorderSide(
                                      color: ColorPalettes.instance.primary,
                                      width: 4.w)),
                                  size: 180.w,
                                  defaultPlaceHolderAssetName:
                                      "ic_default_avatar",
                                  defaultErrorAssetName: "ic_default_avatar"),
                            ),
                            _editButton()
                          ],
                        ),
                        SizedBox(height: 16.w),
                        Text(
                          logic.nickName(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 44.w,
                              color: ColorPalettes.instance.firstText),
                        ),
                      ])),
              SizedBox(
                height: 16.w,
              ),
              Text(
                logic.signature(),
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
                  _userAttributesItem(
                      "获赞", logic.userCenterEntity.value?.likeNum),
                  SizedBox(
                    width: 48.w,
                  ),
                  _userAttributesItem(
                      "关注", logic.userCenterEntity.value?.attentionNum,
                      onClick: () {
                    AppRoutes.jumpPage(AppRoutes.fansPage,
                        arguments: {"isFans": false, "userId": logic.userId});
                  }),
                  SizedBox(
                    width: 48.w,
                  ),
                  _userAttributesItem(
                      "粉丝", logic.userCenterEntity.value?.fansNum, onClick: () {
                    AppRoutes.jumpPage(AppRoutes.fansPage,
                        arguments: {"isFans": true, "userId": logic.userId});
                  }),
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

  Widget _userAttributesItem(String name, String? count,
      {VoidCallback? onClick}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (onClick != null) {
          onClick();
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            count ?? "--",
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
      ),
    );
  }

  Widget _editButton() {
    if (!logic.isSelf() && logic.isAttention.value == null) {
      return const SizedBox();
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (logic.isSelf()) {
          AppRoutes.jumpPage(AppRoutes.userEditCenterPage);
        } else {
          logic.attentionUser();
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 80.w),
        width: 160.w,
        height: 56.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: ColorPalettes.instance.primary,
            borderRadius: BorderRadius.circular(28.w)),
        child: Text(
          logic.isSelf()
              ? "编辑资料"
              : (logic.isAttention.value == true ? "取消关注" : "+ 关注"),
          style: TextStyle(fontSize: 28.w, color: Colors.white),
        ),
      ),
    );
  }

  Widget _tabBar() {
    return TabBar(
      controller: logic.tabController,
      indicatorSize: TabBarIndicatorSize.tab,
      isScrollable: false,
      indicator: UnderlineTabIndicator(
          borderRadius: BorderRadius.circular(4.w),
          insets: EdgeInsets.symmetric(
              horizontal: logic.tabs.length == 4 ? 72.w : 160.w),
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

  @override
  Widget buildNestedBody(BuildContext context) {
    return TabBarView(
        controller: logic.tabController, children: logic.navPages);
  }

  @override
  double pinnedHeaderHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top + 88.w + 100.w;
  }
}
