import 'package:get/get.dart';
import 'package:joke_fun_flutter/common/view_state/view_state_logic.dart';
import 'package:joke_fun_flutter/http/retrofit_client.dart';
import 'package:joke_fun_flutter/models/experience_overview_entity.dart';

class ExperienceOverviewLogic extends ViewStateLogic {

  final overviewEntity = Rxn<ExperienceOverviewEntity>();

  @override
  void loadData() {
    super.loadData();
    sendRequest(RetrofitClient.instance.apiService.getExperienceOverview(),
    successCallback: (value) {
      overviewEntity.value = value;
    });
  }

}
