import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joke_fun_flutter/common/cpn/app_bar.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_image.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state.dart';
import 'package:joke_fun_flutter/common/ext/asset_ext.dart';
import 'package:joke_fun_flutter/common/util/media_util.dart';
import 'package:joke_fun_flutter/common/util/toast_util.dart';
import 'package:joke_fun_flutter/common/util/user_manager.dart';
import 'package:joke_fun_flutter/models/user_info_entity.dart';
import 'package:joke_fun_flutter/router/routers.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';

import 'my_logic.dart';

/// 首页-我的
class MyPage extends CpnViewState<MyLogic> {
  const MyPage({Key? key}) : super(key: key, bindViewState: false);

  @override
  AppBar? buildAppBar() => commonAppBar();

  @override
  Widget buildBody(context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          children: [
            _userBasicInfo(),
            _userAttributes(),
            _actionButtons(),
            _moreServices()
          ],
        ),
      ),
    );
  }

  Widget _userBasicInfo() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        AppRoutes.jumpPage(AppRoutes.userCenterPage, needLogin: true);
      },
      child: Container(
          padding: EdgeInsets.only(top: 64.w, bottom: 48.w),
          child: Row(children: [
            cpnCircleImage(
                url: decodeMediaUrl(UserManager.instance.avatar.value),
                width: 148.w,
                height: 148.w,
                defaultPlaceHolderAssetName: "ic_default_avatar",
                defaultErrorAssetName: "ic_default_avatar"),
            SizedBox(width: 24.w),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (UserManager.instance.nickname.value.isNotEmpty)
                      ? UserManager.instance.nickname.value
                      : "登录/注册",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 36.w,
                      color: ColorPalettes.instance.firstText),
                ),
                SizedBox(height: 12.w),
                Text(
                  UserManager.instance.signature.value,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 30.w,
                      color: ColorPalettes.instance.secondText),
                )
              ],
            )),
            Image.asset("ic_arrow_right".webp,
                width: 48.w,
                height: 48.w,
                color: ColorPalettes.instance.secondIcon)
          ])),
    );
  }

  Widget _userAttributes() {
    UserInfo? userInfo = logic.userInfoEntity.value?.info;
    return Row(
      children: [
        SizedBox(width: 40.w),
        _userAttributesItem("关注", userInfo?.attentionNum, onClick: () {
          AppRoutes.jumpPage(AppRoutes.fansPage,
              arguments: {
                "isFans": false,
                "userId":
                    (logic.userInfoEntity.value?.user?.userId ?? 0).toString()
              },
              needLogin: true);
        }),
        SizedBox(width: 120.w),
        _userAttributesItem("粉丝", userInfo?.fansNum, onClick: () {
          AppRoutes.jumpPage(AppRoutes.fansPage,
              arguments: {
                "isFans": true,
                "userId":
                    (logic.userInfoEntity.value?.user?.userId ?? 0).toString()
              },
              needLogin: true);
        }),
        SizedBox(width: 120.w),
        _userAttributesItem("乐豆", userInfo?.experienceNum, onClick: () {
          AppRoutes.jumpPage(AppRoutes.experiencePage);
        }),
      ],
    );
  }

  Widget _userAttributesItem(String name, int? count, {VoidCallback? onClick}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (onClick != null) {
          onClick();
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.w),
        child: Column(
          children: [
            Text(
              "${count ?? "--"}",
              style: TextStyle(
                  fontSize: 28.w, color: ColorPalettes.instance.secondText),
            ),
            SizedBox(height: 8.w),
            Text(
              name,
              style: TextStyle(
                  fontSize: 28.w, color: ColorPalettes.instance.secondText),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButtons() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 48.w),
      width: double.infinity,
      height: 200.w,
      decoration: BoxDecoration(
          color: ColorPalettes.instance.pure,
          borderRadius: BorderRadius.circular(16.w)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        _actionButton("ic_post_colorful", "帖子", () {
          AppRoutes.jumpPage(AppRoutes.userCenterPage,
              arguments: {"index": "0"}, needLogin: true);
        }),
        _actionButton("ic_like_colorful", "赞过", () {
          AppRoutes.jumpPage(AppRoutes.userCenterPage,
              arguments: {"index": "1"}, needLogin: true);
        }),
        _actionButton("ic_comment_colorful", "评论", () {
          AppRoutes.jumpPage(AppRoutes.userCenterPage,
              arguments: {"index": "2"}, needLogin: true);
        }),
        _actionButton("ic_collect_colorful", "收藏", () {
          AppRoutes.jumpPage(AppRoutes.userCenterPage,
              arguments: {"index": "3"}, needLogin: true);
        }),
      ]),
    );
  }

  Widget _actionButton(String assetName, String name, VoidCallback onClick) {
    return InkWell(
      onTap: onClick,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(assetName.webp, width: 72.w, height: 72.w),
          SizedBox(height: 16.w),
          Text(
            name,
            style: TextStyle(
                fontSize: 26.w, color: ColorPalettes.instance.secondText),
          ),
        ],
      ),
    );
  }

  Widget _moreServices() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorPalettes.instance.pure,
          borderRadius: BorderRadius.circular(16.w)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 32.w, left: 32.w),
            child: Text(
              "更多服务",
              style: TextStyle(
                  fontSize: 28.w,
                  color: ColorPalettes.instance.firstText,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Wrap(children: [
            _moreServiceItem("ic_my_scan_history", "浏览历史", () {
              showToast("todo...");
            }),
            _moreServiceItem("ic_my_examine", "审核中", () {
              showToast("todo...");
            }),
            _moreServiceItem("ic_my_examine_fail", "审核失败", () {
              showToast("todo...");
            }),
            _moreServiceItem("ic_my_feedback", "意见反馈", () {
              showToast("todo...");
            }),
            _moreServiceItem("ic_my_custom_service", "我的客服", () {
              showToast("todo...");
            }),
            _moreServiceItem("ic_my_share", "分享给朋友", () {
              showToast("todo...");
            }),
            _moreServiceItem("ic_my_respect", "给个好评", () {
              showToast("todo...");
            }),
            _moreServiceItem("ic_my_setting", "设置", () {
              AppRoutes.jumpPage(AppRoutes.settingPage);
            }),
          ]),
        ],
      ),
    );
  }

  Widget _moreServiceItem(String assetName, String name, VoidCallback onClick) {
    return InkWell(
      onTap: onClick,
      child: SizedBox(
        width: 686.w / 4,
        height: 200.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(assetName.webp, width: 64.w, height: 64.w),
            SizedBox(height: 16.w),
            Text(
              name,
              style: TextStyle(
                  fontSize: 26.w, color: ColorPalettes.instance.secondText),
            ),
          ],
        ),
      ),
    );
  }



}
