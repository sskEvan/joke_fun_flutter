import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joke_fun_flutter/models/comment_entity.dart';
import 'package:joke_fun_flutter/router/routers.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';

/// 用户评论列表item组件
class CpnUserCommentItem extends StatelessWidget {
  final CommentEntity commentEntity;
  const CpnUserCommentItem({Key? key, required this.commentEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var titleSplit = commentEntity.msgItemTypeDesc?.split("%s").toList() ?? [];
    var title = (titleSplit.length == 2)
        ? RichText(
        text: TextSpan(
            text: titleSplit[0],
            style: TextStyle(
                color: ColorPalettes.instance.firstText,
                fontSize: 30.w,
                fontWeight: FontWeight.w500),
            children: [
              TextSpan(
                  text: " ${commentEntity.targetNickname} ",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      AppRoutes.jumpPage(AppRoutes.userCenterPage,
                          arguments: {
                            "index": "0",
                            "userId": (commentEntity.targetUserId ?? 0).toString()
                          });
                    },
                  style: TextStyle(
                      color: ColorPalettes.instance.primary,
                      fontSize: 30.w,
                      fontWeight: FontWeight.w500)),
              TextSpan(
                  text: titleSplit[1],
                  style: TextStyle(
                      color: ColorPalettes.instance.firstText,
                      fontSize: 30.w,
                      fontWeight: FontWeight.w500))
            ]))
        : Text(commentEntity.msgItemTypeDesc ?? "--",
        style: TextStyle(
            color: ColorPalettes.instance.firstText, fontSize: 28.w));
    return InkWell(
      onTap: () {
        Map<String, dynamic> arguments = {
          "jokeId": commentEntity.targetId,
          "commentEntity": commentEntity,
        };
        AppRoutes.jumpPage(AppRoutes.commentDetailPage, arguments: arguments);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title,
            SizedBox(height: 16.w),
            Text(commentEntity.content ?? "--",
                style: TextStyle(
                    color: ColorPalettes.instance.secondText, fontSize: 24.w),
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
            SizedBox(height: 24.w),
            Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  width: 6.w,
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorPalettes.instance.secondary,
                        borderRadius: BorderRadius.circular(3.w)), // 红色背景
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 24.w), // 左边距
                  child: Text(commentEntity.extraContent ?? "--",
                      style: TextStyle(
                          color: ColorPalettes.instance.firstText,
                          fontSize: 30.w),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            SizedBox(height: 14.w),
            Text(commentEntity.msgTime ?? "--",
                style: TextStyle(
                    color: ColorPalettes.instance.thirdText, fontSize: 24.w))
          ],
        ),
      ),
    );
  }
}
