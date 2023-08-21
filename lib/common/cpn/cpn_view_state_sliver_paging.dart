import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state_paging.dart';
import 'package:joke_fun_flutter/common/cpn/sliver_header_delegate.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../theme/color_palettes.dart';
import '../view_state/view_state_paging_controller.dart';
import 'cpn_view_state.dart';

abstract class CpnViewStateSliverPaging<T extends ViewStatePagingController>
    extends CpnViewStatePaging<T> {

  CpnViewStateSliverPaging(
      {Key? key, super.enableRefresh = true, super.enableLoadMore = true})
      : super(key: key);

  @override
  Widget buildPagingList() {
    List<Widget> slivers = <Widget>[];
    Widget? sliverScrollHeader = buildSliverScrollHeader();
    if (sliverScrollHeader != null) {
      slivers.add(
        SliverToBoxAdapter(
          child: sliverScrollHeader,
        ),
      );
    }
    Widget? sliverPersistentHeader = buildSliverPersistentHeader();
    if (sliverPersistentHeader != null) {
      slivers.add(sliverPersistentHeader);
    }

    slivers.add(buildSliverList());
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: slivers,
    );
  }

  Widget? buildSliverScrollHeader() => null;

  SliverPersistentHeader? buildSliverPersistentHeader() => null;

  SliverList buildSliverList();


}
