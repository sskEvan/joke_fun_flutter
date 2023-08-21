import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../theme/color_palettes.dart';

class PushPage extends StatelessWidget {
  const PushPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
        color: ColorPalettes.instance.background,
        child: Center(
            child: Text("发布",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: ColorPalettes.instance.firstText,
                    fontSize: 32.w)))));
  }
}
