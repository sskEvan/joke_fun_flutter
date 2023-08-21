import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/common/cpn/app_bar.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_image.dart';
import 'package:joke_fun_flutter/common/ext/asset_ext.dart';
import 'package:joke_fun_flutter/common/util/media_util.dart';
import 'package:joke_fun_flutter/common/util/user_manager.dart';
import 'package:joke_fun_flutter/models/login_entity.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';

import 'edit_center_logic.dart';

class EditCenterPage extends StatelessWidget {
  EditCenterPage({Key? key}) : super(key: key);

  final logic = Get.find<EditCenterLogic>();

  @override
  Widget build(BuildContext context) {
    User? user = UserManager().loginEntity.value?.userInfo;
    return Scaffold(
        appBar: commonAppBar(bottom: commonTitleBar(title: "用户信息")),
        body: Center(
            child: Column(
          children: [
            SizedBox(
              height: 88.w,
            ),
            _avatar(),
            SizedBox(
              height: 88.w,
            ),
            Divider(
              thickness: 16.w,
              color: ColorPalettes.instance.divider,
            ),
            _commonActionItem("昵称", user?.nickname),
            _commonActionItem("签名", user?.signature),
            _commonActionItem("性别", user?.sex),
            _commonActionItem("生日", user?.birthday),
          ],
        )));
  }

  Widget _avatar() {
    User? user = UserManager().loginEntity.value?.userInfo;
    return Hero(
      tag: "user_avatar",
      child: Container(
        width: 180.w,
        height: 180.w,
        child: Stack(
          children: [
            cpnCircleNetworkImage(
                url: decodeMediaUrl(user?.avatar),
                width: 180.w,
                height: 180.w,
                defaultPlaceHolderAssetName: "ic_default_avatar",
                defaultErrorAssetName: "ic_default_avatar"),
            Align(
                alignment: Alignment.bottomRight,
                child: Container(
                    margin: EdgeInsets.only(right: 3.w, bottom: 3.w),
                    alignment: Alignment.center,
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                        color: ColorPalettes.instance.primary,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.fromBorderSide(BorderSide(
                            color: ColorPalettes.instance.divider,
                            width: 2.w))),
                    child: Image.asset(
                      "ic_take_pic".webp,
                      width: 28.w,
                      height: 28.w,
                      color: Colors.white,
                    )))
          ],
        ),
      ),
    );
  }

  Widget _commonActionItem(String key, String? value) {
    return Container(
      padding:
          EdgeInsets.only(left: 32.w, top: 32.w, bottom: 32.w, right: 32.w),
      child: Row(
        children: [
          Text(
            key,
            style: TextStyle(
                fontSize: 32.w, color: ColorPalettes.instance.secondText),
          ),
          SizedBox(width: 32.w),
          Expanded(
            child: Text(
              value ?? "",
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontSize: 32.w, color: ColorPalettes.instance.firstText),
            ),
          ),
          SizedBox(width: 32.w),
          Image.asset("ic_arrow_right".webp,
              width: 32.w,
              height: 32.w,
              color: ColorPalettes.instance.secondIcon),
        ],
      ),
    );
  }
}
