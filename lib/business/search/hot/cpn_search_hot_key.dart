import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/search/search_logic.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';

import 'search_hot_key_logic.dart';

/// 热门搜索关键词组件
class CpnSearchHotKey extends CpnViewState<SearchHotKeyLogic> {
   CpnSearchHotKey({Key? key}) : super(key: key);

  final SearchLogic searchLogic = Get.find<SearchLogic>();

  @override
  bool autoLoadData() => true;

  @override
  Widget buildBody(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32.w),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 32.w),
            child: Text(
              "热门搜索",
              style: TextStyle(
                  fontSize: 28.w,
                  color: ColorPalettes.instance.firstText,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Wrap(
            spacing: 16.w,
            runSpacing: 16.w,
            children: logic.hotKeys.map((element) => keyItem(element)).toList(),
          ),
        ],
      ),
    );
  }

  @override
  bool useScaffold() => false;

  Widget keyItem(String key) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        searchLogic.updateKey(key);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 64.w,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            decoration: BoxDecoration(
              border: Border.fromBorderSide(
                  BorderSide(color: ColorPalettes.instance.divider, width: 2.w)),
              borderRadius: BorderRadius.circular((32.w)),
            ),
            child: Text(
              key,
              style:
                  TextStyle(fontSize: 28.w, color: ColorPalettes.instance.secondText),
            ),
          ),
        ],
      ),
    );
  }
}
