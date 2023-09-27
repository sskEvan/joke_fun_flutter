import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joke_fun_flutter/business/user_center/fans/fans_logic.dart';
import 'package:joke_fun_flutter/common/cpn/app_bar.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_image.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state_paging.dart';
import 'package:joke_fun_flutter/models/fans_entity.dart';
import 'package:joke_fun_flutter/router/routers.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';

/// 粉丝、关注页面
class FansPage extends CpnViewStatePaging<FansLogic> {
  FansPage({Key? key, super.tag}) : super(key: key);

  @override
  AppBar? buildAppBar() {
    return commonAppBar(
        bottom: commonTitleBar(title: logic.isFans ? "粉丝" : "关注"));
  }

  @override
  Widget buildPagingList() {
    var items = logic.dataList;
    return ListView.builder(
        physics: const ClampingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (c, i) => _fansItem(items[i]));
  }

  Widget _fansItem(FansEntity item) {
    return Container(
      height: 148.w,
      margin: EdgeInsets.symmetric(horizontal: 32.w),
      alignment: Alignment.center,
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            AppRoutes.jumpPage(AppRoutes.userCenterPage, arguments: {
              "index": "0",
              "userId": (item.userId ?? 0).toString()
            });
          },
          child: RepaintBoundary(
            child: cpnCircleImage(
                url: item.avatar,
                width: 100.w,
                height: 100.w,
                defaultPlaceHolderAssetName: "ic_default_avatar",
                defaultErrorAssetName: "ic_default_avatar"),
          ),
        ),
        SizedBox(width: 24.w),
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              AppRoutes.jumpPage(AppRoutes.userCenterPage, arguments: {
                "index": "0",
                "userId": (item.userId ?? 0).toString()
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(item.nickname ?? "",
                    style: TextStyle(
                        color: ColorPalettes.instance.firstText,
                        fontSize: 28.w,
                        fontWeight: FontWeight.w400)),
                SizedBox(height: 4.w),
                Text(item.signature ?? "--",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: ColorPalettes.instance.secondText,
                        fontSize: 24.w))
              ],
            ),
          ),
        ),
        _attentionButton(item),
      ]),
    );
  }

  Widget _attentionButton(FansEntity item) {
    bool noAttention = item.attention == 0 || item.attention == 1;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
            onTap: () {
              logic.attentionUser(item.userId, noAttention);
            },
            child: Container(
                width: 160.w,
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
