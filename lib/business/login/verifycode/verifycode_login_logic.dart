import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/common/event/login_event.dart';
import 'package:joke_fun_flutter/common/util/event_bus_manager.dart';
import 'package:joke_fun_flutter/common/util/user_manager.dart';
import 'package:joke_fun_flutter/common/view_state/view_state_logic.dart';
import 'package:joke_fun_flutter/http/retrofit_client.dart';
import 'package:joke_fun_flutter/models/login_entity.dart';

import '../../../common/util/string_util.dart';

class VerifyCodeLoginLogic extends ViewStateLogic {
  TextEditingController textEditingController = TextEditingController();
  RxString phone = "".obs;
  RxString verifyCode = "".obs;
  RxBool isPhoneNumValid = false.obs;
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
        emptyAsSuccess: true,
        successCallback: (value) => getVerifyCodeSuccess.value = true);
  }

  /// 验证码登录
  void loginByCode() {
    sendRequest(
        RetrofitClient.instance.apiService.loginByCode(verifyCode.value, phone.value),
        showLoadingDialog: true,
        successCallback: (value) {
          LoginEntity loginEntity = value!;
          UserManager.instance.updateLoginEntity(loginEntity);
          eventBus.fire(LoginEvent());
          Get.back();
        });
  }


  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }
}
