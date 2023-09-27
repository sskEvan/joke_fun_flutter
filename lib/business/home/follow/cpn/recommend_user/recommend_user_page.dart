import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_image.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state.dart';
import 'package:joke_fun_flutter/common/util/media_util.dart';
import 'package:joke_fun_flutter/models/recommend_attention_entity.dart';
import 'package:joke_fun_flutter/router/routers.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';

import 'recommend_user_logic.dart';

/// 首页-HomePage-关注页面-推荐用户列表组件
class CpnRecommendUser extends CpnViewState<RecommendUserLogic> {
  const CpnRecommendUser({Key? key}) : super(key: key);

  @override
  Widget buildBody(context) {
    var items = logic.dataList;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 32.w, top: 24.w),
          child: Text(" 推荐用户",
              style: TextStyle(
                  color: ColorPalettes.instance.secondText,
                  fontSize: 30.w,
                  fontWeight: FontWeight.w500)),
        ),
        Container(
          height: 400.w,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.w),
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (c, i) => _itemRecommendUser(items[i], i),
            separatorBuilder: (c, i) => SizedBox(width: 8.w),
          ),
        ),
      ],
    );
  }

  Widget _itemRecommendUser(RecommendAttentionEntity item, int index) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        AppRoutes.jumpPage(AppRoutes.userCenterPage, arguments: {
          "index": "0",
          "userId": (item.userId ?? 0).toString()
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.w),
        child: Card(
            elevation: 6.w,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.w)),
            ),
            shadowColor: ColorPalettes.instance.separator,
            child: Container(
                width: 280.w,
                padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 32.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    cpnCircleBorderImage(
                        url: decodeMediaUrl(item.avatar),
                        border: Border.fromBorderSide(BorderSide(
                            color: ColorPalettes.instance.primary, width: 3.w)),
                        size: 120.w,
                        defaultPlaceHolderAssetName: "ic_default_avatar",
                        defaultErrorAssetName: "ic_default_avatar"),
                    Text(item.nickname ?? "--",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: ColorPalettes.instance.firstText,
                            fontSize: 28.w,
                            fontWeight: FontWeight.bold)),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text("发表 ${item.jokesNum ?? "--"}",
                          style: TextStyle(
                              color: ColorPalettes.instance.secondText,
                              fontSize: 24.w)),
                      SizedBox(width: 16.w),
                      Text("粉丝 ${item.fansNum ?? "--"}",
                          style: TextStyle(
                              color: ColorPalettes.instance.secondText,
                              fontSize: 24.w)),
                    ]),
                    _attentionButton(item, index),
                  ],
                ))),
      ),
    );
  }

  Widget _attentionButton(RecommendAttentionEntity item, int index) {
    bool noAttention = item.isAttention != true;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        logic.attentionUser(item.userId, noAttention, index);
      },
      child: Container(
          width: 200.w,
          height: 56.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: noAttention
                ? ColorPalettes.instance.primary
                : Colors.transparent,
            border: Border.fromBorderSide(BorderSide(
                color: noAttention
                    ? Colors.transparent
                    : ColorPalettes.instance.primary,
                width: 2.w)),
            borderRadius: BorderRadius.circular((28.w)),
          ),
          child: Text(noAttention ? "+ 关注" : "已关注",
              style: TextStyle(
                  color: noAttention
                      ? ColorPalettes.instance.pure
                      : ColorPalettes.instance.primary,
                  fontSize: 28.w,
                  fontWeight: FontWeight.w500))),
    );
  }
}
