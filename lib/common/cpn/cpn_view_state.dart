import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/common/view_state/view_state.dart';
import 'package:joke_fun_flutter/common/view_state/view_state_logic.dart';

import '../../theme/color_palettes.dart';
import 'cpn_default_view_state.dart';

/// 页面状态自动切换组件（加载中、加载失败、网络错误、空布局、成功页面）
abstract class CpnViewState<T extends ViewStateLogic> extends StatelessWidget {
  const CpnViewState({Key? key, this.tag, this.bindViewState = true})
      : super(key: key);

  final bool bindViewState;
  final String? tag;

  T get logic => GetInstance().find<T>(tag: tag);

  @override
  Widget build(BuildContext context) {
    preInit();
    if (!autoLoadData()) {
      logic.loadData();
    }
    return Obx(() {
      ViewState viewState = logic.viewState.value;
      Widget child;
      if (bindViewState) {
        if (viewState.isSuccess()) {
          child = buildBody(context);
        } else if (viewState.isEmpty()) {
          child = buildCustomEmptyWidget() ??
              defaultEmptyWidget(() {
                logic.loadData();
              });
        } else if (viewState.isFail()) {
          child = buildCustomFailWidget() ??
              defaultFailWidget(viewState.errorCode, viewState.errorMessage,
                  () {
                logic.loadData();
              });
        } else if (viewState.isError()) {
          child = buildCustomErrorWidget() ??
              defaultErrorWidget(viewState.errorCode, viewState.errorMessage,
                  () {
                logic.loadData();
              });
        } else if (viewState.isLoading()) {
          child = buildCustomLoadingWidget() ?? defaultLoadingWidget();
        } else {
          child = buildCustomLoadingWidget() ?? defaultLoadingWidget();
        }
      } else {
        child = buildBody(context);
      }

      return useScaffold()
          ? Scaffold(
              appBar: buildAppBar(),
              resizeToAvoidBottomInset: resizeToAvoidBottomInset(),
              backgroundColor: backgroundColor(),
              body: child)
          : child;
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

  bool autoLoadData() => false;

  bool useScaffold() => true;

  bool resizeToAvoidBottomInset() => true;

  void preInit() {}

  Color backgroundColor() => ColorPalettes.instance.background;
}
