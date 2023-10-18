import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:joke_fun_flutter/common/cpn/player/custom_video_player_skin.dart';
import 'package:video_player/video_player.dart';

/// 视频播放组件
class CpnVideoPlay extends StatefulWidget {
  final String path;
  final bool isNetwork;
  final double? width;
  final double? height;
  final bool autoPlay;
  final bool looping;

  const CpnVideoPlay(
      {Key? key,
      required this.path,
      this.isNetwork = true,
      this.autoPlay = true,
      this.looping = false,
      this.width,
      this.height})
      : super(key: key);

  @override
  State<CpnVideoPlay> createState() => _CpnVideoPlayState();
}

class _CpnVideoPlayState extends State<CpnVideoPlay>  with WidgetsBindingObserver {
  late ChewieController _chewieController;
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();

    _videoPlayerController = widget.isNetwork
        ? VideoPlayerController.networkUrl(Uri.parse(widget.path))
        : VideoPlayerController.file(File(widget.path));

    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        showControlsOnInitialize: false,
        autoPlay: widget.autoPlay,
        looping: widget.looping,
        // 自定义播放布局
        customControls: const CustomVideoPlayerSkin());

    _videoPlayerController.initialize().then((value) => setState(() {
          // 获取视频尺寸
          final videoWidth = _videoPlayerController.value.size.width;
          final videoHeight = _videoPlayerController.value.size.height;
          var aspectRatio = videoWidth / videoHeight;

          _chewieController = ChewieController(
              videoPlayerController: _videoPlayerController,
              showControlsOnInitialize: false,
              aspectRatio: aspectRatio,
              autoPlay: widget.autoPlay,
              looping: widget.looping,
              // 自定义播放布局
              customControls: const CustomVideoPlayerSkin());
        }));

    WidgetsBinding.instance.addObserver(this);

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: widget.width,
      height: widget.height,
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }

  @override
  void dispose() {
    _chewieController.dispose();
    _videoPlayerController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.resumed) {
      _chewieController.play();
    } else if(state == AppLifecycleState.paused) {
      _chewieController.pause();
    }
  }


}
