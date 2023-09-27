import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/user_center/experience/cpn/list/experience_list_logic.dart';
import 'package:joke_fun_flutter/business/user_center/experience/experience_logic.dart';

import 'cpn/overview/experience_overview_logic.dart';

class ExperienceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExperienceLogic());
    Get.lazyPut(() => ExperienceOverviewLogic());
    Get.lazyPut(() => ExperienceListLogic());
  }
}
