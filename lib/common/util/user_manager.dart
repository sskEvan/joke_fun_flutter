import 'dart:convert';

import 'package:get/get.dart';
import 'package:joke_fun_flutter/common/util/preference_utils.dart';

import '../../business/common/event/login_event.dart';
import '../../models/login_entity.dart';
import 'event_bus_manager.dart';

class UserManager {
  final String keyLoginEntity = "loginEntity";
  static UserManager? _instance;

  static UserManager get instance => UserManager();

  final _loginEntity = Rxn<LoginEntity>();

  final nickname = "".obs;
  final signature = "期待您的创作～".obs;
  final sex = "".obs;
  final birthday = "".obs;
  final avatar = "".obs;

  Rx<LoginEntity?> get loginEntity {
    if (_loginEntity.value == null) {
      String localJson = PreferenceUtils.instance.getString(keyLoginEntity);
      if (localJson.isNotEmpty) {
        Map<String, dynamic> jsonMap = jsonDecode(localJson);
        var localLoginEntity = LoginEntity.fromJson(jsonMap);
        _loginEntity.value = localLoginEntity;
        nickname.value = localLoginEntity.userInfo?.nickname ?? "";
        signature.value = localLoginEntity.userInfo?.signature ?? "期待您的创作～";
        sex.value = localLoginEntity.userInfo?.sex ?? "";
        birthday.value = localLoginEntity.userInfo?.birthday ?? "";
        avatar.value = localLoginEntity.userInfo?.avatar ?? "";
      }
    }
    return _loginEntity;
  }

  UserManager._internal();

  factory UserManager() {
    _instance ??= UserManager._internal();
    return _instance!;
  }

  void updateLoginEntity(LoginEntity? loginEntity) {
    _loginEntity.value = loginEntity;
    nickname.value = loginEntity?.userInfo?.nickname ?? "";
    signature.value = loginEntity?.userInfo?.signature ?? "期待您的创作～";
    sex.value = loginEntity?.userInfo?.sex ?? "";
    birthday.value = loginEntity?.userInfo?.birthday ?? "";
    avatar.value = loginEntity?.userInfo?.avatar ?? "";
    String json = loginEntity?.toString() ?? "";
    PreferenceUtils.instance.putString(keyLoginEntity, json);
  }

  bool isLogin() => loginEntity.value != null;

  void updateNickname(String value) {
    nickname.value = value;
    if (_loginEntity.value != null) {
      _loginEntity.value?.userInfo?.nickname = value;
      updateLoginEntity(_loginEntity.value!);
    }
  }

  void updateSignature(String value) {
    signature.value = value;
    if (_loginEntity.value != null) {
      _loginEntity.value?.userInfo?.signature = value;
      updateLoginEntity(_loginEntity.value!);
    }
  }

  void updateSex(String value) {
    sex.value = value;
    if (_loginEntity.value != null) {
      _loginEntity.value?.userInfo?.sex = value;
      updateLoginEntity(_loginEntity.value!);
    }
  }

  void updateBirthday(String value) {
    birthday.value = value;
    if (_loginEntity.value != null) {
      _loginEntity.value?.userInfo?.birthday = value;
      updateLoginEntity(_loginEntity.value!);
    }
  }

  void updateAvatar(String value) {
    avatar.value = value;
    if (_loginEntity.value != null) {
      _loginEntity.value?.userInfo?.avatar = value;
      updateLoginEntity(_loginEntity.value!);
    }
  }

  bool isSelf(int? userId) => _loginEntity.value?.userInfo?.userId == userId;

  void logout() {
    updateLoginEntity(null);
    eventBus.fire(LoginEvent());
  }

  // void updateUser(User? user) {
  //   if(user != null && _loginEntity.value != null) {
  //     LoginEntity newLoginEntity = LoginEntity();
  //     newLoginEntity.userInfo = user;
  //     newLoginEntity.token = _loginEntity.value?.token;
  //     newLoginEntity.type = _loginEntity.value?.type;
  //     updateLoginEntity(newLoginEntity, assignment: false);
  //   }
  // }

}