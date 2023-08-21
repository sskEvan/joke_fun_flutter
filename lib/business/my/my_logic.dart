import 'package:get/get.dart';
import 'package:joke_fun_flutter/common/view_state/view_state_controller.dart';
import 'package:joke_fun_flutter/models/user_info_entity.dart';

import '../../common/util/user_manager.dart';
import '../../http/retrofit_client.dart';

class MyLogic extends ViewStateController {
  final userInfoEntity = Rxn<UserInfoEntity?>();

  @override
  void onInit() {
    super.onInit();
    ever(UserManager.instance.loginEntity, (callback) {
      loadData();
    });
  }

  @override
  void loadData() {
    if (UserManager.instance.isLogin()) {
      sendRequest(RetrofitClient.instance.apiService.getUserInfo(),
          successBlock: (value) {
        userInfoEntity.value = value;
      });
    }
  }
}
