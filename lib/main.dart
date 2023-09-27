import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:joke_fun_flutter/business/index/index_binding.dart';
import 'package:joke_fun_flutter/business/index/index_page.dart';
import 'package:joke_fun_flutter/router/router_observer.dart';
import 'package:joke_fun_flutter/router/routers.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'common/cpn/default_refresh_indicator.dart';
import 'common/util/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injection().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(750, 1334),
        builder: (context, child) => _defaultRefreshConfiguration(
              GetMaterialApp(
                showPerformanceOverlay: false,
                getPages: AppRoutes.routerPages,
                navigatorObservers: [AppRouterObserver()],
                defaultTransition: Transition.rightToLeft,
                transitionDuration: const Duration(milliseconds: 150),
                title: "段子乐",
                home: IndexPage(),
                initialBinding: IndexBinding(),
                locale: const Locale('zh'),
              ),
            ));
  }

  RefreshConfiguration _defaultRefreshConfiguration(Widget child) {
    return RefreshConfiguration(
        headerBuilder: () => DefaultRefreshHeader(),
        footerBuilder: () => DefaultRefreshFooter(),
        headerTriggerDistance: 180.w,
        maxOverScrollExtent: 100.w,
        maxUnderScrollExtent: 0,
        enableScrollWhenRefreshCompleted: true,
        enableLoadingWhenFailed: true,
        hideFooterWhenNotFull: false,
        enableBallisticLoad: true,
        footerTriggerDistance: 140.w,
        child: child);
  }
}
