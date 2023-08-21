import 'package:flutter/material.dart';
import 'package:get/get_instance/src/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:joke_fun_flutter/common/view_state/view_state.dart';
import 'package:joke_fun_flutter/common/view_state/view_state_paging_controller.dart';

import 'cpn_default_view_state.dart';

abstract class CpnViewStateSliverList<T extends ViewStatePagingController>
    extends StatelessWidget {
  final String? tag;
  final bool bindViewState;
  T get controller => GetInstance().find<T>(tag: tag);

  const CpnViewStateSliverList(
      {Key? key, this.tag, this.bindViewState = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!lazyLoadData()) {
      controller.loadData();
    }
    return Obx(() {
      ViewState viewState = controller.viewState.value;
      SliverList sliverList = buildSliverList();

      // SliverList sliverList;
      // if (bindViewState) {
      //   if (viewState.isSuccess()) {
      //     sliverList = buildSliverList();
      //   } else if (viewState.isEmpty()) {
      //     sliverList = buildCustomEmptyWidget() ?? defaultSliverEmptyWidget(() {
      //       controller.loadData();
      //     });
      //   } else if (viewState.isFail()) {
      //     sliverList = buildCustomFailWidget() ?? defaultSliverFailWidget(viewState.errorCode, viewState.errorMessage,
      //             () {
      //           controller.loadData();
      //         });
      //   } else if (viewState.isError()) {
      //     sliverList = buildCustomErrorWidget() ?? defaultSliverErrorWidget(viewState.errorCode, viewState.errorMessage,
      //             () {
      //           controller.loadData();
      //         });
      //   } else if (viewState.isLoading()) {
      //     sliverList = buildCustomLoadingWidget() ?? defaultSliverLoadingWidget();
      //   } else {
      //     sliverList = buildCustomLoadingWidget() ?? defaultSliverLoadingWidget();
      //   }
      // } else {
      //   sliverList = buildSliverList();
      // }

      return sliverList;
    });
  }

  SliverList? buildCustomLoadingWidget() {
    return null;
  }

  SliverList? buildCustomFailWidget() {
    return null;
  }

  SliverList? buildCustomEmptyWidget() {
    return null;
  }

  SliverList? buildCustomErrorWidget() {
    return null;
  }


  SliverList buildSliverList();

  bool lazyLoadData() => false;

}
