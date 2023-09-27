import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_nested_page.dart';
import 'package:joke_fun_flutter/common/cpn/no_over_scroll_behavior.dart';
import 'package:joke_fun_flutter/common/ext/asset_ext.dart';

import '../../theme/color_palettes.dart';

/// 首页-消息(暂未接入真实数据)
class MessagePage extends CpnNestedPage {
  MessagePage({Key? key}) : super(key: key);

  @override
  Widget buildNestedHeader(BuildContext context) {
    return Obx(() {
      return SliverAppBar(
          toolbarHeight: 88.w,
          expandedHeight: 360.w,
          backgroundColor: ColorPalettes.instance.pure,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark),
          title: Center(
              child: Text("消息",
                  style: TextStyle(
                      color: ColorPalettes.instance.firstText,
                      fontSize: 36.w,
                      fontWeight: FontWeight.w500))),
          automaticallyImplyLeading: false,
          pinned: true,
          elevation: 0,
          titleSpacing: 0,
          flexibleSpace: _flexibleSpace(context));
    });
  }

  Widget _flexibleSpace(BuildContext context) {
    return FlexibleSpaceBar(
      collapseMode: CollapseMode.pin,
      background: Container(
        margin: EdgeInsets.only(top: pinnedHeaderHeight(context)),
        child: Column(
          children: [
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _flexibleItem(
                    "ic_message_like", const Color(0xFFea9518), "赞和踩"),
                _flexibleItem(
                    "ic_message_comment", const Color(0xFFF0484E), "评论"),
                _flexibleItem("ic_message_fans", const Color(0xFF3bbb69), "粉丝"),
                _flexibleItem(
                    "ic_message_system", const Color(0xFF1296db), "系统消息")
              ],
            )),
            Container(height: 16.w, color: ColorPalettes.instance.divider),
          ],
        ),
      ),
    );
  }

  Widget _flexibleItem(String icon, Color color, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 88.w,
          height: 88.w,
          decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.w)),
          alignment: Alignment.center,
          child: Image.asset(
            icon.webp,
            width: 48.w,
            height: 48.w,
            color: color,
          ),
        ),
        SizedBox(height: 16.w),
        Text(text,
            style: TextStyle(
                color: ColorPalettes.instance.secondText, fontSize: 28.w))
      ],
    );
  }

  @override
  Widget buildNestedBody(BuildContext context) {
    return ScrollConfiguration(
        behavior: NoOverScrollBehavior(),
        child: ListView.builder(
          padding: EdgeInsets.only(top: 20.w, bottom: 60.w),
          itemCount: 20,
          itemBuilder: (c, i) => _messageItem(i),
        ));
  }

  Widget _messageItem(int index) {
    return Container(
      height: 140.w,
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.w),
      child: Row(
        children: [
          Container(
            width: 88.w,
            height: 88.w,
            decoration: BoxDecoration(
                color: const Color(0xFF1296db),
                borderRadius: BorderRadius.circular(100.w)),
            alignment: Alignment.center,
            child: Image.asset(
              "ic_message_system".webp,
              width: 56.w,
              height: 56.w,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 32.w),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Text("系统消息",
                          style: TextStyle(
                              color: ColorPalettes.instance.secondText,
                              fontSize: 28.w))),
                  Text("2023-09-10",
                      style: TextStyle(
                          color: ColorPalettes.instance.thirdText,
                          fontSize: 24.w))
                ],
              ),
              Text("testMessage-$index:欢迎来到JokeFun!!!",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: ColorPalettes.instance.firstText, fontSize: 28.w))
            ],
          ))
        ],
      ),
    );
  }

  @override
  double pinnedHeaderHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top + 88.w;
  }
}
