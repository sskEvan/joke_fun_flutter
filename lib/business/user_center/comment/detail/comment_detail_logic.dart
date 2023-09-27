import 'package:get/get.dart';
import 'package:joke_fun_flutter/common/view_state/view_state_logic.dart';
import 'package:joke_fun_flutter/http/retrofit_client.dart';
import 'package:joke_fun_flutter/models/comment_entity.dart';
import 'package:joke_fun_flutter/models/joke_detail_entity.dart';

class CommentDetailLogic extends ViewStateLogic {
  final jokeDetailEntity = Rxn<JokeDetailEntity>();
  late CommentEntity commentEntity;

  @override
  void loadData() {
    super.loadData();
    commentEntity = Get.arguments["commentEntity"];
    int jokeId = Get.arguments["jokeId"];

    sendRequest(
        RetrofitClient.instance.apiService.getTargetJoke(jokeId.toString()),
        successCallback: (value) {
      jokeDetailEntity.value = value!;
    });
  }
}
