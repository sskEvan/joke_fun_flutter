import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:joke_fun_flutter/business/common/logic/joke_list_logic.dart';
import 'package:joke_fun_flutter/business/common/logic/joke_list_video_play_helper_mixin.dart';
import 'package:joke_fun_flutter/business/common/sheet/joke_comment_sheet.dart';
import 'package:joke_fun_flutter/business/common/sheet/joke_more_sheet.dart';
import 'package:joke_fun_flutter/common/ext/asset_ext.dart';
import 'package:joke_fun_flutter/common/util/toast_util.dart';
import 'package:joke_fun_flutter/models/joke_detail_entity.dart';
import 'package:joke_fun_flutter/router/routers.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';

import '../../../common/cpn/cpn_image.dart';
import '../../../common/util/media_util.dart';
import 'cpn_joke_video_player.dart';

/// 段子列表item组件
class CpnJokeItem extends StatelessWidget {
  final JokeDetailEntity item;
  final int index;
  final JokeListLogic? logic;
  final bool showUserInfo;
  final JokeListVideoPlayHelperMixin? videoPlayHelper;

  const CpnJokeItem(
      {required this.item,
      required this.index,
      this.logic,
      this.showUserInfo = true,
      this.videoPlayHelper,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CpnJoke(
        item: item,
        index: index,
        showUserInfo: showUserInfo,
        isInnerList: true,
        videoPlayHelper: videoPlayHelper,
        likeCallback: () {
          logic?.likeJokeAction(item.joke?.jokesId, item.info?.isLike != true);
        },
        unlikeCallback: () {
          logic?.unlikeJokeAction(
              item.joke?.jokesId, item.info?.isUnlike != true);
        },
        attentionCallback: () {
          bool noAttention = item.info?.isAttention != true;
          logic?.attentionUser(item.user?.userId, noAttention);
        },
        commentCallback: () {
          showJokeCommentSheet(
              context, item.joke?.jokesId ?? 0, item.info?.commentNum ?? 0);
        });
  }
}

/// 段子item组件
class CpnJoke extends StatelessWidget {
  final JokeDetailEntity item;
  final int index;
  final bool showUserInfo;
  final VoidCallback? attentionCallback;
  final VoidCallback? likeCallback;
  final VoidCallback? unlikeCallback;
  final VoidCallback? commentCallback;
  final bool isInnerList;
  final JokeListVideoPlayHelperMixin? videoPlayHelper;
  final bool multiplexVideoPlayer;

  const CpnJoke({
    required this.item,
    this.index = 0,
    Key? key,
    this.showUserInfo = true,
    this.attentionCallback,
    this.likeCallback,
    this.unlikeCallback,
    this.commentCallback,
    this.isInnerList = false,
    this.multiplexVideoPlayer = true,
    this.videoPlayHelper,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: () {
            Map<String, dynamic> arguments = {
              "jokeDetailEntity": item,
              "index": index,
              "videoPlayHelper": videoPlayHelper,
            };
            if (isInnerList &&
                (item.joke?.type ?? 0) >= 3 &&
                !(videoPlayHelper?.needAutoPlay(index) ?? false)) {
              videoPlayHelper?.manualPlay(item.joke?.jokesId, index);
              arguments["multiplexVideoPlayer"] = false;
            }
            AppRoutes.jumpPage(AppRoutes.jokeDetailPage, arguments: arguments);
          },
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.w),
                color: ColorPalettes.instance.pure,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _userInfo(),
                    _content(),
                    _bottomActionLayout(context)
                  ],
                ),
              ),
              Container(
                  color: ColorPalettes.instance.separator,
                  width: double.infinity,
                  height: 12.w)
            ],
          ),
        ));
  }

  /// 顶部用户信息组件
  Widget _userInfo() {
    return showUserInfo
        ? Container(
            height: 100.w,
            alignment: Alignment.center,
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  AppRoutes.jumpPage(AppRoutes.userCenterPage, arguments: {
                    "index": "0",
                    "userId": (item.user?.userId ?? 0).toString()
                  });
                },
                child: RepaintBoundary(
                  child: cpnCircleImage(
                      url: item.user?.avatar,
                      width: 80.w,
                      height: 80.w,
                      defaultPlaceHolderAssetName: "ic_default_avatar",
                      defaultErrorAssetName: "ic_default_avatar"),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    AppRoutes.jumpPage(AppRoutes.userCenterPage, arguments: {
                      "index": "0",
                      "userId": (item.user?.userId ?? 0).toString()
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${item.user?.nickName}",
                          // Text(item.user?.nickName ?? "--",
                          style: TextStyle(
                              color: ColorPalettes.instance.firstText,
                              fontSize: 28.w,
                              fontWeight: FontWeight.w400)),
                      SizedBox(height: 4.w),
                      Text(item.user?.signature ?? "--",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: ColorPalettes.instance.secondText,
                              fontSize: 24.w))
                    ],
                  ),
                ),
              ),
              (item.info?.isAttention != true)
                  ? InkWell(
                      onTap: () {
                        if (attentionCallback != null) {
                          attentionCallback!();
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.w),
                        child: Text("关注",
                            style: TextStyle(
                                color: ColorPalettes.instance.primary,
                                fontSize: 30.w,
                                fontWeight: FontWeight.bold)),
                      ),
                    )
                  : const SizedBox.shrink(),
              InkWell(
                onTap: () {
                  showJokeMoreSheet();
                },
                child: Image.asset("ic_more_menu".webp,
                    width: 40.w,
                    height: 40.w,
                    color: ColorPalettes.instance.firstIcon),
              ),
            ]),
          )
        : const SizedBox();
  }

  /// 段子内容组件
  Widget _content() {
    int type = item.joke?.type ?? 1;
    if (type == 1) {
      return _contentText();
    } else if (type == 2) {
      return _contentPic();
    } else {
      return CpnJokeVideoPlayer(
          item: item,
          index: index,
          isInnerList: isInnerList,
          multiplex: multiplexVideoPlayer,
          videoPlayHelper: videoPlayHelper!);
    }
  }

  /// 段子内容组件 文本类型
  Widget _contentText() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.w),
      child: Text(item.joke?.content ?? "--",
          textAlign: TextAlign.left,
          style: TextStyle(
              color: ColorPalettes.instance.firstText, fontSize: 30.w)),
    );
  }

  /// 段子内容组件 图片类型
  Widget _contentPic() {
    int picSize = item.joke?.imageUrl?.split(",").length ?? 1;
    bool isMultiPic = picSize > 1;
    Widget picBody;
    if (isMultiPic) {
      /// 多图
      double spacing = 12.w;
      int columnCount = (picSize > 3) ? 3 : picSize;
      double displaySize = (686.w - (columnCount - 1) * spacing) / columnCount;
      List<Widget> images = item.joke!.imageUrl!
          .split(",")
          .map(
            (v) => _picItem(
                url: v,
                radius: 8.w,
                width: displaySize,
                height: displaySize,
                isMultiPic: true),
          )
          .toList();

      picBody = Wrap(
        runSpacing: spacing,
        spacing: spacing,
        children: images,
      );
    } else {
      List<double>? imageSize =
          item.joke?.imageSize?.split("x").map((v) => double.parse(v)).toList();
      if (imageSize != null) {
        double maxDisplayWidth = 686.w;
        double maxDisplayHeight = 400.w;
        double realWidth = imageSize[0];
        double realHeight = imageSize[1];
        double? displayWidth;
        double? displayHeight;
        double realRatio = realWidth / realHeight;
        if (realRatio >= 1) {
          /// 照片实际宽度>=实际高度
          if (maxDisplayWidth >= realWidth) {
            ///照片最大显示宽度>照片实际宽度
            displayWidth = realWidth;
            displayHeight = realHeight;
          } else {
            double displayRatio = maxDisplayWidth / realWidth;
            displayWidth = maxDisplayWidth;
            displayHeight = realHeight * displayRatio;
          }
        } else {
          if (maxDisplayHeight >= realHeight) {
            ///照片最大显示高度>照片实际高度
            displayWidth = realWidth;
            displayHeight = realHeight;
          } else {
            double displayRatio = maxDisplayHeight / realHeight;
            displayWidth = max(realWidth * displayRatio, 240.w);
            displayHeight = maxDisplayHeight;
          }
        }
        picBody = _picItem(
            url: item.joke?.imageUrl ?? "",
            radius: 16.w,
            width: displayWidth,
            height: displayHeight);
      } else {
        picBody = _picItem(
            url: item.joke?.imageUrl ?? "",
            radius: 16.w,
            width: double.infinity,
            height: double.infinity);
      }
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(item.joke?.content ?? "--",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: ColorPalettes.instance.firstText, fontSize: 30.w)),
          SizedBox(height: 16.w),
          picBody,
        ],
      ),
    );
  }

  /// 段子内容组件 图片类型
  Widget _picItem(
      {required String url,
      required double width,
      required double height,
      required double radius,
      bool isMultiPic = false}) {
    List<String> urlList =
        isMultiPic ? item.joke?.imageUrl?.split(",").toList() ?? [] : [url];
    int index = isMultiPic ? urlList.indexOf(url) : 0;
    return GestureDetector(
      onTap: () {
        AppRoutes.jumpPage(AppRoutes.picPreviewPage, arguments: {
          // "url": url,
          "urlList": urlList,
          "index": index,
        });
      },
      child: Hero(
        tag: urlList[index],
        child: RepaintBoundary(
          child: cpnRadiusImage(
              url: decodeMediaUrl(url),
              radius: radius,
              boxFit: BoxFit.cover,
              width: width,
              height: height,
              defaultHolderWidth: 100.w,
              defaultHolderHeight: 100.w),
        ),
      ),
    );
  }

  /// 底部按钮组件
  Widget _bottomActionLayout(BuildContext context) {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _actionItem(
              "ic_like".webp,
              (item.info?.isLike == true)
                  ? ColorPalettes.instance.primary
                  : ColorPalettes.instance.secondIcon,
              item.info?.likeNum ?? 0, () {
            if (likeCallback != null) {
              likeCallback!();
            }
          }),
          _actionItem(
              "ic_unlike".webp,
              (item.info?.isUnlike == true)
                  ? ColorPalettes.instance.primary
                  : ColorPalettes.instance.secondIcon,
              item.info?.disLikeNum ?? 0, () {
            if (unlikeCallback != null) {
              unlikeCallback!();
            }
          }),
          _actionItem("ic_comment".webp, ColorPalettes.instance.secondIcon,
              item.info?.commentNum ?? 0, () {
            if (commentCallback != null) {
              commentCallback!();
            }
          }),
          _actionItem("ic_share".webp, ColorPalettes.instance.secondIcon,
              item.info?.shareNum ?? 0, () {
            showToast("todo...");
          }),
        ],
      );
    });
  }

  Widget _actionItem(
      String imgAsset, Color imgColor, int count, VoidCallback actionCallback) {
    return InkWell(
      onTap: actionCallback,
      child: Container(
        height: 72.w,
        alignment: Alignment.center,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Image.asset(imgAsset,
                  width: 36.w, height: 36.w, color: imgColor),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text("$count",
                  style: TextStyle(
                      color: ColorPalettes.instance.secondText,
                      fontSize: 28.w)),
            )
          ],
        ),
      ),
    );
  }
}
