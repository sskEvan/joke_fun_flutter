import 'package:joke_fun_flutter/business/common/logic/joke_list_logic.dart';
import 'package:joke_fun_flutter/http/retrofit_client.dart';
import 'package:joke_fun_flutter/models/base_result.dart';
import 'package:joke_fun_flutter/models/joke_detail_entity.dart';

class FunPicLogic extends JokeListLogic {
  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  @override
  Future<BaseResult<List<JokeDetailEntity>>> requestFuture(String pageNum) {
    return RetrofitClient.instance.apiService.getPicList(pageNum);
  }
}
