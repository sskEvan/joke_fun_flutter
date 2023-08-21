import 'dart:async';
import 'dart:math';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joke_fun_flutter/common/ext/asset_ext.dart';
import 'package:joke_fun_flutter/common/util/log_util.dart';

import '../../../theme/color_palettes.dart';
import '../progress_bar.dart';

class CustomFijkPanel extends StatefulWidget {
  final FijkPlayer player;
  final BuildContext buildContext;
  final Size viewSize;
  final Rect texturePos;
  final Key? key;

  const CustomFijkPanel(
      {required this.player,
      required this.buildContext,
      required this.viewSize,
      required this.texturePos,
      this.key})
      : super(key: key);

  @override
  _CustomFijkPanelState createState() => _CustomFijkPanelState();
}

class _CustomFijkPanelState extends State<CustomFijkPanel> {
  FijkPlayer get player => widget.player;
  bool _playing = false;
  Duration _duration = const Duration();
  Duration _currentPos = const Duration();

  StreamSubscription? _currentPosSubs;
  StreamSubscription? _bufferingSubs;
  Timer? _hideTimer;
  bool _hidePanel = true;
  bool _buffering = false;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    player.addListener(_playerValueChanged);
    _currentPos = player.currentPos;

    _currentPosSubs = player.onCurrentPosUpdate.listen((v) {
      setState(() {
        _currentPos = v;
      });
    });

    _bufferingSubs = player.onBufferStateUpdate.listen((v) {
      setState(() {
        _buffering = v;
      });
    });
  }

  void _playerValueChanged() {
    FijkValue value = player.value;
    if (value.state == FijkState.prepared) {
      _duration = player.value.duration;
    }
    bool loading = (value.state == FijkState.initialized ||
        value.state == FijkState.asyncPreparing);
    bool playing = (value.state == FijkState.started);
    bool error = (value.state == FijkState.error);
    if (playing != _playing || loading != _buffering || error != _error) {
      setState(() {
        _playing = playing;
        _buffering = loading;
        _error = error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Rect rect = Rect.fromLTRB(
        max(0.0, widget.texturePos.left),
        max(0.0, widget.texturePos.top),
        min(widget.viewSize.width, widget.texturePos.right),
        min(widget.viewSize.height, widget.texturePos.bottom));

    return Positioned.fromRect(
      rect: rect,
      child: _panelContent(rect),
    );
  }

  Widget _panelContent(Rect rect) {
    List<Widget> children = [];
    if (!_hidePanel) {
      children.add(_bottomLayout(rect));
    }
    if (_buffering) {
      children.add(_loadingWidget());
    }
    if (_error) {
      children.add(_errorWidget());
    }
    return GestureDetector(
        child: AbsorbPointer(
            absorbing: _hidePanel, child: Stack(children: children)),
        onTapDown: (TapDownDetails details) {
          _controlHideTimer();
        });
  }

  Widget _loadingWidget() {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
          width: 40.w,
          height: 40.w,
          child:
              CircularProgressIndicator(color: Colors.white, strokeWidth: 4.w)),
    );
  }

  Widget _errorWidget() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("ic_video_error".webp,
              width: 80.w,
              height: 80.w,
              color: ColorPalettes.instance.secondary),
          SizedBox(height: 20.w),
          Text("抱歉，视频走丢了～",
              style: TextStyle(color: Colors.white, fontSize: 28.w))
        ],
      ),
    );
  }

  String _duration2String(Duration duration) {
    if (duration.inMilliseconds < 0) return "-: negtive";

    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    int inHours = duration.inHours;
    return inHours > 0
        ? "$inHours:$twoDigitMinutes:$twoDigitSeconds"
        : "$twoDigitMinutes:$twoDigitSeconds";
  }

  Widget _bottomLayout(Rect rect) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: SizedBox(
        height: 80.w,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                child: Image.asset(
                    (_playing ? "ic_pause".webp : "ic_play".webp),
                    width: 36.w,
                    height: 36.w,
                    color: Colors.white),
                onTap: () {
                  if (!_error) {
                    _playing ? player.pause() : player.start();
                  }
                },
              ),
              SizedBox(width: 16.w),
              Container(
                  width: 88.w,
                  alignment: Alignment.centerLeft,
                  child: Text(_duration2String(_currentPos),
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.white, fontSize: 28.w))),
              Expanded(
                  child: ProgressBar(
                      value: _currentPos.inMilliseconds /
                          ((_duration.inMilliseconds == 0)
                              ? 1
                              : _duration.inMilliseconds),
                      onChange: (value) {
                        int targetPosition =
                            (value * _duration.inMilliseconds).toInt();
                        setState(() {
                          _currentPos = Duration(milliseconds: targetPosition);
                        });
                        player.seekTo(targetPosition);
                      })),
              Container(
                  width: 88.w,
                  alignment: Alignment.centerRight,
                  child: Text(_duration2String(_duration),
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.white, fontSize: 28.w))),
              SizedBox(width: 16.w),
              Image.asset("ic_full_screen".webp,
                  width: 36.w, height: 36.w, color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }

  void _controlHideTimer() {
    _hideTimer?.cancel();
    setState(() {
      _hidePanel = false;
    });
    if (!_hidePanel) {
      _hideTimer = Timer(const Duration(seconds: 5), () {
        setState(() {
          _hidePanel = true;
        });
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    player.removeListener(_playerValueChanged);
    _currentPosSubs?.cancel();
    _bufferingSubs?.cancel();
    _hideTimer?.cancel();
  }
}
