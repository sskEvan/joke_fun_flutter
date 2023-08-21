import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../common/cpn/keep_alive_wrapper.dart';
import '../discovery/discovery_page.dart';
import '../home/home_page.dart';
import '../message/message_page.dart';
import '../my/my_page.dart';
import '../push/push_page.dart';

class IndexLogic extends GetxController {
  RxInt index = 4.obs;
  PageController pageController = PageController(initialPage: 4);

  final List<Widget> navPages = [
    KeepAliveWrapper(child: HomePage()),
    const KeepAliveWrapper(child: DiscoveryPage()),
    const KeepAliveWrapper(child: PushPage()),
    const KeepAliveWrapper(child: MessagePage()),
    const KeepAliveWrapper(child: MyPage()),
  ];

  void navigate(int index) {
    this.index.value = index;
    pageController.jumpToPage(index);
  }
}
