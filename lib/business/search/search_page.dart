import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/search/history/cpn_search_history.dart';
import 'package:joke_fun_flutter/business/search/hot/cpn_search_hot_key.dart';
import 'package:joke_fun_flutter/business/search/result/cpn_search_result.dart';
import 'package:joke_fun_flutter/common/cpn/app_bar.dart';
import 'package:joke_fun_flutter/common/ext/asset_ext.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';

import 'search_logic.dart';

/// 搜索页面
class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  final logic = Get.find<SearchLogic>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (logic.searchMode.value) {
          logic.updateKey("");
          return false;
        } else {
          Get.back();
          return true;
        }
      },
      child: Scaffold(
          appBar: commonAppBar(
              bottom: PreferredSize(
                  preferredSize: Size(double.infinity, 100.w),
                  child: _searchBar())),
          body: Obx(() {
            return logic.searchMode.value == false
                ? _keys()
                : CpnSearchResult();
          })),
    );
  }

  Widget _keys() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          CpnSearchHistory(),
          SizedBox(height: 32.w),
          CpnSearchHotKey()
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      height: 100.w,
      alignment: Alignment.center,
      child: Row(children: [
        GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: Get.back,
            child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 32.w, right: 12.w),
                child: Image.asset("ic_back".webp,
                    width: 40.w,
                    height: 40.w,
                    color: ColorPalettes.instance.firstIcon))),
        Expanded(
          child: Container(
            height: 72.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: ColorPalettes.instance.inputBackground,
                borderRadius: BorderRadius.circular(36.w)),
            child: Row(
              children: [
                SizedBox(width: 24.w),
                Hero(
                  tag: "ic_search",
                  child: Image.asset("ic_search".webp,
                      width: 32.w,
                      height: 32.w,
                      color: ColorPalettes.instance.firstIcon),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: TextField(
                    controller: logic.textEditingController,
                    style: TextStyle(
                        fontSize: 28.w,
                        color: ColorPalettes.instance.firstText,
                        letterSpacing: 1.1),
                    maxLines: 1,
                    cursorColor: ColorPalettes.instance.primary,
                    decoration: InputDecoration(
                      hintText: "搜索您感兴趣的帖子",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          fontSize: 28.w,
                          color: ColorPalettes.instance.secondText),
                    ),
                    onChanged: (value) {
                      logic.updateKey(value, needDelay: true);
                    },
                  ),
                ),
                Obx(() {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: (logic.keyword.value.isNotEmpty)
                          ? Image.asset(
                              "ic_clear_input".webp,
                              width: 32.w,
                              height: 32.w,
                              color: ColorPalettes.instance.thirdIcon,
                            )
                          : SizedBox(width: 32.w),
                    ),
                    onTap: () {
                      logic.updateKey("");
                    },
                  );
                })
              ],
            ),
          ),
        ),
        GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (logic.searchMode.value) {
                logic.updateKey("");
              } else {
                Get.back();
              }
            },
            child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 12.w, right: 24.w),
                child: Text(
                  "取消",
                  style: TextStyle(
                      color: ColorPalettes.instance.secondText, fontSize: 28.w),
                ))),
      ]),
    );
  }
}
