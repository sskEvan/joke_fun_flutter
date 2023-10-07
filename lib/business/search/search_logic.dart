import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/search/result/search_result_logic.dart';
import 'package:joke_fun_flutter/common/util/keyboard_util.dart';

class SearchLogic extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  RxString keyword = "".obs;
  final SearchResultLogic searchResultLogic = Get.find<SearchResultLogic>();
  Timer? _delaySearchTimer;
  RxBool searchMode = false.obs;

  void updateKey(String value, {bool needDelay = false}) {
    keyword.value = value;

    textEditingController.value = TextEditingValue(
        text: value,
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream, offset: value.length)));

    _delaySearchTimer?.cancel();
    if (value.isNotEmpty) {
      if (needDelay) {
        _delaySearchTimer = Timer(const Duration(milliseconds: 1000), () {
          searchMode.value = true;
          hideKeyboard();
          searchResultLogic.updateKey(keyword.value);
        });
      } else {
        searchMode.value = true;
        hideKeyboard();
        searchResultLogic.updateKey(keyword.value);
      }
    } else {
      searchMode.value = false;
      searchResultLogic.updateKey(keyword.value);
    }
  }

  @override
  void dispose() {
    _delaySearchTimer?.cancel();
    super.dispose();
  }
}
