import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/common/cpn/no_over_scroll_behavior.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';

/// 协调滚动布局页面基础组件
abstract class CpnNestedPage<T extends GetxController> extends StatelessWidget {
  final String? tag;

  CpnNestedPage({Key? key, this.tag}) : super(key: key);

  final ScrollController scrollController = ScrollController();

  T get logic => Get.find<T>(tag: tag);

  @override
  Widget build(BuildContext context) {
    preInit();
    return Scaffold(
        backgroundColor: ColorPalettes.instance.background,
        body: ScrollConfiguration(
          behavior: NoOverScrollBehavior(),
          child: ExtendedNestedScrollView(
              controller: scrollController,
              onlyOneScrollInBody: true,
              headerSliverBuilder: (context, value) {
                return [buildNestedHeader(context)];
              },
              pinnedHeaderSliverHeightBuilder: () {
                return pinnedHeaderHeight(context);
              },
              body: buildNestedBody(context)),
        ));
  }

  double pinnedHeaderHeight(BuildContext context) => 0.0;

  Widget buildNestedHeader(BuildContext context);

  Widget buildNestedBody(BuildContext context);

  void preInit() {}
}
