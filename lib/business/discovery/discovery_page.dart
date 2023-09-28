import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joke_fun_flutter/business/common/sheet/joke_comment_sheet.dart';
import 'package:joke_fun_flutter/business/discovery/cpn/cpn_discovery_video_player.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_image.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state_paging.dart';
import 'package:joke_fun_flutter/common/ext/asset_ext.dart';
import 'package:joke_fun_flutter/common/util/media_util.dart';
import 'package:joke_fun_flutter/common/util/toast_util.dart';
import 'package:joke_fun_flutter/models/joke_detail_entity.dart';
import 'package:joke_fun_flutter/router/routers.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';

import 'discovery_logic.dart';

class DiscoveryPage extends CpnViewStatePaging<DiscoveryLogic> {
  DiscoveryPage({Key? key}) : super(key: key, enableLoadMore: false);

  @override
  Widget buildPagingList() {
    return Container(
      color: Colors.black,
      child: PageView.builder(
          itemBuilder: (BuildContext context, int index) {
            return _pageItem(context, logic.dataList[index], index);
          },
          controller: logic.pageController,
          scrollDirection: Axis.vertical,
          itemCount: logic.dataList.length,
          onPageChanged: (index) {
            logic.fetchMoreDataIfNeeded(index);
          }),
    );
  }

  @override
  Color backgroundColor() => Colors.black;

  @override
  void scrollNotificationCallback(ScrollNotification scrollNotification) {
    logic.scrollNotificationCallback(scrollNotification);
  }

  Widget _pageItem(BuildContext context, JokeDetailEntity item, int index) {
    return Stack(
      children: [
        _video(item, index),
        _actionsLayout(context, item),
        _info(item)
      ],
    );
  }

  Widget _video(JokeDetailEntity item, int index) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: CpnDiscoveryVideoPlayer(
          item: item, index: index, videoPlayHelper: logic),
    );
  }

  Widget _actionsLayout(BuildContext context, JokeDetailEntity item) {
    return Align(
        alignment: const Alignment(0.975, 0.75),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _avatar(item),
            SizedBox(height: 48.w),
            _actionItem(
                assetName: "ic_like_heart_fill",
                value: "${item.info?.likeNum ?? 0}",
                color: (item.info?.isLike == true) ? Colors.red : Colors.white,
                actionCallback: () {
                  logic.likeJokeAction(
                      item.joke?.jokesId, item.info?.isLike != true);
                }),
            SizedBox(height: 48.w),
            _actionItem(
                assetName: "ic_comment_fill",
                value: "${item.info?.commentNum ?? 0}",
                actionCallback: () {
                  showJokeCommentSheet(context, item.joke?.jokesId ?? 0,
                      item.info?.commentNum ?? 0);
                }),
            SizedBox(height: 48.w),
            _actionItem(
                assetName: "ic_share_fill",
                value: "${item.info?.shareNum ?? 0}",
                actionCallback: () {
                  showToast("todo...");
                }),
          ],
        ));
  }

  Widget _avatar(JokeDetailEntity item) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            AppRoutes.jumpPage(AppRoutes.userCenterPage, arguments: {
              "index": "0",
              "userId": (item.user?.userId ?? 0).toString()
            });
          },
          child: cpnCircleBorderImage(
              url: decodeMediaUrl(item.user?.avatar),
              border: Border.fromBorderSide(
                  BorderSide(color: Colors.white, width: 3.w)),
              size: 112.w,
              defaultPlaceHolderAssetName: "ic_default_avatar",
              defaultErrorAssetName: "ic_default_avatar"),
        ),
        GestureDetector(
          onTap: () {
            bool noAttention = item.info?.isAttention != true;
            logic.attentionUser(item.user?.userId, noAttention);
          },
          child: Container(
              margin: EdgeInsets.only(top: 88.w, left: 36.w),
              child: Container(
                width: 40.w,
                height: 40.w,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
                child: (item.info?.isAttention == true)
                    ? Image.asset("ic_correct".webp,
                        width: 24.w,
                        height: 24.w,
                        color: ColorPalettes.instance.primary)
                    : Text("+",
                        style: TextStyle(
                            color: ColorPalettes.instance.primary,
                            fontSize: 32.w)),
              )),
        )
      ],
    );
  }

  Widget _actionItem(
      {required String assetName,
      required String value,
      Color color = Colors.white,
      required VoidCallback actionCallback}) {
    return GestureDetector(
      onTap: actionCallback,
      child: Column(
        children: [
          Image.asset(
            assetName.webp,
            width: 56.w,
            height: 56.w,
            color: color,
          ),
          SizedBox(
            height: 12.w,
          ),
          Text(value, style: TextStyle(color: Colors.white, fontSize: 28.w))
        ],
      ),
    );
  }

  Widget _info(JokeDetailEntity item) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.only(left: 32.w, right: 110.w, bottom: 72.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("@${item.user?.nickName ?? "--"}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.w,
                    fontWeight: FontWeight.w500)),
            SizedBox(height: 12.w),
            Text(item.joke?.content ?? "",
                style:
                    TextStyle(color: const Color(0xFFDDDDDD), fontSize: 26.w)),
          ],
        ),
      ),
    );
  }
}
