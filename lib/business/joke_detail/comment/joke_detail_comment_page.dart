import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/common/cpn/cpn_comment_item.dart';
import 'package:joke_fun_flutter/business/common/logic/joke_comment_list_logic.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state_sliver_body.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';

import '../../common/sheet/joke_comment_sheet.dart';

/// 段子详情页-评论
class JokeDetailCommentPage extends StatelessWidget {
  final int jokeId;
  final String? tag;
  final int totalCount;

  const JokeDetailCommentPage({super.key, this.tag, required this.jokeId, required this.totalCount});

  @override
  Widget build(BuildContext context) {
    JokeCommentListLogic logic =
        GetInstance().find<JokeCommentListLogic>(tag: tag);
    logic.totalNum.value = totalCount;
    return Column(
      children: [
        Expanded(
          child: _JokeDetailCommentList(tag: tag, jokeId: jokeId),
        ),
        Container(color: ColorPalettes.instance.divider, height: 2.w),
        cpnPostJokeComment(logic)
      ],
    );
  }
}

class _JokeDetailCommentList
    extends CpnViewStateSliverBody<JokeCommentListLogic> {
  final int jokeId;

  _JokeDetailCommentList({super.key, super.tag, required this.jokeId})
      : super(enableRefresh: false);

  @override
  void preInit() {
    super.preInit();
    logic.jokesId = jokeId;
  }

  @override
  bool lazyLoadData() {
    return true;
  }

  @override
  Widget buildSliverList() {
    var items = logic.dataList;
    return ListView.separated(
      separatorBuilder: (c, i) => Container(
          margin: EdgeInsets.symmetric(horizontal: 48.w),
          height: 1.w,
          color: ColorPalettes.instance.divider),
      itemCount: items.length,
      itemBuilder: (c, i) => CpnCommentItem(item: items[i], logic: logic),
    );
  }
}
