import 'package:joke_fun_flutter/common/util/log_util.dart';
import 'package:joke_fun_flutter/common/view_state/view_state.dart';
import 'package:joke_fun_flutter/common/view_state/view_state_controller.dart';


class RecommendUserLogic extends ViewStateController {

  List<String> dataList = <String>[];

  @override
  void loadData() {
    LogD("RecommendUserLogic loadData");
    viewState.value = ViewStateLoading();
    Future.delayed(const Duration(seconds: 2), () {
      return ["1", "2", "3", "4", "5", "6"];
    }).then((value) {
      dataList = value;
      viewState.value = ViewStateSuccess(value);
    });
  }

}
