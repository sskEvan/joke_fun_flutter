import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoOverScrollBehavior extends ScrollBehavior{

  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return GlowingOverscrollIndicator(
      child: child,
      //不显示头部水波纹
      showLeading: false,
      //不显示尾部水波纹
      showTrailing: false,
      axisDirection: axisDirection,
      color: Colors.transparent,
    );
  }

}