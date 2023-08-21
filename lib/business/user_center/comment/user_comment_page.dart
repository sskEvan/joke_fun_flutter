import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state_sliver_body.dart';

import 'user_comment_logic.dart';

class UserCommentPage extends CpnViewStateSliverBody<UserCommentLogic> {
  UserCommentPage({super.key}) : super(bindViewState: false);

  @override
  SliverList buildSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Container(
            alignment: Alignment.center,
            height: 100.w,
            child: Text("$index"),
          );
        },
        childCount: 100,
      ),
    );
  }
}
