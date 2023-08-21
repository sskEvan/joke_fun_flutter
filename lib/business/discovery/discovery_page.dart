import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';

import 'discovery_logic.dart';

class DiscoveryPage extends StatelessWidget {
  const DiscoveryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<DiscoveryLogic>();

    return Obx(() => Container(
          color: ColorPalettes.instance.background,
          child:
              Center(child: Text("发现", style: TextStyle(color: ColorPalettes.instance.firstText)))));
  }
}
