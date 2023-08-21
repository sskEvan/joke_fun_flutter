import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:joke_fun_flutter/business/index/index_binding.dart';
import 'package:joke_fun_flutter/business/index/index_page.dart';
import 'package:joke_fun_flutter/business/login/verifycode/verifycode_login_binding.dart';
import 'package:joke_fun_flutter/business/login/verifycode/verifycode_login_page.dart';
import 'package:joke_fun_flutter/business/push/push_binding.dart';
import 'package:joke_fun_flutter/business/push/push_page.dart';
import 'package:joke_fun_flutter/business/search/search_binding.dart';
import 'package:joke_fun_flutter/business/search/search_page.dart';
import 'package:joke_fun_flutter/business/user_center/edit/edit_center_binding.dart';
import 'package:joke_fun_flutter/business/user_center/edit/edit_center_page.dart';
import 'package:joke_fun_flutter/business/user_center/edit/nickname/edit_nickname_binding.dart';
import 'package:joke_fun_flutter/business/user_center/edit/nickname/edit_nickname_page.dart';
import 'package:joke_fun_flutter/business/user_center/edit/signature/edit_signature_binding.dart';
import 'package:joke_fun_flutter/business/user_center/edit/signature/edit_signature_page.dart';
import 'package:joke_fun_flutter/business/user_center/user_center_binding.dart';
import 'package:joke_fun_flutter/business/user_center/user_center_page.dart';

class AppRoutes {
  static const indexPage = "/index_page";

  static const pushPage = "/push_page";
  static const searchPage = "/search_page";
  static const verifyCodeLoginPage = "/verify_code_login_page";
  static const userCenterPage = "/user_center_page";
  static const userEditCenterPage = "/edit_center_page";
  static const userEditNicknamePage = "/edit_nickname_page";
  static const userEditSignaturePage = "/edit_signature_page";

  static final routerPages = [
    ///主入口
    GetPage(
        name: AppRoutes.indexPage,
        page: () => IndexPage(),
        binding: IndexBinding()),

    /// 发布页面
    GetPage(
        name: AppRoutes.pushPage,
        page: () => PushPage(),
        binding: PushBinding(),
        transition: Transition.downToUp),

    /// 搜索页面
    GetPage(
        name: AppRoutes.searchPage,
        page: () => SearchPage(),
        binding: SearchBinding()),

    /// 验证码登陆页面
    GetPage(
        name: AppRoutes.verifyCodeLoginPage,
        page: () => const VerifyCodeLoginPage(),
        binding: VerifyCodeLoginBinding()),

    /// 用户中心页面
    GetPage(
        name: AppRoutes.userCenterPage,
        page: () => UserCenterPage(),
        binding: UserCenterBinding(),
        transition: Transition.fadeIn),

    /// 用户编辑信息页面
    GetPage(
        name: AppRoutes.userEditCenterPage,
        page: () => EditCenterPage(),
        binding: EditCenterBinding(),
        transition: Transition.fadeIn),

    /// 用户编辑昵称中心
    GetPage(
        name: AppRoutes.userCenterPage,
        page: () => EditNicknamePage(),
        binding: EditNicknameBinding()),

    /// 用户编辑签名中心
    GetPage(
        name: AppRoutes.userEditSignaturePage,
        page: () => EditSignaturePage(),
        binding: EditSignatureBinding()),
  ];
}
