import 'package:get/get.dart';

import 'fans_logic.dart';

class FansBinding extends Bindings {
  final String? tag;
  FansBinding({this.tag});

  @override
  void dependencies() {
    Get.lazyPut(() => FansLogic(), tag: tag);
  }
}
