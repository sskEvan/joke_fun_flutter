import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/search/history/search_history_logic.dart';
import 'package:joke_fun_flutter/business/search/search_logic.dart';
import 'package:joke_fun_flutter/common/ext/asset_ext.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';

/// 搜索历史关键词组件
class CpnSearchHistory extends StatelessWidget {
  CpnSearchHistory({Key? key}) : super(key: key);
  final logic = Get.find<SearchHistoryLogic>();
  final SearchLogic searchLogic = Get.find<SearchLogic>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<String> historyKeys = logic.historyKeys;
      if (historyKeys.isNotEmpty) {
        return Container(
            margin: EdgeInsets.symmetric(horizontal: 32.w),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _title(),
                Wrap(
                  spacing: 16.w,
                  runSpacing: 16.w,
                  children:
                      historyKeys.map((element) => keyItem(element)).toList(),
                ),
              ],
            ));
      } else {
        return const SizedBox.shrink();
      }
    });
  }

  Widget _title() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 32.w),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "历史搜索",
              style: TextStyle(
                  fontSize: 28.w,
                  color: ColorPalettes.instance.firstText,
                  fontWeight: FontWeight.bold),
            ),
          ),
          logic.editMode.value
              ? Row(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        logic.removeAll();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.w, horizontal: 24.w),
                        child: Text(
                          "全部删除",
                          style: TextStyle(
                              fontSize: 24.w,
                              color: ColorPalettes.instance.secondText),
                        ),
                      ),
                    ),
                    Container(
                      width: 2.w,
                      height: 32.w,
                      color: ColorPalettes.instance.divider,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        logic.editMode.value = false;
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 24.w, top: 16.w, bottom: 16.w),
                        child: Text(
                          "完成",
                          style: TextStyle(
                              fontSize: 24.w,
                              color: ColorPalettes.instance.primary),
                        ),
                      ),
                    )
                  ],
                )
              : GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    logic.editMode.value = true;
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.w, top: 16.w, bottom: 16.w),
                    child: Image.asset(
                      "ic_delete".webp,
                      width: 32.w,
                      height: 32.w,
                      color: ColorPalettes.instance.secondIcon,
                    ),
                  ),
                )
        ],
      ),
    );
  }

  Widget keyItem(String key) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if(logic.editMode.value) {
          logic.removeKey(key);
        } else {
          searchLogic.updateKey(key);
        }
      },
      child: Container(
        height: 64.w,
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        decoration: BoxDecoration(
          border: Border.fromBorderSide(
              BorderSide(color: ColorPalettes.instance.divider, width: 2.w)),
          borderRadius: BorderRadius.circular((32.w)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              key,
              style: TextStyle(
                  fontSize: 28.w, color: ColorPalettes.instance.secondText),
            ),
            logic.editMode.value
                ? Padding(
                    padding: EdgeInsets.only(left: 12.w),
                    child: Image.asset(
                      "ic_delete_circle_shape".webp,
                      width: 32.w,
                      height: 32.w,
                      color: ColorPalettes.instance.thirdIcon,
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
