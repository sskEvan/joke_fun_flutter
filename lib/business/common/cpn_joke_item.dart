import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:joke_fun_flutter/common/ext/asset_ext.dart';
import 'package:joke_fun_flutter/models/joke_detail_entity.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';

import '../../common/cpn/cpn_image.dart';
import '../../common/util/media_util.dart';
import 'cpn_video_player.dart';

/// 段子列表item组件
class CpnJokeItem extends StatelessWidget {
  final JokeDetailEntity item;
  final int index;
  final ValueKey<String>? parentKey;

  const CpnJokeItem(
      {required this.item, required this.index, this.parentKey, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.w),
              color: ColorPalettes.instance.pure,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_userInfo(), _content(), _bottomActionLayout()],
              ),
            ),
            Container(
                color: ColorPalettes.instance.separator,
                width: double.infinity,
                height: 12.w)
          ],
        ));
  }

  /// 顶部用户信息组件
  Widget _userInfo() {
    return Container(
      height: 100.w,
      alignment: Alignment.center,
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        RepaintBoundary(
          child: cpnCircleNetworkImage(
              url: item.user?.avatar,
              width: 80.w,
              height: 80.w,
              defaultPlaceHolderAssetName: "ic_default_avatar",
              defaultErrorAssetName: "ic_default_avatar"),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("$index--${item.user?.nickName}",
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
                      color: ColorPalettes.instance.secondText, fontSize: 24.w))
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Text("+ 关注",
              style: TextStyle(
                  color: ColorPalettes.instance.primary,
                  fontSize: 30.w,
                  fontWeight: FontWeight.bold)),
        ),
        Image.asset("ic_more_menu".webp,
            width: 40.w, height: 40.w, color: ColorPalettes.instance.firstIcon),
      ]),
    );
  }

  /// 段子内容组件
  Widget _content() {
    int type = item.joke?.type ?? 1;
    if (type == 1) {
      return _contentText();
    } else if (type == 2) {
      return _contentPic();
    } else {
      return CpnVideoPlayer(item: item, index: index, parentKey: parentKey);
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

  /// 段子内容组件 文本类型
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
          .map((v) => RepaintBoundary(
                child: cpnRadiusNetworkImage(
                    url: decodeMediaUrl(v),
                    radius: 8.w,
                    boxFit: BoxFit.cover,
                    width: displaySize,
                    height: displaySize,
                    defaultHolderWidth: 100.w,
                    defaultHolderHeight: 100.w),
              ))
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
        picBody = RepaintBoundary(
          child: cpnRadiusNetworkImage(
              url: decodeMediaUrl(item.joke?.imageUrl),
              radius: 16.w,
              width: displayWidth,
              height: displayHeight,
              defaultHolderWidth: 100.w,
              defaultHolderHeight: 100.w),
        );
      } else {
        picBody = RepaintBoundary(
          child: cpnRadiusNetworkImage(
              url: decodeMediaUrl(item.joke?.imageUrl),
              radius: 16.w,
              defaultHolderWidth: 100.w,
              defaultHolderHeight: 100.w),
        );
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

  /// 底部按钮组件
  Widget _bottomActionLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _actionItem("ic_like".webp, item.info?.likeNum ?? 0, () {}),
        _actionItem("ic_unlike".webp, item.info?.disLikeNum ?? 0, () {}),
        _actionItem("ic_comment".webp, item.info?.commentNum ?? 0, () {}),
        _actionItem("ic_share".webp, item.info?.shareNum ?? 0, () {}),
      ],
    );
  }

  Widget _actionItem(String imgAsset, int count, VoidCallback actionCallback) {
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
                  width: 36.w,
                  height: 36.w,
                  color: ColorPalettes.instance.secondIcon),
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

class CpnVideo extends StatelessWidget {
  Key? key;
  final JokeDetailEntity item;

  CpnVideo(this.key, this.item) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<double>? videoSize =
        item.joke?.videoSize?.split(",").map((v) => double.parse(v)).toList();
    double videoRatio = (videoSize?[1] ?? 1) / (videoSize?[0] ?? 1);
    double displayWidth = 686.w;
    double displayHeight = min(displayWidth * videoRatio, 480.w);
    List<Widget> videoBody = <Widget>[];
    final holderWidget = Container(
        width: displayWidth, height: displayHeight, color: Colors.black);
    // videoBody.add(holderWidget);
    // decodeVideoThumbnail(
    //         decodeImageUrl(item.joke?.videoUrl), displayHeight.toInt())
    //     .then((value) {
    //   if (value != null) {
    //     videoBody.add(Image.memory(value));
    //   }
    // });
    videoBody.add(cpnRadiusNetworkImage(
        url: decodeMediaUrl(item.joke?.thumbUrl),
        boxFit: BoxFit.cover,
        radius: 16.w,
        width: displayWidth,
        height: displayHeight,
        placeHolderWidget: holderWidget,
        errorWidget: holderWidget));
    videoBody.add(Image.asset("ic_play".webp,
        width: 80.w, height: 80.w, color: Colors.white));
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.joke?.content ?? "--",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: ColorPalettes.instance.firstText, fontSize: 30.w)),
          SizedBox(height: 16.w),
          Stack(alignment: Alignment.center, children: videoBody)
        ],
      ),
    );
  }
}
