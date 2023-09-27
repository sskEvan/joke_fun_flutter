import 'package:joke_fun_flutter/common/view_state/simple_view_state_paging_logic.dart';
import 'package:joke_fun_flutter/http/retrofit_client.dart';
import 'package:joke_fun_flutter/models/base_result.dart';
import 'package:joke_fun_flutter/models/video_entity.dart';

class UserCreationVideoLogic extends SimpleViewStatePagingLogic {
  String targetUserId = "";

  @override
  Future<BaseResult<List<VideoEntity>>> requestFuture(String pageNum) {
    return RetrofitClient.instance.apiService
        .getUserVideoList(targetUserId, pageNum);
  }
}
