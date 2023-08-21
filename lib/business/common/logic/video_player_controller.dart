import 'dart:async';
import 'dart:math';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../common/util/log_util.dart';
import '../../../common/util/media_util.dart';
import '../../../models/joke_detail_entity.dart';

class VideoListPlayerController extends GetxController {
  final List<int> _allDisplayVideoIndexes = [];
  RxInt curPlayIndex = (-1).obs;
  int _visibleIndex = -1;
  Timer? _delayTimer;
  ValueKey<String>? _lastPlayListKey;
  bool isScrolling = false;
  FijkPlayer? _player;

  FijkPlayer startPlayVideo(JokeDetailEntity jokeDetailEntity) {
    if (_player != null) {
      _player?.stop();
      _player?.release();
    }
    String realUrl = decodeMediaUrl(jokeDetailEntity.joke?.videoUrl);
    List<String> testUrls = [
      "http://video.chinanews.com/flv/2019/04/23/400/111773_web.mp4",
      "https://v-cdn.zjol.com.cn/276982.mp4",
      "https://v-cdn.zjol.com.cn/280443.mp4",
      "https://v-cdn.zjol.com.cn/276984.mp4",
      "https://v-cdn.zjol.com.cn/276985.mp4",
      realUrl
    ];
    _player = FijkPlayer()
      ..setDataSource(testUrls[Random().nextInt(testUrls.length)],
          autoPlay: true);
    return _player!;
  }

  void calculatePendingPlayIndex(
      ValueKey<String>? playListKey, int index, double visibleFraction) {
    if (_lastPlayListKey != playListKey) {
      _resetPlayList(playListKey);
    }

    if (visibleFraction == 1) {
      if (!_allDisplayVideoIndexes.contains(index)) {
        _allDisplayVideoIndexes.add(index);
      }
    } else {
      _allDisplayVideoIndexes.remove(index);
    }
    _allDisplayVideoIndexes.sort((a, b) => a.compareTo(b));
    _visibleIndex = _allDisplayVideoIndexes.firstOrNull ?? -1;
    if (!isScrolling) {
      updatePlayIndex();
    }
  }

  void _resetPlayList(ValueKey<String>? playListKey) {
    _allDisplayVideoIndexes.clear();
    _visibleIndex = -1;
    curPlayIndex.value = -1;
    _lastPlayListKey = playListKey;
    if (_player != null) {
      _player?.stop();
      _player?.release();
    }
  }

  void updatePlayIndex() {
    if (curPlayIndex.value != _visibleIndex && _visibleIndex != -1) {
      if (_delayTimer != null && _delayTimer!.isActive) {
        _delayTimer!.cancel();
      }
      _delayTimer = Timer(const Duration(milliseconds: 100), () {
        curPlayIndex.value = _visibleIndex;
      });
    }
  }

  void pausePlayer() {
    _player?.pause();
  }

  void startPlayer() {
    _player?.start();
  }

  void _playerStateChanged() {
    FijkValue? value = _player?.value;
    FijkState? state = _player?.state;

    LogD("播放器状态>>>>>>>>>$value,state=$state");
  }
}
