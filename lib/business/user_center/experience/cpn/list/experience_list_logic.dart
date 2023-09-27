import 'package:joke_fun_flutter/common/view_state/simple_view_state_paging_logic.dart';
import 'package:joke_fun_flutter/http/retrofit_client.dart';
import 'package:joke_fun_flutter/models/base_result.dart';
import 'package:joke_fun_flutter/models/experience_item_entity.dart';

class ExperienceListLogic
    extends SimpleViewStatePagingLogic {
  @override
  Future<BaseResult<List<ExperienceItemEntity>>> requestFuture(String pageNum) {
    return RetrofitClient.instance.apiService.getExperienceList(pageNum);
  }
}
