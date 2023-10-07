import 'package:joke_fun_flutter/business/common/logic/joke_list_logic.dart';
import 'package:joke_fun_flutter/business/common/logic/joke_list_video_play_helper_mixin.dart';
import 'package:joke_fun_flutter/http/retrofit_client.dart';
import 'package:joke_fun_flutter/models/base_result.dart';
import 'package:joke_fun_flutter/models/joke_detail_entity.dart';
import 'package:joke_fun_flutter/router/routers.dart';

class RecommendLogic extends JokeListLogic with JokeListVideoPlayHelperMixin {
  @override
  void onInit() {
    super.onInit();
    monitorVideoActive();
  }

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  @override
  Future<BaseResult<List<JokeDetailEntity>>> requestFuture(String pageNum) {
    return RetrofitClient.instance.apiService.getRecommendList(pageNum);
  }

  @override
  bool judgeVideoActive() {
    return AppRoutes.curPage.value == AppRoutes.indexPage &&
        indexPageIndex == 0 &&
        homePageIndex == 1;
  }
}
