import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../theme/color_palettes.dart';
import 'search_logic.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  final logic = Get.find<SearchLogic>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
        color: ColorPalettes.instance.background,
        child: Center(
            child: Text("搜索",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: ColorPalettes.instance.firstText,
                    fontSize: 32.w)))));
  }
}
