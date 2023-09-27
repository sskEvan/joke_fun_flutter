import 'dart:convert';

import 'package:get/get.dart';
import 'package:joke_fun_flutter/common/util/preference_utils.dart';

class SearchHistoryLogic extends GetxController {
  final String keyHistorySearch = "historySearch";

  RxList<String> historyKeys = <String>[].obs;
  RxBool editMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    String localJson = PreferenceUtils.instance.getString(keyHistorySearch);
    if(localJson.isNotEmpty) {
      List<String> localHistoryKeys = jsonDecode(localJson).cast<String>();
      historyKeys.addAll(localHistoryKeys);
    }

  }

  void addKey(String key) {
    historyKeys.remove(key);
    historyKeys.insert(0, key);
    if (historyKeys.length > 10) {
      /// 最多保存10条
      historyKeys.value = historyKeys.sublist(0, 10);
    }

    historyKeys.refresh();
    String json = jsonEncode(historyKeys);
    PreferenceUtils.instance.putString(keyHistorySearch, json);
  }

  void removeKey(String key) {
    historyKeys.remove(key);
    historyKeys.refresh();
    String json = jsonEncode(historyKeys);
    PreferenceUtils.instance.putString(keyHistorySearch, json);
  }

  void removeAll() {
    historyKeys.clear();
    historyKeys.refresh();
    editMode.value = false;
    PreferenceUtils.instance.putString(keyHistorySearch, "");
  }
}
