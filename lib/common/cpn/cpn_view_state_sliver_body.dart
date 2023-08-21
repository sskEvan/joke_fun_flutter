import 'package:flutter/cupertino.dart';
import 'package:get/get_instance/src/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:joke_fun_flutter/common/cpn/no_over_scroll_behavior.dart';
import 'package:joke_fun_flutter/common/view_state/view_state.dart';
import 'package:joke_fun_flutter/common/view_state/view_state_paging_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'cpn_default_view_state.dart';

abstract class CpnViewStateSliverBody<T extends ViewStatePagingController>
    extends StatelessWidget {
  bool enableRefresh;
  bool enableLoadMore;

  CpnViewStateSliverBody(
      {Key? key,
      this.tag,
      this.bindViewState = true,
      this.enableRefresh = true,
      this.enableLoadMore = true})
      : super(key: key);

  final String? tag;
  final bool bindViewState;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  T get controller => GetInstance().find<T>(tag: tag);

  @override
  Widget build(BuildContext context) {
    if(!lazyLoadData()) {
      controller.loadData();
    }
    return Obx(() {
      ViewState viewState = controller.viewState.value;
      List<Widget> slivers = <Widget>[];
      if (bindViewState) {
        if (viewState.isSuccess()) {
          slivers.add(buildSliverList());
        } else if (viewState.isEmpty()) {
          slivers.add(buildCustomEmptyWidget() ??
                  defaultSliverEmptyWidget(() {
                    controller.loadData();
                  }));
        } else if (viewState.isFail()) {
          slivers.add(buildCustomFailWidget() ??
                  defaultSliverFailWidget(viewState.errorCode, viewState.errorMessage,
                      () {
                    controller.loadData();
                  }));
        } else if (viewState.isError()) {
          slivers.add(buildCustomErrorWidget() ??
                  defaultSliverErrorWidget(
                      viewState.errorCode, viewState.errorMessage, () {
                    controller.loadData();
                  }));
        } else if (viewState.isLoading()) {
          slivers.add(buildCustomLoadingWidget() ?? defaultSliverLoadingWidget());
        } else {
          slivers.add(buildCustomLoadingWidget() ?? defaultSliverLoadingWidget());
        }
      } else {
        slivers.add(buildSliverList());
      }

      return ScrollConfiguration(
          behavior: NoOverScrollBehavior(),
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              scrollNotificationCallback(scrollNotification);
              return false;
            },
            child: SmartRefresher(
                controller: refreshController,
                enablePullDown:
                    (viewState.isSuccess() || !bindViewState) && enableRefresh,
                enablePullUp:
                    (viewState.isSuccess() || !bindViewState) && enableLoadMore,
                onRefresh: () {
                  controller.refreshPaging(refreshController);
                },
                onLoading: () {
                  controller.loadMorePaging(refreshController);
                },
                child: CustomScrollView(slivers: slivers)),
          ));
    });
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

  SliverList buildSliverList();

  bool lazyLoadData() => false;
}
