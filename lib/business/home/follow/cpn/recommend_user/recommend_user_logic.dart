import 'dart:async';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:joke_fun_flutter/business/common/event/attention_changed_event.dart';
import 'package:joke_fun_flutter/common/util/event_bus_manager.dart';
import 'package:joke_fun_flutter/common/util/toast_util.dart';
import 'package:joke_fun_flutter/common/view_state/view_state_logic.dart';
import 'package:joke_fun_flutter/http/retrofit_client.dart';
import 'package:joke_fun_flutter/models/recommend_attention_entity.dart';

class RecommendUserLogic extends ViewStateLogic {
  RxList<RecommendAttentionEntity> dataList = <RecommendAttentionEntity>[].obs;

  late StreamSubscription attentionChangeSubscription;

  @override
  void onInit() {
    super.onInit();
    attentionChangeSubscription =
        eventBus.on<AttentionChangeEvent>().listen((event) {
      var item = dataList.firstWhereOrNull(
          (element) => element.userId.toString() == event.userId);
      if (item != null) {
        item.isAttention = event.attention;
        dataList.refresh();
      }
    });
  }

  @override
  void loadData() {
    sendRequest(RetrofitClient.instance.apiService.getAttentionRecommendList(),
        successCallback: (data) {
      dataList.clear();
      dataList.addAll(data!);
    });
  }

  void attentionUser(int? userId, bool noAttention, int index) {
    sendRequest(
        RetrofitClient.instance.apiService
            .attentionUser(noAttention ? "1" : "0", "${userId ?? ""}"),
        bindViewState: false,
        showLoadingDialog: true,
        needLogin: true, successCallback: (data) {
      showToast(noAttention ? "关注成功" : "取消关注成功");
      // dataList[index].isAttention = noAttention;
      // dataList.refresh();
      eventBus.fire(AttentionChangeEvent(
          userId: userId?.toString(), attention: noAttention));
    });
  }

  @override
  void onClose() {
    attentionChangeSubscription.cancel();
    super.onClose();
  }
}
