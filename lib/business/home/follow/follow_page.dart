import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/home/follow/cpn/attention_list/attention_list_page.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_nested_page.dart';
import 'package:joke_fun_flutter/common/ext/asset_ext.dart';
import 'package:joke_fun_flutter/common/util/user_manager.dart';
import 'package:joke_fun_flutter/router/routers.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';

import 'cpn/recommend_user/recommend_user_page.dart';

/// 首页-HomePage-关注页面
class FollowPage extends CpnNestedPage {
  FollowPage({Key? key}) : super(key: key);

  @override
  Widget buildNestedHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          SizedBox(height: 468.w, child: const CpnRecommendUser()),
          Container(
              color: ColorPalettes.instance.divider,
              width: double.infinity,
              height: 12.w)
        ],
      ),
    );
  }

  @override
  Widget buildNestedBody(BuildContext context) {
    return Obx(() {
      return UserManager.instance.isLogin() ? CpnAttentionList() : _toLogin();
    });
  }

  Widget _toLogin() {
    return Column(
      children: [
        SizedBox(height: 200.w),
        Image.asset(
          "ic_guide".webp,
          width: 192.w,
          height: 192.w,
          color: ColorPalettes.instance.secondary,
        ),
        SizedBox(height: 48.w),
        Text("点击登录,获取关注推荐内容～",
            style: TextStyle(
                fontSize: 28.w, color: ColorPalettes.instance.secondText)),
        SizedBox(height: 48.w),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            AppRoutes.jumpPage(AppRoutes.verifyCodeLoginPage);
          },
          child: Container(
              width: 320.w,
              height: 72.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.fromBorderSide(BorderSide(
                    color: ColorPalettes.instance.primary, width: 2.w)),
                borderRadius: BorderRadius.circular((36.w)),
              ),
              child: Text("去登录",
                  style: TextStyle(
                      color: ColorPalettes.instance.primary,
                      fontSize: 32.w,
                      fontWeight: FontWeight.w500))),
        ),
      ],
    );
  }
}
