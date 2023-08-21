import 'dart:math';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_instance/src/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:joke_fun_flutter/business/common/logic/video_player_controller.dart';
import 'package:joke_fun_flutter/common/ext/asset_ext.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../common/cpn/cpn_image.dart';
import '../../common/cpn/player/custom_fijk_panel.dart';
import '../../common/util/media_util.dart';
import '../../models/joke_detail_entity.dart';
import '../../theme/color_palettes.dart';

class CpnVideoPlayer extends StatefulWidget {
  final JokeDetailEntity item;
  final int index;
  final ValueKey<String>? parentKey;

  const CpnVideoPlayer({
    required this.item,
    required this.index,
    this.parentKey,
    Key? key,
  }) : super(key: key);

  @override
  State<CpnVideoPlayer> createState() => _CpnVideoPlayerState();
}

class _CpnVideoPlayerState extends State<CpnVideoPlayer>
    with WidgetsBindingObserver {
  VideoListPlayerController videoListController =
      GetInstance().find<VideoListPlayerController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if(videoListController.curPlayIndex.value == widget.index) {
      print("CpnVideoPlayer-${widget.index} 状态${state}");
      if(state == AppLifecycleState.resumed) {
        print("CpnVideoPlayer-${widget.index} 状态前台${state}");
        videoListController.startPlayer();
      } else if(state == AppLifecycleState.paused) {
        print("CpnVideoPlayer-${widget.index} 状态后台${state}");
        videoListController.pausePlayer();
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<double>? videoSize = widget.item.joke?.videoSize
          ?.split(",")
          .map((v) => double.parse(v))
          .toList();
      double videoRatio = (videoSize?[1] ?? 1) / (videoSize?[0] ?? 1);
      double displayWidth = 686.w;
      double displayHeight = min(displayWidth * videoRatio, 386.w);
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.item.joke?.content ?? "--",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: ColorPalettes.instance.firstText, fontSize: 30.w)),
            SizedBox(height: 16.w),
            _video(displayWidth, displayHeight)
          ],
        ),
      );
    });
  }

  Widget _video(double displayWidth, double displayHeight) {
    var key = "video_${widget.index}";
    return RepaintBoundary(
        child: ClipRRect(
      borderRadius: BorderRadius.circular(16.w),
      child: VisibilityDetector(
        key: Key(key),
        onVisibilityChanged: (VisibilityInfo info) {
          videoListController.calculatePendingPlayIndex(
              widget.parentKey, widget.index, info.visibleFraction);
        },
        child: (videoListController.curPlayIndex.value != widget.index)
            ? _videoThumb(displayWidth, displayHeight, widget.index)
            : _videoPlayer(displayWidth, displayHeight),
        // child: AnimatedSwitcher(
        //     duration: const Duration(milliseconds: 300),
        //     child: (videoController.curPlayIndex.value != index)
        //         ? _videoThumb(displayWidth, displayHeight)
        //         : _videoPlayer(displayWidth, displayHeight)),
      ),
    ));
  }

  Widget _videoThumb(double displayWidth, double displayHeight, int index) {
    List<Widget> children = <Widget>[];
    Widget holder = Container(
        width: displayWidth, height: displayHeight, color: Colors.black);

    /// 封面or黑色背景
    children.add(cpnRadiusNetworkImage(
        url: decodeMediaUrl(widget.item.joke?.thumbUrl),
        boxFit: BoxFit.cover,
        radius: 16.w,
        width: displayWidth,
        height: displayHeight,
        placeHolderWidget: holder,
        errorWidget: holder));

    /// 播放按钮
    children.add(Image.asset("ic_play".webp,
        width: 64.w, height: 64.w, color: Colors.white));
    return InkWell(
        child: Stack(alignment: Alignment.center, children: children),
        onTap: () {
          videoListController.curPlayIndex.value = index;
        });
  }

  Widget _videoPlayer(double displayWidth, double displayHeight) {
    var player = videoListController.startPlayVideo(widget.item);
    return FijkView(
      color: Colors.black,
      height: displayHeight,
      player: player,
      fit: FijkFit.contain,
      panelBuilder: (FijkPlayer player, FijkData data, BuildContext context,
          Size viewSize, Rect texturePos) {
        return CustomFijkPanel(
            player: player,
            buildContext: context,
            viewSize: viewSize,
            texturePos: texturePos);
      },
    );
    // return Container(
    //   alignment: Alignment.center,
    //   color: Colors.white,
    //   width: displayWidth,
    //   height: displayHeight,
    //   child: Text("播放中"),
    // );
  }
}
