import 'dart:async';

import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/common/event/attention_changed_event.dart';
import 'package:joke_fun_flutter/common/util/event_bus_manager.dart';
import 'package:joke_fun_flutter/common/util/toast_util.dart';
import 'package:joke_fun_flutter/common/view_state/simple_view_state_paging_logic.dart';
import 'package:joke_fun_flutter/http/retrofit_client.dart';
import 'package:joke_fun_flutter/models/base_result.dart';
import 'package:joke_fun_flutter/models/fans_entity.dart';


class FansLogic extends SimpleViewStatePagingLogic {
  int? userId;
  bool isFans = true;

  late StreamSubscription attentionChangeSubscription;

  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic> params = Get.arguments;
    userId = int.parse(params["userId"] ?? "0");
    isFans = params["isFans"];
    attentionChangeSubscription =
        eventBus.on<AttentionChangeEvent>().listen((event) {
          var item = dataList.firstWhereOrNull(
                  (element) => element.userId.toString() == event.userId);
          if (item != null) {
            // 关注状态 0 没有关注 1 他关注我了 2 我关注他了 3 相互关注 这里简单处理
            int attentionStatus = 0;
            if(event.attention == true) {
              if(item.attention == 0) {
                attentionStatus = 2;
              } else if(item.attention == 1) {
                attentionStatus = 3;
              }
            } else {
              if(item.attention == 3) {
                attentionStatus = 1;
              } else if(item.attention == 2) {
                attentionStatus = 0;
              }
            }
            item.attention = attentionStatus;
            dataList.refresh();
          }
        });
  }

  @override
  Future<BaseResult<List<FansEntity>>> requestFuture(String pageNum) {
    if (isFans) {
      return RetrofitClient.instance.apiService
          .getUserFansList("${userId ?? ""}", pageNum);
    } else {
      return RetrofitClient.instance.apiService
          .getUserAttentionList("${userId ?? ""}", pageNum);
    }
  }

  void attentionUser(int? userId, bool noAttention) {
    sendRequest(
        RetrofitClient.instance.apiService
            .attentionUser(noAttention ? "1" : "0", "${userId ?? ""}"),
        bindViewState: false,
        needLogin: true,
        showLoadingDialog: true, successCallback: (data) {
      showToast(noAttention ? "关注成功" : "取消关注成功");
      // dataList[index].attention = noAttention;
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
