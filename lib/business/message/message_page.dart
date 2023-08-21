import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/color_palettes.dart';
import 'message_logic.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<MessageLogic>();
    return Obx(() => Container(
          color: ColorPalettes.instance.background,
          child:
          Center(child: Text("消息", style: TextStyle(color: ColorPalettes.instance.firstText)))));
  }
}
