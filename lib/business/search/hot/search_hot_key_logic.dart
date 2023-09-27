import 'package:get/get.dart';
import 'package:joke_fun_flutter/common/view_state/view_state_logic.dart';
import 'package:joke_fun_flutter/http/retrofit_client.dart';

class SearchHotKeyLogic extends ViewStateLogic {

  RxList<String> hotKeys = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  @override
  void loadData() {
    super.loadData();
   sendRequest( RetrofitClient.instance.apiService.getHotSearch(),
   successCallback: (value) {
     hotKeys.clear();
     hotKeys.addAll(value!);
   });
  }
}
