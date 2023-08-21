import 'package:flutter/material.dart';
import 'package:joke_fun_flutter/common/cpn/no_over_scroll_behavior.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../view_state/view_state_paging_controller.dart';
import 'cpn_view_state.dart';

abstract class CpnViewStatePaging<T extends ViewStatePagingController>
    extends CpnViewState<T> {
  bool enableRefresh;
  bool enableLoadMore;

  CpnViewStatePaging(
      {Key? key, this.enableRefresh = true, this.enableLoadMore = true})
      : super(key: key);

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget buildBody(context) {
    return ScrollConfiguration(
      behavior: NoOverScrollBehavior(),
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          scrollNotificationCallback(scrollNotification);
          return false;
        },
        child: SmartRefresher(
            controller: _refreshController,
            enablePullDown:
                controller.viewState.value.isSuccess() && enableRefresh,
            enablePullUp:
                controller.viewState.value.isSuccess() && enableLoadMore,
            onRefresh: () {
              controller.refreshPaging(_refreshController);
            },
            onLoading: () {
              controller.loadMorePaging(_refreshController);
            },
            child: buildPagingList()),
      ),
    );
  }

  void scrollNotificationCallback(ScrollNotification scrollNotification) {}

  Widget buildPagingList();
}
