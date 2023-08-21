import 'package:joke_fun_flutter/models/base_result.dart';

import '../../../http/retrofit_client.dart';
import '../../../models/joke_detail_entity.dart';
import '../../common/joke_list_logic.dart';

class UserCreationLogic extends JokeListLogic {


  @override
  Future<BaseResult<List<JokeDetailEntity>>> requestFuture(String pageNum) {
    return RetrofitClient.instance.apiService.getCreationJokeList(pageNum);
  }
}
