import 'package:flutter/gestures.dart';
import 'package:joke_fun_flutter/common/view_state/simple_view_state_paging_logic.dart';
import 'package:joke_fun_flutter/http/retrofit_client.dart';
import 'package:joke_fun_flutter/models/base_result.dart';
import 'package:joke_fun_flutter/models/comment_entity.dart';

class UserCommentLogic extends SimpleViewStatePagingLogic {

  @override
  Future<BaseResult<List<CommentEntity>>> requestFuture(String pageNum) {
    return RetrofitClient.instance.apiService.getCommentList(pageNum);
  }

}
