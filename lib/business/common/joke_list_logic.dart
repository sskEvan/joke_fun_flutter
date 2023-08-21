import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:joke_fun_flutter/models/base_result.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/view_state/view_state_paging_controller.dart';
import '../../models/joke_detail_entity.dart';

abstract class JokeListLogic extends ViewStatePagingController {
  RxList<JokeDetailEntity> dataList = <JokeDetailEntity>[].obs;

  @override
  void loadData() async {
    sendRequest(requestFuture("1"), successBlock: (data) {
      dataList.clear();
      dataList.addAll(data!);
    });
  }

  @override
  void refreshPaging(RefreshController refreshController) async {
    sendRefreshPagingRequest(requestFuture("1"),
        refreshController: refreshController, successBlock: (data) {
      dataList.clear();
      dataList.addAll(data);
    });
  }

  @override
  void loadMorePaging(RefreshController refreshController) async {
    sendLoadMorePagingRequest(requestFuture("${pageSize + 1}"),
        refreshController: refreshController, successBlock: (data) {
      dataList.addAll(data);
    });
  }

  Future<BaseResult<List<JokeDetailEntity>>> requestFuture(String pageNum);
}
