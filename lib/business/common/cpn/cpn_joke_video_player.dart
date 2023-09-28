import 'dart:math';

import 'package:chewie/chewie.dart';
import 'package:chewie/src/animated_play_pause.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/common/logic/joke_list_video_play_helper_mixin.dart';
import 'package:joke_fun_flutter/common/cpn/player/custom_video_player_skin.dart';
import 'package:joke_fun_flutter/models/joke_detail_entity.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';


/// 段子视频播放器组件
class CpnJokeVideoPlayer extends StatefulWidget {
  final JokeDetailEntity item;
  final int index;
  final bool isInnerList;
  final JokeListVideoPlayHelperMixin videoPlayHelper;

  const CpnJokeVideoPlayer({
    required this.item,
    required this.index,
    required this.isInnerList,
    required this.videoPlayHelper,
    Key? key,
  }) : super(key: key);

  @override
  State<CpnJokeVideoPlayer> createState() => _CpnJokeVideoPlayerState();
}

class _CpnJokeVideoPlayerState extends State<CpnJokeVideoPlayer> {
  late JokeListVideoPlayHelperMixin videoPlayHelper;

  @override
  void initState() {
    super.initState();
    videoPlayHelper = widget.videoPlayHelper;
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
    bool autoPlay = videoPlayHelper.curPlayIndex.value == widget.index ||
        !widget.isInnerList;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.w),
      child: Container(
        color: Colors.black,
        width: displayWidth,
        height: displayHeight,
        child: VisibilityDetector(
            key: Key(key),
            onVisibilityChanged: (VisibilityInfo info) {
              if (widget.isInnerList) {
                videoPlayHelper.calculatePendingPlayIndex(
                    widget.index, info.visibleFraction);
              }
            },
            child: Stack(
              children: [
                (autoPlay)
                    ? _videoPlayer(displayWidth, displayHeight)
                    : const SizedBox.shrink(),
                (!autoPlay)
                    ? const Align(
                        alignment: Alignment.center,
                        child: AnimatedPlayPause(
                          color: Colors.white,
                          size: 32,
                          playing: false,
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            )),
      ),
    );
  }

  Widget _videoPlayer(double displayWidth, double displayHeight) {
    videoPlayHelper.initVideoPlayer(
        widget.item.joke?.videoUrl, widget.item.joke?.getTestVideoUrl());
    return _JokeVideoPlayer(
        key: ValueKey((widget.item.joke?.getTestVideoUrl() ?? "") +
            widget.index.toString()),
        width: displayWidth,
        height: displayHeight,
        videoPlayHelper: videoPlayHelper);
  }
}

class _JokeVideoPlayer extends StatefulWidget {
  final double width;
  final double height;
  final JokeListVideoPlayHelperMixin videoPlayHelper;

  const _JokeVideoPlayer(
      {Key? key,
      required this.width,
      required this.height,
      required this.videoPlayHelper})
      : super(key: key);

  @override
  State<_JokeVideoPlayer> createState() => _JokeVideoPlayerState();
}

class _JokeVideoPlayerState extends State<_JokeVideoPlayer> {
  late ChewieController _chewieController;
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _chewieController = widget.videoPlayHelper.chewieController!;
    _videoPlayerController = widget.videoPlayHelper.videoPlayerController!;

    if (!_videoPlayerController.value.isInitialized) {
      _videoPlayerController.initialize().then((value) => setState(() {
            // 获取视频尺寸， fix播放画面比例变形的bug
            final videoWidth = _videoPlayerController.value.size.width;
            final videoHeight = _videoPlayerController.value.size.height;
            var aspectRatio = videoWidth / videoHeight;

            _chewieController = ChewieController(
                videoPlayerController: _videoPlayerController,
                showControlsOnInitialize: false,
                aspectRatio: aspectRatio,
                autoPlay: true,
                looping: true,
                useRootNavigator: true,
                // 自定义播放布局
                customControls: const CustomVideoPlayerSkin());

            widget.videoPlayHelper.chewieController = _chewieController;
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: _chewieController,
    );
  }
}
