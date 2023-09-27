import 'package:flutter/cupertino.dart';
import 'package:get/get_instance/src/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:joke_fun_flutter/common/cpn/no_over_scroll_behavior.dart';
import 'package:joke_fun_flutter/common/view_state/view_state.dart';
import 'package:joke_fun_flutter/common/view_state/view_state_paging_logic.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'cpn_default_view_state.dart';

/// 协调滚动布局页面body组件，自动切换页面状态（加载中、加载失败、网络错误、空布局、成功页面）
/// 和CpnNestedPage搭配使用
abstract class CpnViewStateSliverBody<T extends ViewStatePagingLogic>
    extends StatelessWidget {
  bool enableRefresh;
  bool enableLoadMore;

  CpnViewStateSliverBody({Key? key,
    this.tag,
    this.bindViewState = true,
    this.enableRefresh = true,
    this.enableLoadMore = true})
      : super(key: key);

  final bool bindViewState;
  final RefreshController refreshController =
  RefreshController(initialRefresh: false);
  final String? tag;

  T get logic => GetInstance().find<T>(tag: tag);

  @override
  Widget build(BuildContext context) {
    preInit();
    if (!lazyLoadData()) {
      logic.loadData();
    }
    return Obx(() {
      ViewState viewState = logic.viewState.value;
      if (bindViewState) {
        if (viewState.isSuccess()) {
          return _buildSuccessContent();
        } else if (viewState.isEmpty()) {
          return buildCustomEmptyWidget() ??
              defaultSliverEmptyWidget(() {
                logic.loadData();
              });
        } else if (viewState.isFail()) {
          return buildCustomFailWidget() ??
              defaultSliverFailWidget(
                  viewState.errorCode, viewState.errorMessage, () {
                logic.loadData();
              });
        } else if (viewState.isError()) {
          return buildCustomErrorWidget() ??
              defaultSliverErrorWidget(
                  viewState.errorCode, viewState.errorMessage, () {
                logic.loadData();
              });
        } else if (viewState.isLoading()) {
          return buildCustomLoadingWidget() ?? defaultSliverLoadingWidget();
        } else {
          return buildCustomLoadingWidget() ?? defaultSliverLoadingWidget();
        }
      } else {
        return _buildSuccessContent();
      }
    });
  }

  Widget _buildSuccessContent() {
    return ScrollConfiguration(
        behavior: NoOverScrollBehavior(),
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            scrollNotificationCallback(scrollNotification);
            return false;
          },
          child: SmartRefresher(
              controller: refreshController,
              enablePullDown: enableRefresh,
              enablePullUp: enableLoadMore,
              onRefresh: () {
                logic.refreshPaging();
              },
              onLoading: () {
                logic.loadMorePaging();
              },
              child: buildSliverList()),
        ));
  }

  void scrollNotificationCallback(ScrollNotification scrollNotification) {}

  Widget? buildCustomLoadingWidget() {
    return null;
  }

  Widget? buildCustomFailWidget() {
    return null;
  }

  Widget? buildCustomEmptyWidget() {
    return null;
  }

  Widget? buildCustomErrorWidget() {
    return null;
  }

  Widget buildSliverList();

  bool lazyLoadData() => false;

  void preInit() {
    logic.refreshController = refreshController;
  }
}
