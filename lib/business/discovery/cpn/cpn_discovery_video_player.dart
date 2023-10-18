import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/common/logic/joke_list_video_play_helper_mixin.dart';
import 'package:joke_fun_flutter/business/discovery/cpn/discovery_video_player_skin.dart';
import 'package:joke_fun_flutter/models/joke_detail_entity.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// 发现页面视频播放器组件
class CpnDiscoveryVideoPlayer extends StatelessWidget {
  final JokeDetailEntity item;
  final int index;
  final JokeListVideoPlayHelperMixin videoPlayHelper;
  final bool multiplex;

  const CpnDiscoveryVideoPlayer({
    required this.item,
    required this.index,
    required this.videoPlayHelper,
    this.multiplex = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var key = "video_$index";
    var aspectRatio = (item.joke?.getTestVideoWidth() ?? 1) *
        1.0 /
        (item.joke?.getTestVideoHeight() ?? 1);

    return Obx(() {
      bool autoPlay = videoPlayHelper.needAutoPlay(index);
      return VisibilityDetector(
        key: Key(key),
        onVisibilityChanged: (VisibilityInfo info) {
          videoPlayHelper.calculatePendingPlayIndex(
              index, info.visibleFraction);
        },
        child: Stack(
          children: [
            autoPlay ? _videoPlayer(aspectRatio) : const SizedBox.shrink(),
          ],
        ),
      );
    });
  }

  Widget _videoPlayer(double aspectRatio) {
    videoPlayHelper.initVideoPlayer(
        item.joke?.jokesId,
        item.joke?.getTestVideoUrl(),
        aspectRatio,
        multiplex,
        const DiscoveryVideoPlayerSkin());
    return Align(
      alignment: Alignment.center,
      child: Chewie(
        controller: videoPlayHelper.chewieController!,
      ),
    );
  }
}
