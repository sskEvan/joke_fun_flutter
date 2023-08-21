import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state.dart';
import 'package:joke_fun_flutter/common/ext/asset_ext.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';

import 'recommend_user_logic.dart';

class RecommendUserPage extends CpnViewState<RecommendUserLogic> {
  const RecommendUserPage({Key? key}) : super(key: key);

  @override
  bool lazyLoadData() => true;

  @override
  Widget buildBody(context) {
    var items = controller.dataList;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 32.w, top: 12.w),
          child: Text(" 推荐用户",
              style: TextStyle(
                  color: ColorPalettes.instance.secondText,
                  fontSize: 30.w,
                  fontWeight: FontWeight.bold)),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.w),
          height: 400.w,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (c, i) => _itemRecommendUser(),
            separatorBuilder: (c, i) => SizedBox(width: 8.w),
          ),
        ),
        Container(
            color: ColorPalettes.instance.separator,
            width: double.infinity,
            height: 12.w)
      ],
    );
  }

  Widget _itemRecommendUser() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.w),
      child: Card(
          elevation: 6.w,
          shadowColor: ColorPalettes.instance.separator,
          child: Container(
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("ic_default_avatar".webp,
                      width: 120.w, height: 120.w),
                  Text("往事随风",
                      style: TextStyle(
                          color: ColorPalettes.instance.firstText,
                          fontSize: 28.w,
                          fontWeight: FontWeight.bold)),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text("发表 12",
                        style: TextStyle(
                            color: ColorPalettes.instance.secondText,
                            fontSize: 24.w)),
                    SizedBox(width: 32.w),
                    Text("粉丝 200",
                        style: TextStyle(
                            color: ColorPalettes.instance.secondText,
                            fontSize: 24.w)),
                  ]),
                  Container(
                      width: 160.w,
                      height: 56.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ColorPalettes.instance.primary,
                        borderRadius: BorderRadius.circular((28.w)),
                      ),
                      child: Text("+ 关注",
                          style: TextStyle(
                              color: ColorPalettes.instance.pure,
                              fontSize: 28.w,
                              fontWeight: FontWeight.bold))),
                ],
              ))),
    );
  }
}
