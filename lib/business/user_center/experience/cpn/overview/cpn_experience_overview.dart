import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joke_fun_flutter/business/user_center/experience/cpn/overview/experience_overview_logic.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';

/// 我的乐豆概览组件
class CpnExperienceOverview extends CpnViewState<ExperienceOverviewLogic> {
  const CpnExperienceOverview({Key? key})
      : super(key: key, bindViewState: false);

  @override
  Widget buildBody(BuildContext context) {
    var curLevel = int.parse(logic.overviewEntity.value?.experienceRank ?? "0");
    return Stack(
      children: [
        Container(
            height: 580.w,
            padding: EdgeInsets.only(top: 88.w),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ColorPalettes.instance.primary,
                      ColorPalettes.instance.secondary
                    ]),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100.w),
                    bottomRight: Radius.circular(100.w)))),
        Container(
          margin: EdgeInsets.only(top: 88.w),
          child: _ExperienceOverview(
              size: Size(double.infinity, 400.w), level: curLevel.toDouble()),
        ),
        Container(
          margin: EdgeInsets.only(top: 228.w),
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Text(
                "我的等级",
                style: TextStyle(
                    color: Colors.white, fontSize: 28.w, letterSpacing: 1.25),
              ),
              SizedBox(height: 16.w),
              Text(
                logic.overviewEntity.value?.experienceRank ?? "--",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.w,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        _actionLayouts(),
      ],
    );
  }

  Widget _actionLayouts() {
    return Container(
      margin:
          EdgeInsets.only(left: 48.w, right: 48.w, top: 510.w, bottom: 20.w),
      width: double.infinity,
      height: 150.w,
      decoration: BoxDecoration(
          color: ColorPalettes.instance.pure,
          borderRadius: BorderRadius.circular(16.w)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        _actionItem(
            (logic.overviewEntity.value?.isSignin == null)
                ? "--"
                : (logic.overviewEntity.value?.isSignin == true
                    ? "已签到"
                    : "未签到"),
            "每日签到"),
        _actionItem("30/次", "乐豆抽奖"),
        _actionItem(logic.overviewEntity.value?.experienceNum??"--", "我的乐豆"),
      ]),
    );
  }

  Widget _actionItem(String value, String key) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style:
              TextStyle(fontSize: 30.w, color: ColorPalettes.instance.primary),
        ),
        SizedBox(height: 18.w),
        Text(
          key,
          style: TextStyle(
              fontSize: 28.w, color: ColorPalettes.instance.secondText),
        ),
      ],
    );
  }
}

class _ExperienceOverview extends StatefulWidget {
  final Size size;
  final double level;

  const _ExperienceOverview({Key? key, required this.size, required this.level})
      : super(key: key);

  @override
  State<_ExperienceOverview> createState() => _ExperienceOverviewState();
}

class _ExperienceOverviewState extends State<_ExperienceOverview>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late double level;

  @override
  void initState() {
    super.initState();
    level = widget.level;
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        setState(() {
          level = widget.level * _animation.value;
        });
      });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: _ExperienceOverviewPaint(curLevel: level), size: widget.size);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class _ExperienceOverviewPaint extends CustomPainter {
  final Paint mPaint = Paint()
    ..isAntiAlias = true
    ..strokeWidth = 6.w;
  TextPainter textPainter =
      TextPainter(textAlign: TextAlign.left, textDirection: TextDirection.ltr);

  final levelFillSpace = 80.w;
  final levelMargin = 20.w;
  final levelCount = 19;
  final levelRadius = 8.w;
  double curLevel = 0.0;
  Path pointerPath = Path();

  _ExperienceOverviewPaint({required this.curLevel});

  @override
  void paint(Canvas canvas, Size size) {
    var radius = size.width / 2 - levelFillSpace;
    var rect = Rect.fromLTRB(levelFillSpace, levelFillSpace,
        radius * 2 + levelFillSpace, radius * 2 + levelFillSpace);
    var avgAngle = pi / (levelCount - 1);
    var curAngle = avgAngle * curLevel;
    canvas.drawArc(
        rect,
        -pi,
        pi,
        false,
        mPaint
          ..color = const Color(0xFFCCCCCC)
          ..style = PaintingStyle.stroke);

    canvas.drawArc(
        rect,
        -pi,
        curAngle,
        false,
        mPaint
          ..color = Colors.white
          ..style = PaintingStyle.stroke);

    for (var i = 0; i < levelCount; i++) {
      var angle = -pi + avgAngle * i;
      var dotX = rect.center.dx + radius * cos(angle);
      var dotY = rect.center.dy + radius * sin(angle);

      canvas.drawCircle(
          Offset(dotX, dotY),
          levelRadius,
          mPaint
            ..color = curLevel >= i ? Colors.white : const Color(0xFFCCCCCC)
            ..style = PaintingStyle.fill);

      textPainter.text = TextSpan(
          style: TextStyle(
              color: Colors.white, fontSize: 16.w, fontWeight: FontWeight.bold),
          text: "LV$i");
      textPainter.layout();

      textPainter.paint(
          canvas,
          Offset(
              dotX + cos(angle) * textPainter.width - textPainter.width / 2,
              dotY +
                  sin(angle) * textPainter.height -
                  textPainter.height / 1.5));
    }

    pointerPath.reset();
    var pointerStartX = rect.center.dx + cos(curAngle + pi / 2) * levelRadius;
    var pointerStartY = rect.center.dy + sin(curAngle + pi / 2) * levelRadius;
    var pointerMiddleX = rect.center.dx - radius * cos(curAngle) * 0.36;
    var pointerMiddleY = rect.center.dy - radius * sin(curAngle) * 0.36;
    var pointerEndX = rect.center.dx + cos(curAngle + pi / 2 * 3) * levelRadius;
    var pointerEndY = rect.center.dy + sin(curAngle + pi / 2 * 3) * levelRadius;
    pointerPath.moveTo(pointerStartX, pointerStartY);
    pointerPath.lineTo(pointerMiddleX, pointerMiddleY);
    pointerPath.lineTo(pointerEndX, pointerEndY);
    pointerPath.close();
    canvas.drawPath(pointerPath, mPaint..color = Colors.white);

    canvas.drawCircle(
        Offset(rect.center.dx, rect.center.dy),
        levelRadius * 2,
        mPaint
          ..color = Colors.white
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return curLevel != (oldDelegate as _ExperienceOverviewPaint).curLevel;
  }
}
