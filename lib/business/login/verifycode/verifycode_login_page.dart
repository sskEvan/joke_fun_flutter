import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joke_fun_flutter/business/login/verifycode/verifycode_login_logic.dart';
import 'package:joke_fun_flutter/common/cpn/app_bar.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_verify_code_input.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state.dart';
import 'package:joke_fun_flutter/common/ext/asset_ext.dart';
import 'package:joke_fun_flutter/common/util/keyboard_util.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';

/// 验证吗登录页面
class VerifyCodeLoginPage extends CpnViewState<VerifyCodeLoginLogic> {
  const VerifyCodeLoginPage({Key? key}) : super(key: key, bindViewState: false);

  @override
  AppBar? buildAppBar() => commonAppBar(bottom: commonTitleBar());

  @override
  Widget buildBody(context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 64.w),
      child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: !logic.getVerifyCodeSuccess.value
              ? _inputPhoneNum()
              : _inputVerifyCode()),
    );
  }

  Widget _inputPhoneNum() {
    return Column(
      key: const ValueKey("_inputPhoneNum"),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 64.w),
        Text("请输入手机号",
            style: TextStyle(
                color: ColorPalettes.instance.firstText,
                fontSize: 48.w,
                fontWeight: FontWeight.w600)),
        SizedBox(height: 24.w),
        Text("未注册的手机号验证后将自动注册",
            style: TextStyle(
                color: ColorPalettes.instance.thirdText, fontSize: 24.w)),
        SizedBox(height: 80.w),
        _phoneTextField(),
        SizedBox(height: 48.w),
        _verifyCodeButton()
      ],
    );
  }

  Widget _phoneTextField() {
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
              keyboardType: TextInputType.number,
              autofocus: true,
              style: TextStyle(
                  fontSize: 40.w,
                  color: ColorPalettes.instance.firstText,
                  letterSpacing: 1.1),
              maxLines: 1,
              cursorColor: ColorPalettes.instance.primary,
              decoration: InputDecoration(
                hintText: "请输入手机号",
                border: InputBorder.none,
                hintStyle: TextStyle(
                    fontSize: 36.w, color: ColorPalettes.instance.secondText),
              ),
              onChanged: (value) {
                logic.updatePhone(value);
              },
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: (logic.phone.value.isNotEmpty)
                  ? Image.asset(
                      "ic_clear_input".webp,
                      width: 40.w,
                      height: 40.w,
                      color: ColorPalettes.instance.thirdIcon,
                    )
                  : SizedBox(width: 40.w),
            ),
            onTap: () {
              logic.updatePhone("");
            },
          )
        ],
      ),
    );
  }

  Widget _verifyCodeButton() {
    return Container(
      width: double.infinity,
      height: 112.w,
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 48.w, right: 24.w),
      decoration: BoxDecoration(
          color: logic.isPhoneNumValid.value
              ? ColorPalettes.instance.primary
              : ColorPalettes.instance.secondary,
          borderRadius: BorderRadius.circular(56.w)),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: Text("获取验证码",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.w,
                  fontWeight: FontWeight.w600)),
        ),
        onTap: () {
          if (logic.isPhoneNumValid.value) {
            hideKeyboard();
            logic.getVerifyCode();
          }
        },
      ),
    );
  }

  Widget _inputVerifyCode() {
    return Column(
      key: const ValueKey("_inputVerifyCode"),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 64.w),
        Text("请输入验证码",
            style: TextStyle(
                color: ColorPalettes.instance.firstText,
                fontSize: 48.w,
                fontWeight: FontWeight.w600)),
        SizedBox(height: 24.w),
        Text("请关注微信公众号【Cretin的开发之路】，在输入框输入【#13】获取验证码。",
            style: TextStyle(
                color: ColorPalettes.instance.thirdText, fontSize: 24.w)),
        SizedBox(height: 80.w),
        CpnVerifyCodeInput(
          height: 88.w,
          onSubmit: (value) {
            logic.inputVerifyCode(value);
          },
        ),
        SizedBox(height: 48.w),
        _loginButton(),
        SizedBox(height: 32.w),
      ],
    );
  }

  Widget refreshVerifyCodeButton() {
    return Container(
        height: 40.w,
        width: 140.w,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 32.w),
        decoration: BoxDecoration(
            color: ColorPalettes.instance.inputBackground,
            borderRadius: BorderRadius.circular(20.w)),
        child: Text("重新获取",
            style: TextStyle(
                color: ColorPalettes.instance.secondText, fontSize: 24.w)));
  }

  Widget _loginButton() {
    return Container(
      width: double.infinity,
      height: 112.w,
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 48.w, right: 24.w),
      decoration: BoxDecoration(
          color: logic.verifyCodeValid.value
              ? ColorPalettes.instance.primary
              : ColorPalettes.instance.secondary,
          borderRadius: BorderRadius.circular(56.w)),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: Text("登录",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.w,
                  fontWeight: FontWeight.w600)),
        ),
        onTap: () {
          logic.loginByCode();
        },
      ),
    );
  }
}
