import 'package:flutter/material.dart';
import 'package:joke_fun_flutter/common/cpn/no_over_scroll_behavior.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../view_state/view_state_paging_logic.dart';
import 'cpn_view_state.dart';

abstract class CpnViewStatePaging<T extends ViewStatePagingLogic>
    extends CpnViewState<T> {
  bool enableRefresh;
  bool enableLoadMore;

  CpnViewStatePaging(
      {Key? key, super.tag, this.enableRefresh = true, this.enableLoadMore = true})
      : super(key: key);

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void preInit() {
    super.preInit();
    logic.refreshController = _refreshController;
  }

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
                logic.viewState.value.isSuccess() && enableRefresh,
            enablePullUp:
                logic.viewState.value.isSuccess() && enableLoadMore,
            onRefresh: () {
              logic.refreshPaging();
            },
            onLoading: () {
              logic.loadMorePaging();
            },
            child: buildPagingList()),
      ),
    );
  }

  void scrollNotificationCallback(ScrollNotification scrollNotification) {}

  Widget buildPagingList();
}
