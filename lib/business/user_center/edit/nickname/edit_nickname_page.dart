import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joke_fun_flutter/common/cpn/app_bar.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state.dart';
import 'package:joke_fun_flutter/common/ext/asset_ext.dart';
import 'package:joke_fun_flutter/common/util/keyboard_util.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';

import 'edit_nickname_logic.dart';

/// 修改昵称页面
class EditNicknamePage extends CpnViewState<EditNicknameLogic> {
  const EditNicknamePage({Key? key}) : super(key: key, bindViewState: false);

  @override
  AppBar? buildAppBar() => commonAppBar(bottom: commonTitleBar(title: "昵称"));

  @override
  Widget buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 60.w, left: 32.w, right: 32.w),
      child: Column(
        children: [_inputTextField(), SizedBox(height: 48.w), _saveButton()],
      ),
    );
  }

  Widget _inputTextField() {
    return Container(
      height: 112.w,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 48.w, right: 24.w),
      decoration: BoxDecoration(
          color: ColorPalettes.instance.inputBackground,
          borderRadius: BorderRadius.circular(56.w)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: logic.textEditingController,
              autofocus: true,
              style: TextStyle(
                  fontSize: 36.w,
                  color: ColorPalettes.instance.firstText,
                  letterSpacing: 1.1),
              maxLines: 1,
              cursorColor: ColorPalettes.instance.primary,
              decoration: InputDecoration(
                hintText: "请输入昵称（最长10个字）",
                border: InputBorder.none,
                hintStyle: TextStyle(
                    fontSize: 32.w, color: ColorPalettes.instance.secondText),
              ),
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(10) //限制长度
              ],
              onChanged: (value) {
                logic.updateInput(value);
              },
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: (logic.inputValue.value.isNotEmpty)
                  ? Image.asset(
                      "ic_clear_input".webp,
                      width: 40.w,
                      height: 40.w,
                      color: ColorPalettes.instance.thirdIcon,
                    )
                  : SizedBox(width: 40.w),
            ),
            onTap: () {
              logic.updateInput("");
            },
          )
        ],
      ),
    );
  }

  Widget _saveButton() {
    return Container(
      width: double.infinity,
      height: 100.w,
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
