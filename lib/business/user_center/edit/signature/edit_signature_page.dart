import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joke_fun_flutter/common/cpn/app_bar.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state.dart';
import 'package:joke_fun_flutter/common/util/keyboard_util.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';

import 'edit_signature_logic.dart';

/// 修改签名页面
class EditSignaturePage extends CpnViewState<EditSignatureLogic> {
  const EditSignaturePage({Key? key}) : super(key: key, bindViewState: false);

  @override
  AppBar? buildAppBar() => commonAppBar(bottom: commonTitleBar(title: "签名"));

  @override
  Widget buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 60.w, left: 32.w, right: 32.w),
      child: Column(
        children: [
          _inputTextField(),
          SizedBox(height: 48.w),
          _saveButton()
        ],
      ),
    );
  }

  Widget _inputTextField() {
    return Container(
      height: 280.w,
      alignment: Alignment.topLeft,
      padding:
          EdgeInsets.only(left: 32.w, right: 32.w, top: 8.w, bottom: 8.w),
      decoration: BoxDecoration(
          color: ColorPalettes.instance.inputBackground,
          borderRadius: BorderRadius.circular(24.w)),
      child: TextField(
        controller: logic.textEditingController,
        autofocus: true,
        maxLines: 5,
        style: TextStyle(
            fontSize: 32.w,
            color: ColorPalettes.instance.firstText,
            letterSpacing: 1.1),
        cursorColor: ColorPalettes.instance.primary,
        decoration: InputDecoration(
          hintText: "请输入签名(最长20个字)",
          border: InputBorder.none,
          hintStyle: TextStyle(
              fontSize: 32.w, color: ColorPalettes.instance.secondText),
        ),
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(20) //限制长度
        ],
        onChanged: (value) {
          logic.updateInput(value);
        },
      ),
    );
  }

  Widget _saveButton() {
    return Container(
      width: double.infinity,
      height: 110.w,
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 48.w, right: 24.w),
      decoration: BoxDecoration(
          color: logic.isAllowSave.value
              ? ColorPalettes.instance.primary
              : ColorPalettes.instance.secondary,
          borderRadius: BorderRadius.circular(56.w)),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: Text("保存",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.w,
                  fontWeight: FontWeight.w600)),
        ),
        onTap: () {
          if (logic.isAllowSave.value) {
            hideKeyboard();
            logic.updateUserInfo();
          }
        },
      ),
    );
  }
}
