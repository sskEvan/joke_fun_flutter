import 'dart:convert';

import 'package:get/get.dart';
import 'package:joke_fun_flutter/common/util/preference_utils.dart';

import '../../models/login_entity.dart';

class UserManager {
  final String keyLoginEntity = "loginEntity";
  static UserManager? _instance;
  static UserManager get instance => UserManager();

   final _loginEntity = Rxn<LoginEntity>();

  Rx<LoginEntity?> get loginEntity  {
    if(_loginEntity.value == null) {
      String localJson = PreferenceUtils.instance.getString(keyLoginEntity);
      if(localJson.isNotEmpty) {
        Map<String, dynamic> jsonMap = jsonDecode(localJson);
        var localLoginEntity = LoginEntity.fromJson(jsonMap);
        _loginEntity.value = localLoginEntity;
      }
    }
    return _loginEntity;
  }

  UserManager._internal();

  factory UserManager() {
    _instance ??= UserManager._internal();
    return _instance!;
  }

  void saveLoginEntity(LoginEntity loginEntity) {
    _loginEntity.value = loginEntity;
    String json = loginEntity.toString();
    PreferenceUtils.instance.putString(keyLoginEntity, json);
  }

  bool isLogin() => loginEntity.value != null;

}