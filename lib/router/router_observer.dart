import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/router/routers.dart';

class AppRouterObserver extends GetObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (route.settings.name != null && route.settings.name!.isNotEmpty) {
      AppRoutes.prePage.value = route.settings.name;
    }
    if (previousRoute?.settings.name != null &&
        previousRoute!.settings.name!.isNotEmpty) {
      AppRoutes.curPage.value = previousRoute.settings.name!;
    }
    debugPrint(
        "didPop------curPage=${AppRoutes.curPage.value},prePage=${AppRoutes.prePage.value}");
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (previousRoute?.settings.name != null &&
        previousRoute!.settings.name!.isNotEmpty) {
      AppRoutes.prePage.value = previousRoute.settings.name;
    }
    if (route.settings.name != null && route.settings.name!.isNotEmpty) {
      AppRoutes.curPage.value = route.settings.name!;
    }

    debugPrint(
        "didPush------curPage=${AppRoutes.curPage.value},prePage=${AppRoutes.prePage.value}");
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    debugPrint("didReplace------$newRoute");
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    debugPrint("didRemove------$route");
  }
}
