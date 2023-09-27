import 'dart:async';

import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/common/event/joke_like_action_event.dart';
import 'package:joke_fun_flutter/common/util/event_bus_manager.dart';
import 'package:joke_fun_flutter/common/util/user_manager.dart';
import 'package:joke_fun_flutter/common/view_state/simple_view_state_paging_logic.dart';
import 'package:joke_fun_flutter/http/retrofit_client.dart';
import 'package:joke_fun_flutter/models/base_result.dart';
import 'package:joke_fun_flutter/models/joke_like_user_entity.dart';
import 'package:joke_fun_flutter/models/login_entity.dart';

class JokeDetailLikeLogic extends SimpleViewStatePagingLogic {
  int jokesId = 0;
  late StreamSubscription jokeLikeActionSubscription;

  @override
  void onInit() {
    super.onInit();
    jokeLikeActionSubscription =
        eventBus.on<JokeLikeActionEvent>().listen((event) {
      if (event.isLikeAction == true) {
        User? user = UserManager.instance.loginEntity.value?.userInfo;
        if (user != null) {
          if (event.value == true) {
            JokeLikeUserEntity entity = JokeLikeUserEntity();
            entity.nickname = user.nickname;
            entity.userId = user.userId;
            entity.avatar = user.avatar;
            dataList.insert(0, entity);
          } else {
            var pendingRemoveEntity = dataList
                .firstWhereOrNull((element) => element.userId == user.userId);

            if (pendingRemoveEntity != null) {
              dataList.remove(pendingRemoveEntity);
            }
          }
          dataList.refresh();
        }
      }
    });
  }

  @override
  void onClose() {
    jokeLikeActionSubscription.cancel();
    super.onClose();
  }

  @override
  Future<BaseResult<List<JokeLikeUserEntity>>> requestFuture(String pageNum) {
    return RetrofitClient.instance.apiService
        .getJokeLikeList(jokesId.toString(), pageNum);
  }
}
