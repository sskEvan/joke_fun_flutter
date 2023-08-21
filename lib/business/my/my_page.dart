import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_image.dart';
import 'package:joke_fun_flutter/common/ext/asset_ext.dart';
import 'package:joke_fun_flutter/common/util/user_manager.dart';
import 'package:joke_fun_flutter/common/util/media_util.dart';
import 'package:joke_fun_flutter/models/login_entity.dart';

import '../../common/cpn/app_bar.dart';
import '../../common/cpn/cpn_view_state.dart';
import '../../common/util/log_util.dart';
import '../../models/user_info_entity.dart';
import '../../router/routers.dart';
import '../../theme/color_palettes.dart';
import 'my_logic.dart';

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
            _customerService(),
            _examine(),
            _others()
          ],
        ),
      ),
    );
  }

  Widget _userBasicInfo() {
    User? user = UserManager().loginEntity.value?.userInfo;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Get.toNamed(UserManager.instance.isLogin() ? AppRoutes.userCenterPage : AppRoutes.verifyCodeLoginPage,
        arguments: controller.userInfoEntity.value?.info);
      },
      child: Container(
          padding: EdgeInsets.only(top: 60.w, bottom: 32.w),
          child: Row(children: [
            Hero(
              tag: "user_avatar",
              child: cpnCircleNetworkImage(
                url: decodeMediaUrl(user?.avatar),
                width: 148.w,
                height: 148.w,
                defaultPlaceHolderAssetName: "ic_default_avatar",
                defaultErrorAssetName: "ic_default_avatar"
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user?.nickname ?? "登陆/注册",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 36.w,
                      color: ColorPalettes.instance.firstText),
                ),
                SizedBox(height: 12.w),
                Text(
                    user?.signature ?? "期待您的创作～",
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
    UserInfo? userInfo = controller.userInfoEntity.value?.info;
    return Row(
      children: [
        SizedBox(width: 40.w),
        _userAttributesItem("关注", userInfo?.attentionNum),
        SizedBox(width: 120.w),
        _userAttributesItem("粉丝", userInfo?.fansNum),
        SizedBox(width: 120.w),
        _userAttributesItem("乐豆", userInfo?.experienceNum),
      ],
    );
  }

  Widget _userAttributesItem(String name, int? count) {
    return Padding(
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
    );
  }

  Widget _actionButtons() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 24.w),
      width: double.infinity,
      height: 180.w,
      decoration: BoxDecoration(
          color: ColorPalettes.instance.pure,
          borderRadius: BorderRadius.circular(16.w)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        _actionButton("ic_post_colorful", "帖子"),
        _actionButton("ic_comment_colorful", "评论"),
        _actionButton("ic_like_colorful", "赞过"),
        _actionButton("ic_collect_colorful", "收藏"),
      ]),
    );
  }

  Widget _actionButton(String assetName, String name) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(assetName.webp, width: 72.w, height: 72.w),
        SizedBox(height: 8.w),
        Text(
          name,
          style: TextStyle(
              fontSize: 28.w, color: ColorPalettes.instance.firstText),
        ),
      ],
    );
  }

  Widget _customerService() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.w),
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorPalettes.instance.pure,
          borderRadius: BorderRadius.circular(16.w)),
      child: _commonActionItem("ic_my_custom_service", "我的客服"),
    );
  }

  Widget _examine() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.w),
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorPalettes.instance.pure,
          borderRadius: BorderRadius.circular(16.w)),
      child: Column(
        children: [
          _commonActionItem("ic_my_examine", "审核中"),
          _commonActionItem("ic_my_examine_fail", "审核失败"),
        ],
      ),
    );
  }

  Widget _others() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.w),
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorPalettes.instance.pure,
          borderRadius: BorderRadius.circular(16.w)),
      child: Column(
        children: [
          _commonActionItem("ic_my_share", "分享给朋友"),
          _commonActionItem("ic_my_feedback", "意见反馈"),
          _commonActionItem("ic_my_respect", "给个好评"),
          _commonActionItem("ic_my_setting", "设置"),
        ],
      ),
    );
  }

  Widget _commonActionItem(String assetName, String name) {
    return Padding(
      padding:
          EdgeInsets.only(left: 32.w, top: 32.w, bottom: 32.w, right: 16.w),
      child: Row(
        children: [
          Image.asset(assetName.webp,
              width: 48.w,
              height: 48.w,
              color: ColorPalettes.instance.firstIcon),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                  fontSize: 32.w, color: ColorPalettes.instance.firstText),
            ),
          ),
          Image.asset("ic_arrow_right".webp,
              width: 40.w,
              height: 40.w,
              color: ColorPalettes.instance.secondIcon),
        ],
      ),
    );
  }
}
