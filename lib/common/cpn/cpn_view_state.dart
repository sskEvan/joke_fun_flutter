import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:joke_fun_flutter/common/view_state/view_state.dart';
import 'package:joke_fun_flutter/common/view_state/view_state_controller.dart';

import '../../theme/color_palettes.dart';
import 'app_bar.dart';
import 'cpn_default_view_state.dart';

abstract class CpnViewState<T extends ViewStateController>
    extends StatelessWidget {
  const CpnViewState({Key? key, this.tag, this.bindViewState = true})
      : super(key: key);

  final String? tag;
  final bool bindViewState;

  T get controller => GetInstance().find<T>(tag: tag);

  @override
  Widget build(BuildContext context) {
    if (!lazyLoadData()) {
      controller.loadData();
    }
    return Obx(() {
      ViewState viewState = controller.viewState.value;
      Widget child;
      if (bindViewState) {
        if (viewState.isSuccess()) {
          child = buildBody(context);
        } else if (viewState.isEmpty()) {
          child = buildCustomEmptyWidget() ??
              defaultEmptyWidget(() {
                controller.loadData();
              });
        } else if (viewState.isFail()) {
          child = buildCustomFailWidget() ??
              defaultFailWidget(viewState.errorCode, viewState.errorMessage,
                  () {
                controller.loadData();
              });
        } else if (viewState.isError()) {
          child = buildCustomErrorWidget() ??
              defaultErrorWidget(viewState.errorCode, viewState.errorMessage,
                  () {
                controller.loadData();
              });
        } else if (viewState.isLoading()) {
          child = buildCustomLoadingWidget() ?? defaultLoadingWidget();
        } else {
          child = Container();
        }
      } else {
        child = buildBody(context);
      }
      return Scaffold(
          appBar: buildAppBar(),
          backgroundColor: ColorPalettes.instance.background,
          body: child);
    });
  }

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

  AppBar? buildAppBar() {
    return null;
  }

  Widget buildBody(BuildContext context);

  bool lazyLoadData() => false;
}
