import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/common/util/user_manager.dart';
import 'package:joke_fun_flutter/common/view_state/view_state_controller.dart';
import 'package:joke_fun_flutter/http/retrofit_client.dart';
import 'package:joke_fun_flutter/models/login_entity.dart';

import '../../../common/util/string_util.dart';

class VerifyCodeLoginLogic extends ViewStateController {
  TextEditingController textEditingController = TextEditingController();
  RxString phone = "".obs;
  RxString verifyCode = "".obs;
  RxBool isPhoneNumValid = true.obs;
  RxBool getVerifyCodeSuccess = false.obs;
  RxBool verifyCodeValid = false.obs;

  void updatePhone(String value) {
    phone.value = value;
    isPhoneNumValid.value = isPhoneNum(value);
    textEditingController.value = TextEditingValue(
        text: value,
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream, offset: value.length)));
  }

  void inputVerifyCode(String verifyCode) {
    this.verifyCode.value = verifyCode;
    verifyCodeValid.value = verifyCode.length == 6;
  }

  /// 获取验证码
  void getVerifyCode() {
    sendRequest(
        RetrofitClient.instance.apiService.getLoginVerifyCode(phone.value),
        showLoadingDialog: true,
        judgeEmptyBlock: (value) => false,
        successBlock: (value) => getVerifyCodeSuccess.value = true);
  }

  /// 验证码登陆
  void loginByCode() {
    sendRequest(
        RetrofitClient.instance.apiService.loginByCode(verifyCode.value, phone.value),
        showLoadingDialog: true,
        successBlock: (value) {
          LoginEntity loginEntity = value!;
          UserManager.instance.saveLoginEntity(loginEntity);
          Get.back();
        });
  }


  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }
}
