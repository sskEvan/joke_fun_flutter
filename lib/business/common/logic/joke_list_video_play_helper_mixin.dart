import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/common/event/app_lifecycle_state_event.dart';
import 'package:joke_fun_flutter/business/common/event/home_tab_index_changed_event.dart';
import 'package:joke_fun_flutter/business/common/event/index_navigation_index_changed_event.dart';
import 'package:joke_fun_flutter/business/home/home_logic.dart';
import 'package:joke_fun_flutter/business/index/index_logic.dart';
import 'package:joke_fun_flutter/common/util/event_bus_manager.dart';
import 'package:joke_fun_flutter/models/joke_detail_entity.dart';
import 'package:joke_fun_flutter/router/routers.dart';
import 'package:video_player/video_player.dart';

/// 段子列表视频播放控制辅助类
abstract mixin class JokeListVideoPlayHelperMixin {

  /// 视频播放控制器
  ChewieController? chewieController;
  VideoPlayerController? videoPlayerController;

  /// IndexPage的页面index
  int indexPageIndex = 0;

  /// HomePage的页面index
  int homePageIndex = 1;

  /// 当前视频列表所有已经完全显示的视频item的index集合
  final List<int> _allDisplayVideoIndexes = [];

  /// 当前播放的视频在列表中的索引，由curPlayIndex来驱动视频播放
  final RxInt _curPlayIndex = (-1).obs;

  /// 当前视频列表第一个完全显示的视频item的index
  int _firstAllDisplayIndex = -1;

  /// 延时播放timer
  Timer? _delayTimer;

  /// 当前列表是否在滑动中，滑动介绍后将延迟100ms后播放以一个完全显示的视频item
  bool _isScrolling = false;

  /// 当前视频是否处于活跃状态（当前视频所在页面是否正显示在屏幕上）
  bool _isVideoActive = false;

  /// 标记app是否退到后台
  bool _appResuming = true;

  /// 视频所属段子id(每个段子列表页面独自维护)
  int? _jokeId;

  late StreamSubscription _indexPageIndexSubscription;
  late StreamSubscription _homePageIndexSubscription;
  late StreamSubscription _lifecycleStateSubscription;

  void monitorVideoActive() {
    ever(AppRoutes.curPage, (value) {
      _controlPlayStatus();
    });

    _indexPageIndexSubscription =
        eventBus.on<IndexNavigationIndexChangedEvent>().listen((event) {
      indexPageIndex = event.index;
      _controlPlayStatus();
    });

    _homePageIndexSubscription =
        eventBus.on<HomeTabIndexChangedEvent>().listen((event) {
      homePageIndex = event.index;
      _controlPlayStatus();
    });

    _lifecycleStateSubscription =
        eventBus.on<AppLifecycleStateEvent>().listen((event) {
      _appResuming = event.state == AppLifecycleState.resumed;
      _controlPlayStatus();
    });

    indexPageIndex = Get.find<IndexLogic>().index.value;
    homePageIndex = Get.find<HomeLogic>().index.value;
    _controlPlayStatus();
  }

  void disposePlayer() {
    resetPlayList();
    videoPlayerController?.dispose();
    chewieController?.dispose();
    _indexPageIndexSubscription.cancel();
    _homePageIndexSubscription.cancel();
    _lifecycleStateSubscription.cancel();
  }

  bool judgeVideoActive();

  void scrollNotificationCallback(ScrollNotification scrollNotification) {
    if (scrollNotification is ScrollStartNotification ||
        scrollNotification is ScrollUpdateNotification) {
      _isScrolling = true;
    } else {
      if (_isScrolling = true) {
        _isScrolling = false;
        _updatePlayIndex();
      }
    }
  }

  void calculatePendingPlayIndex(int index, double visibleFraction) {
    if (!_isVideoActive) {
      return;
    }
    if (chewieController?.isFullScreen == true) {
      return;
    }
    if (visibleFraction == 1) {
      if (!_allDisplayVideoIndexes.contains(index)) {
        _allDisplayVideoIndexes.add(index);
      }
    } else {
      _allDisplayVideoIndexes.remove(index);
    }
    _allDisplayVideoIndexes.sort((a, b) => a.compareTo(b));
    _firstAllDisplayIndex = _allDisplayVideoIndexes.firstOrNull ?? -1;
    if (!_isScrolling) {
      _updatePlayIndex();
    }
  }

  void _updatePlayIndex() {
    if (!_isVideoActive) {
      return;
    }
    if (chewieController?.isFullScreen == true) {
      return;
    }
    if (_curPlayIndex.value != _firstAllDisplayIndex &&
        _firstAllDisplayIndex != -1) {
      if (_delayTimer != null && _delayTimer!.isActive) {
        _delayTimer!.cancel();
      }
      _delayTimer = Timer(const Duration(milliseconds: 100), () {
        _curPlayIndex.value = _firstAllDisplayIndex;
      });
    }
  }

  /// 初始化视频播放器，由curPlayIndex驱动，然后进行视频播放
  void initVideoPlayer(
      int? jokeId, String? testVideoId, double aspectRatio, bool multiplex, Widget skin) {
    if (!_isVideoActive) {
      return;
    }
    if (chewieController?.isFullScreen == true) {
      return;
    }

    /// 段子id的视频，直接复用
    if (jokeId == _jokeId && multiplex) {
      return;
    }
    videoPlayerController?.dispose();
    chewieController?.dispose();
    _jokeId = jokeId;
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(testVideoId ?? ""));

    chewieController = ChewieController(
        videoPlayerController: videoPlayerController!,
        showControlsOnInitialize: false,
        autoPlay: true,
        looping: true,
        useRootNavigator: true,
        aspectRatio: aspectRatio,
        // 自定义播放布局
        customControls: skin);
  }

  /// 手动播放视频，例如在屏幕上同事出现多个完全显示的视频item，最前面的视频item正在播放中，用户点击了后面的视频item播放按钮或者跳到其详情页
  void manualPlay(int? jokeId, int index) {
      _jokeId = jokeId;
      _curPlayIndex.value = index;
  }

  /// 根据列表索引，判断某个item视频是否需要自动播放
  bool needAutoPlay(int index) => _curPlayIndex.value == index;

  void resetPlayList() {
    if (!_isVideoActive) {
      return;
    }
    videoPlayerController?.pause();
    _jokeId = null;
    _allDisplayVideoIndexes.clear();
    _firstAllDisplayIndex = -1;
    _curPlayIndex.value = -1;
  }

  void _controlPlayStatus() {
    /// 处理详情页需要和列表页item共享一个播放器
    bool shareSamePlayerInDetailPage = false;
    if(AppRoutes.curPage.value == AppRoutes.jokeDetailPage) {
      JokeDetailEntity? jokeDetailEntity = Get.arguments?["jokeDetailEntity"];
      if (jokeDetailEntity != null) {
        shareSamePlayerInDetailPage = jokeDetailEntity.joke?.jokesId == _jokeId &&
            AppRoutes.curPage.value == AppRoutes.jokeDetailPage;
      }
    }
    _isVideoActive =
        (judgeVideoActive() || shareSamePlayerInDetailPage) && _appResuming;
    if (_isVideoActive) {
      _startPlayIfNeeded();
    } else {
      _pausePlayIfNeeded();
    }
  }

  void _pausePlayIfNeeded() {
    if (videoPlayerController?.value.isInitialized == true) {
      chewieController?.pause();
    }
  }

  void _startPlayIfNeeded() {
    if (videoPlayerController?.value.isInitialized == true) {
      chewieController?.play();
    }
  }
}
