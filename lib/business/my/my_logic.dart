import 'dart:async';

import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/common/event/attention_changed_event.dart';
import 'package:joke_fun_flutter/business/common/event/login_event.dart';
import 'package:joke_fun_flutter/common/util/event_bus_manager.dart';
import 'package:joke_fun_flutter/common/view_state/view_state_logic.dart';
import 'package:joke_fun_flutter/models/user_info_entity.dart';

import '../../common/util/user_manager.dart';
import '../../http/retrofit_client.dart';

class MyLogic extends ViewStateLogic {
  final userInfoEntity = Rxn<UserInfoEntity?>();
  late StreamSubscription loginSubscription;
  late StreamSubscription attentionChangeSubscription;

  @override
  void onInit() {
    super.onInit();
    // ever(UserManager.instance.loginEntity, (callback) {
    //   loadData();
    // });
    loginSubscription = eventBus.on<LoginEvent>().listen((event) {
      loadData();
    });
    attentionChangeSubscription =
        eventBus.on<AttentionChangeEvent>().listen((event) {
      loadData();
    });
  }

  @override
  void loadData() {
    if (UserManager.instance.isLogin()) {
      sendRequest(RetrofitClient.instance.apiService.getUserInfo(),
          successCallback: (value) {
        userInfoEntity.value = value;
      });
    } else {
      userInfoEntity.value = null;
    }
  }

  @override
  void onClose() {
    loginSubscription.cancel();
    attentionChangeSubscription.cancel();
    super.onClose();
  }
}
