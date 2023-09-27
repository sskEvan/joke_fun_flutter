import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:joke_fun_flutter/common/view_state/view_state_paging_logic.dart';
import 'package:joke_fun_flutter/models/base_result.dart';

abstract class SimpleViewStatePagingLogic<E> extends ViewStatePagingLogic {
  RxList<E> dataList = <E>[].obs;

  @override
  void loadData() {
    sendRequest(requestFuture("1"),
        judgeEmptyCallback: (result) => judgeEmpty(result!),
        successCallback: (data) {
      List<E> list = convertResult(data!);
      if(list.length < pageSize) {
        refreshController?.loadNoData();
      }
      dataList.clear();
      dataList.addAll(list);
    });
  }

  @override
  void loadMorePaging() {
    sendLoadMorePagingRequest(requestFuture("${curPage + 1}"),
        judgeNoMoreDataBlock: (result) => judgeNoMoreData(result!),
        successBlock: (data) {
          dataList.addAll(convertResult(data));
        });
  }

  @override
  void refreshPaging() {
    sendRefreshPagingRequest(requestFuture("1"),
         successBlock: (data) {
          dataList.clear();
          dataList.addAll(convertResult(data));
        });
  }

  Future<BaseResult<dynamic>> requestFuture(String pageNum);

  bool judgeEmpty(BaseResult<dynamic> result) => result.isEmpty();

  bool judgeNoMoreData(BaseResult<dynamic> result) {
    return result.noMoreData(pageSize);
  }

  List<E> convertResult(dynamic originResult) {
    return originResult as List<E>;
  }

}
