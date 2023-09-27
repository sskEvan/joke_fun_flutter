import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/common/logic/joke_comment_list_logic.dart';
import 'package:joke_fun_flutter/business/common/sheet/joke_comment_sheet.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_image.dart';
import 'package:joke_fun_flutter/common/ext/asset_ext.dart';
import 'package:joke_fun_flutter/common/ext/get_ext.dart';
import 'package:joke_fun_flutter/common/util/user_manager.dart';
import 'package:joke_fun_flutter/models/joke_comment_entity.dart';
import 'package:joke_fun_flutter/router/routers.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';
import 'package:lottie/lottie.dart';

/// 评论item组件
class CpnCommentItem extends StatelessWidget {
  final JokeComment item;
  final JokeCommentListLogic logic;

  const CpnCommentItem({Key? key, required this.item, required this.logic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 32.w, right: 32.w, top: 24.w, bottom: 8.w),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  AppRoutes.jumpPage(AppRoutes.userCenterPage, arguments: {
                    "index": "0",
                    "userId": (item.commentUser?.userId ?? 0).toString()
                  });
                },
                child: cpnCircleImage(
                    url: item.commentUser?.userAvatar, width: 80.w, height: 80.w),
              ),
              SizedBox(width: 32.w),
              _commentItemBody(item),
              SizedBox(width: 32.w),
              _commentItemLikeInfo(item),
            ],
          ),
          _subComments(item, logic)
        ],
      ),
    );
  }

  /// 评论列表item内容
  Widget _commentItemBody(JokeComment item) {
    List<Widget> bottomChildren = [];
    bottomChildren.add(Text(
      item.timeStr ?? "--",
      style: TextStyle(fontSize: 24.w, color: ColorPalettes.instance.thirdText),
    ));
    bottomChildren.add(GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Get.hideBottomSheet();
        logic.replyCommentId = item.commentId;
        logic.isReplyChild = false;
        showSendCommentSheet(logic);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 32.w),
        child: Text(
          "回复",
          style: TextStyle(
              fontSize: 24.w, color: ColorPalettes.instance.secondText),
        ),
      ),
    ));

    if (UserManager.instance.isSelf(item.commentUser?.userId)) {
      bottomChildren.add(GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          logic.deleteComment(item);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 32.w),
          child: Text(
            "删除",
            style: TextStyle(
                fontSize: 24.w, color: ColorPalettes.instance.primary),
          ),
        ),
      ));
    }
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.commentUser?.nickname ?? "--",
            style: TextStyle(
                fontSize: 28.w,
                color: ColorPalettes.instance.secondText,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.w),
          Text(
            item.content ?? "--",
            style: TextStyle(
                fontSize: 28.w, color: ColorPalettes.instance.firstText),
          ),
          Row(
            children: bottomChildren,
          )
        ],
      ),
    );
  }

  /// 评论item点赞信息
  Widget _commentItemLikeInfo(JokeComment item) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          logic.likeComment(item);
        },
        child: Column(
          children: [
            SizedBox(height: 24.w),
            Image.asset("ic_like_heart_fill".webp,
                width: 32.w,
                height: 32.w,
                color: (item.isLike == true)
                    ? ColorPalettes.instance.primary
                    : ColorPalettes.instance.thirdIcon),
            SizedBox(height: 8.w),
            Text(
              (item.likeNum ?? 0).toString(),
              style: TextStyle(
                  fontSize: 28.w, color: ColorPalettes.instance.thirdIcon),
            ),
          ],
        ));
  }

  /// 子评论列表
  Widget _subComments(JokeComment item, JokeCommentListLogic logic) {
    return ((item.itemCommentNum ?? 0) > 0)
        ? Padding(
      padding: EdgeInsets.only(left: 100.w),
      child: Column(
        children: [
          _subCommentBody(item, logic),
          _subCommentFooter(item, logic)
        ],
      ),
    )
        : const SizedBox();
  }

  /// 子评论列表内容区域
  Widget _subCommentBody(JokeComment item, JokeCommentListLogic logic) {
    bool showBody =
    ((item.itemCommentList?.isNotEmpty ?? false) && item.status != 0);
    debugPrint(
        "_subCommentBody : itemCommentList=${item.itemCommentList?.length},showBody=$showBody");
    return AnimatedSize(
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        child: showBody
            ? Column(
            children: item.itemCommentList!
                .map((e) => _subCommentItem(item, e))
                .toList())
            : const SizedBox(width: double.infinity, height: 0));
  }

  /// 子评论列表item
  Widget _subCommentItem(JokeComment parentComment, JokeSubComment item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 12.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              AppRoutes.jumpPage(AppRoutes.userCenterPage, arguments: {
                "index": "0",
                "userId": (item.commentUser?.userId ?? 0).toString()
              });
            },
            child: cpnCircleImage(
                url: item.commentUser?.userAvatar, width: 66.w, height: 66.w),
          ),
          SizedBox(width: 16.w),
          _subCommentItemBody(parentComment, item),
        ],
      ),
    );
  }

  /// 子评论列表item内容区域
  Widget _subCommentItemBody(JokeComment parentComment, JokeSubComment item) {
    List<Widget> bottomChildren = [];
    bottomChildren.add(Text(
      item.timeStr ?? "--",
      style: TextStyle(fontSize: 24.w, color: ColorPalettes.instance.thirdText),
    ));
    bottomChildren.add(GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Get.hideBottomSheet();
        logic.replyCommentId = item.commentItemId;
        logic.isReplyChild = true;
        showSendCommentSheet(logic);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 32.w),
        child: Text(
          "回复",
          style: TextStyle(
              fontSize: 24.w, color: ColorPalettes.instance.secondText),
        ),
      ),
    ));

    if (UserManager.instance.isSelf(item.commentUser?.userId)) {
      bottomChildren.add(GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          logic.deleteSubComment(parentComment, item);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 32.w),
          child: Text(
            "删除",
            style: TextStyle(
                fontSize: 24.w, color: ColorPalettes.instance.primary),
          ),
        ),
      ));
    }
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (item.isReplyChild == true) ? ("${item.commentUser?.nickname ?? "--"}  ➡  ️${item.commentedNickname ?? "--"}") : (item.commentUser?.nickname ?? "--"),
            style: TextStyle(
                fontSize: 28.w,
                color: ColorPalettes.instance.secondText,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.w),
          Text(
            item.content ?? "--",
            style: TextStyle(
                fontSize: 28.w, color: ColorPalettes.instance.firstText),
          ),
          Row(
            children: bottomChildren,
          ),
        ],
      ),
    );
  }

  /// 子评论底部提示
  Widget _subCommentFooter(JokeComment item, JokeCommentListLogic logic) {
    Widget tipWidget;

    String tip = " -- 展开${item.itemCommentNum}条回复  ";
    if (item.status == 2) {
      tip = " -- 展开剩余回复  ";
    } else if (item.status == 3) {
      tip = " -- 收起  ";
    }
    tipWidget = Text(
      tip,
      style: TextStyle(fontSize: 24.w, color: ColorPalettes.instance.thirdText),
    );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        logic.expandSubComments(item);
      },
      child: Container(
        height: 72.w,
        alignment: Alignment.center,
        child: (item.status == 1)
            ? ColorFiltered(
            colorFilter: ColorFilter.mode(
              ColorPalettes.instance.secondary,
              BlendMode.srcIn,
            ),
            child: Lottie.asset("view_loading_2".lottie, height: 72.w))
            : Row(
          children: [
            tipWidget,
            Transform.rotate(
              angle: item.status == 3 ? pi : 0,
              child: Image.asset("ic_expand".webp,
                  width: 16.w,
                  height: 16.w,
                  color: ColorPalettes.instance.thirdIcon),
            )
          ],
        ),
      ),
    );
  }
}
