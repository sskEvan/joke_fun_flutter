import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/common/cpn/cpn_comment_item.dart';
import 'package:joke_fun_flutter/business/common/logic/joke_comment_list_logic.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state_paging.dart';
import 'package:joke_fun_flutter/common/ext/asset_ext.dart';
import 'package:joke_fun_flutter/common/util/log_util.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';

/// 显示评论底部弹框
void showJokeCommentSheet(BuildContext context, int jokesId, int totalCount) {
  String controllerTag = DateTime.now().millisecondsSinceEpoch.toString();
  Get.lazyPut(() => JokeCommentListLogic(), tag: controllerTag);
  JokeCommentListLogic logic =
      GetInstance().find<JokeCommentListLogic>(tag: controllerTag);
  logic.totalNum.value = totalCount;

  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
              color: ColorPalettes.instance.background,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.w),
                  topRight: Radius.circular(32.w))),
          constraints: BoxConstraints(maxHeight: 1200.w),
          child: Column(children: [
            _jokeCommentSheetTitle(context, logic),
            Container(color: ColorPalettes.instance.divider, height: 2.w),
            Expanded(
                child: _JokeCommentList(jokeId: jokesId, tag: controllerTag)),
            Container(color: ColorPalettes.instance.divider, height: 2.w),
            cpnPostJokeComment(logic),
          ]),
        );
      },
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.w),
              topRight: Radius.circular(32.w))));
}

/// 评论底部弹框标题
Widget _jokeCommentSheetTitle(
    BuildContext context, JokeCommentListLogic logic) {
  return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 32.w),
      height: 100.w,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Obx(() {
              return Text(
                "全部评论(${logic.totalNum})",
                style: TextStyle(
                    fontSize: 32.w, color: ColorPalettes.instance.firstText),
              );
            }),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Image.asset(
                  "ic_close".webp,
                  width: 32.w,
                  height: 32.w,
                  color: ColorPalettes.instance.firstIcon,
                ),
              ),
            ),
          )
        ],
      ));
}

/// 评论列表
class _JokeCommentList extends CpnViewStatePaging<JokeCommentListLogic> {
  final int jokeId;

  _JokeCommentList({Key? key, required this.jokeId, super.tag})
      : super(key: key);

  @override
  void preInit() {
    super.preInit();
    logic.jokesId = jokeId;
  }

  @override
  bool resizeToAvoidBottomInset() => false;

  @override
  bool autoLoadData() => true;

  @override
  Widget buildPagingList() {
    LogE("showJokeCommentSheet rebuild");
    var items = logic.dataList;
    return ListView.separated(
      separatorBuilder: (c, i) => Container(
          margin: EdgeInsets.symmetric(horizontal: 48.w),
          height: 1.w,
          color: ColorPalettes.instance.divider),
      physics: const ClampingScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (c, i) => CpnCommentItem(item: items[i], logic: logic),
    );
  }

}

Widget cpnPostJokeComment(JokeCommentListLogic logic) {
  return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 15.w),
      height: 130.w,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              showSendCommentSheet(logic);
            },
            child: Container(
              height: 100.w,
              width: 600.w,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              decoration: BoxDecoration(
                  color: ColorPalettes.instance.inputBackground,
                  borderRadius: BorderRadius.circular(56.w)),
              child: Obx(() {
                return Text(
                  logic.isInputValid.value
                      ? logic.commentInput.value
                      : "请留下您的精彩评论吧~",
                  style: TextStyle(
                      fontSize: 30.w, color: ColorPalettes.instance.secondText),
                );
              }),
            ),
          ),
          SizedBox(
            width: 24.w,
          ),
          GestureDetector(
            onTap: () {
              if (logic.replyCommentId == null) {
                logic.postComment();
              } else {
                logic.postSubComment();
              }
            },
            child: Obx(() {
              return Image.asset(
                "ic_send".webp,
                width: 56.w,
                height: 56.w,
                color: logic.isInputValid.value
                    ? ColorPalettes.instance.primary
                    : ColorPalettes.instance.thirdIcon,
              );
            }),
          )
        ],
      ));
}

/// 显示输入评论底部弹框
/// commentId：评论id，回复评论使用，为null的话表示回复帖子
/// isReplyChild：是否是回复子评论
void showSendCommentSheet(JokeCommentListLogic logic,
    {bool isReplyChild = false}) {
  Get.bottomSheet(
    Container(
        height: 130.w,
        color: ColorPalettes.instance.background,
        child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 15.w),
            height: 130.w,
            child: Row(
              children: [
                Container(
                  width: 600.w,
                  height: 100.w,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  decoration: BoxDecoration(
                      color: ColorPalettes.instance.inputBackground,
                      borderRadius: BorderRadius.circular(56.w)),
                  child: TextField(
                    autofocus: true,
                    style: TextStyle(
                        fontSize: 30.w,
                        color: ColorPalettes.instance.secondText),
                    maxLines: 1,
                    cursorColor: ColorPalettes.instance.primary,
                    decoration: InputDecoration(
                      hintText: "请留下您的精彩评论吧~",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          fontSize: 30.w,
                          color: ColorPalettes.instance.secondText),
                    ),
                    onChanged: (value) {
                      logic.updateCommentInput(value);
                    },
                  ),
                ),
                SizedBox(
                  width: 24.w,
                ),
                Obx(() {
                  return GestureDetector(
                    onTap: () {
                      if (logic.replyCommentId == null) {
                        logic.postComment();
                      } else {
                        logic.postSubComment();
                      }
                    },
                    child: Image.asset(
                      "ic_send".webp,
                      width: 56.w,
                      height: 56.w,
                      color: logic.isInputValid.value
                          ? ColorPalettes.instance.primary
                          : ColorPalettes.instance.thirdIcon,
                    ),
                  );
                })
              ],
            ))),
    isScrollControlled: true,
    // barrierColor: Colors.transparent,
    backgroundColor: ColorPalettes.instance.background,
  );
}
