import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/home/follow/cpn/recommend_user/recommend_user_logic.dart';
import 'package:joke_fun_flutter/common/view_state/view_state_paging_controller.dart';
import 'package:joke_fun_flutter/http/retrofit_client.dart';
import 'package:joke_fun_flutter/models/joke_detail_entity.dart';
import 'package:pull_to_refresh/src/smart_refresher.dart';



class FollowLogic extends ViewStatePagingController {
  RxList<JokeDetailEntity> dataList = <JokeDetailEntity>[].obs;

  RecommendUserLogic recommendUserController =
      GetInstance().find<RecommendUserLogic>();

  @override
  void loadData() {
    // recommendUserController.loadData();
    sendRequest(
        RetrofitClient.instance.apiService
            .getAttentionRecommendList(pageSize.toString()),
        successBlock: (data) {
      dataList.clear();
      dataList.addAll(data!);
    });
  }

  @override
  void refreshPaging(RefreshController refreshController) async {
    sendRefreshPagingRequest(
        RetrofitClient.instance.apiService.getAttentionRecommendList("1"),
        refreshController: refreshController, successBlock: (data) {
      dataList.clear();
      dataList.addAll(data);
    });
  }

  @override
  void loadMorePaging(RefreshController refreshController) async {
    sendRequest(
        RetrofitClient.instance.apiService
            .getAttentionRecommendList(pageSize.toString()),
        successBlock: (data) {
      dataList.clear();
      dataList.addAll(data!);
    });
  }
}
