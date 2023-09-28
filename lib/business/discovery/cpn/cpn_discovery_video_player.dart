import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/common/logic/joke_list_video_play_helper_mixin.dart';
import 'package:joke_fun_flutter/business/discovery/cpn/discovery_video_player_skin.dart';
import 'package:joke_fun_flutter/models/joke_detail_entity.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// 发现页面视频播放器组件
class CpnDiscoveryVideoPlayer extends StatefulWidget {
  final JokeDetailEntity item;
  final int index;
  final JokeListVideoPlayHelperMixin videoPlayHelper;

  const CpnDiscoveryVideoPlayer({
    required this.item,
    required this.index,
    required this.videoPlayHelper,
    Key? key,
  }) : super(key: key);

  @override
  State<CpnDiscoveryVideoPlayer> createState() => _CpnDiscoveryPlayerState();
}

class _CpnDiscoveryPlayerState extends State<CpnDiscoveryVideoPlayer> {
  late JokeListVideoPlayHelperMixin videoPlayHelper;
  bool isBuffering = true;

  @override
  void initState() {
    super.initState();
    videoPlayHelper = widget.videoPlayHelper;
  }

  @override
  Widget build(BuildContext context) {
    var key = "video_${widget.index}";
    return VisibilityDetector(
      key: Key(key),
      onVisibilityChanged: (VisibilityInfo info) {
        videoPlayHelper.calculatePendingPlayIndex(
            widget.index, info.visibleFraction);
      },
      child: Stack(
        children: [
          Obx(() {
            bool autoPlay = videoPlayHelper.curPlayIndex.value == widget.index;
            return autoPlay ? _videoPlayer() : const SizedBox.shrink();
          }),
          _progressIndicator()
        ],
      ),
    );
  }

  Widget _videoPlayer() {
    videoPlayHelper.initVideoPlayer(
        widget.item.joke?.videoUrl, widget.item.joke?.getTestVideoUrl());
    return _DiscoveryVideoPlayer(
        key: ValueKey((widget.item.joke?.getTestVideoUrl() ?? "") +
            widget.index.toString()),
        videoPlayHelper: videoPlayHelper,
        bufferingCallback: (isBuffering) {
          setState(() {
            this.isBuffering = isBuffering;
          });
        });
  }

  Widget _progressIndicator() {
    return isBuffering
            ? Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(
                  width: double.infinity,
                  height: 1.w,
                  child: LinearProgressIndicator(
                      color: Colors.white,
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          ColorPalettes.instance.primary)),
                ),
              )
            : const SizedBox.shrink();
  }
}

class _DiscoveryVideoPlayer extends StatefulWidget {
  final JokeListVideoPlayHelperMixin videoPlayHelper;
  final ValueChanged<bool>? bufferingCallback;

  const _DiscoveryVideoPlayer(
      {Key? key, required this.videoPlayHelper, this.bufferingCallback})
      : super(key: key);

  @override
  State<_DiscoveryVideoPlayer> createState() => _DiscoveryVideoPlayerState();
}

class _DiscoveryVideoPlayerState extends State<_DiscoveryVideoPlayer> {
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
                customControls: DiscoveryVideoPlayerSkin(
                    bufferingCallback: widget.bufferingCallback));

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
