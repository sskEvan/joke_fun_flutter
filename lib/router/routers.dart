import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/index/index_binding.dart';
import 'package:joke_fun_flutter/business/index/index_page.dart';
import 'package:joke_fun_flutter/business/joke_detail/joke_detail_binding.dart';
import 'package:joke_fun_flutter/business/joke_detail/joke_detail_page.dart';
import 'package:joke_fun_flutter/business/login/verifycode/verifycode_login_binding.dart';
import 'package:joke_fun_flutter/business/login/verifycode/verifycode_login_page.dart';
import 'package:joke_fun_flutter/business/pic_preview/pic_preview_binding.dart';
import 'package:joke_fun_flutter/business/pic_preview/pic_preview_page.dart';
import 'package:joke_fun_flutter/business/publish/publish_binding.dart';
import 'package:joke_fun_flutter/business/publish/publish_page.dart';
import 'package:joke_fun_flutter/business/search/search_binding.dart';
import 'package:joke_fun_flutter/business/search/search_page.dart';
import 'package:joke_fun_flutter/business/setting/setting_binding.dart';
import 'package:joke_fun_flutter/business/setting/setting_page.dart';
import 'package:joke_fun_flutter/business/user_center/comment/detail/comment_detail_binding.dart';
import 'package:joke_fun_flutter/business/user_center/comment/detail/comment_detail_page.dart';
import 'package:joke_fun_flutter/business/user_center/edit/avatar/crop_avatar_binding.dart';
import 'package:joke_fun_flutter/business/user_center/edit/avatar/crop_avatar_page.dart';
import 'package:joke_fun_flutter/business/user_center/edit/edit_center_binding.dart';
import 'package:joke_fun_flutter/business/user_center/edit/edit_center_page.dart';
import 'package:joke_fun_flutter/business/user_center/edit/nickname/edit_nickname_binding.dart';
import 'package:joke_fun_flutter/business/user_center/edit/nickname/edit_nickname_page.dart';
import 'package:joke_fun_flutter/business/user_center/edit/signature/edit_signature_binding.dart';
import 'package:joke_fun_flutter/business/user_center/edit/signature/edit_signature_page.dart';
import 'package:joke_fun_flutter/business/user_center/experience/experience_binding.dart';
import 'package:joke_fun_flutter/business/user_center/experience/experience_page.dart';
import 'package:joke_fun_flutter/business/user_center/fans/fans_binding.dart';
import 'package:joke_fun_flutter/business/user_center/fans/fans_page.dart';
import 'package:joke_fun_flutter/business/user_center/user_center_binding.dart';
import 'package:joke_fun_flutter/business/user_center/user_center_page.dart';
import 'package:joke_fun_flutter/common/util/user_manager.dart';

class AppRoutes {
  static RxString curPage = indexPage.obs;
  static final prePage = Rxn<String>();

  static const indexPage = "/";
  static const publishPage = "/publish_page";
  static const searchPage = "/search_page";
  static const verifyCodeLoginPage = "/verify_code_login_page";
  static const userCenterPage = "/user_center_page";
  static const userEditCenterPage = "/edit_center_page";
  static const userEditNicknamePage = "/edit_nickname_page";
  static const userEditSignaturePage = "/edit_signature_page";
  static const userEditCropAvatarPage = "/edit_crop_avatar_page";
  static const fansPage = "/fans_page";
  static const experiencePage = "/experience_page";
  static const picPreviewPage = "/pic_preview_page";
  static const jokeDetailPage = "/joke_detail_page";
  static const commentDetailPage = "/comment_detail_page";
  static const settingPage = "/setting_page";

  static final routerPages = [
    ///主入口
    GetPage(name: indexPage, page: () => IndexPage(), binding: IndexBinding()),

    /// 发布页面
    GetPage(
        name: publishPage,
        page: () => const PublishPage(),
        binding: PublishBinding(),
        transition: Transition.downToUp),

    /// 搜索页面
    GetPage(
        name: searchPage,
        page: () => SearchPage(),
        binding: SearchBinding(),
        transition: Transition.fadeIn),

    /// 验证码登录页面
    GetPage(
        name: verifyCodeLoginPage,
        page: () => const VerifyCodeLoginPage(),
        binding: VerifyCodeLoginBinding()),

    /// 用户中心页面--实用动态路由实现多实例
    // GetPage(
    //     name: userCenterPage,
    //     page: () => UserCenterPage(),
    //     binding: UserCenterBinding()),

    /// 用户编辑信息页面
    GetPage(
        name: userEditCenterPage,
        page: () => const EditCenterPage(),
        binding: EditCenterBinding(),
        transition: Transition.fadeIn),

    /// 用户编辑昵称中心
    GetPage(
        name: userEditNicknamePage,
        page: () => const EditNicknamePage(),
        binding: EditNicknameBinding()),

    /// 用户编辑签名中心
    GetPage(
        name: userEditSignaturePage,
        page: () => const EditSignaturePage(),
        binding: EditSignatureBinding()),

    /// 裁剪头像
    GetPage(
        name: userEditCropAvatarPage,
        page: () => const CropAvatarPage(),
        binding: CropAvatarBinding()),

    /// 粉丝--实用动态路由实现多实例
    // GetPage(
    //     name: fansPage,
    //     page: () => FansPage(),
    //     binding: FansBinding()),

    /// 乐豆
    GetPage(
        name: experiencePage,
        page: () => ExperiencePage(),
        binding: ExperienceBinding()),

    /// 图片预览
    GetPage(
        name: picPreviewPage,
        page: () => const PicPreviewPage(),
        binding: PicPreviewBinding(),
        transition: Transition.fadeIn),

    /// 设置页面
    GetPage(
        name: settingPage,
        page: () => SettingPage(),
        binding: SettingBinding()),
  ];

  static Future<T?>? jumpPage<T>(String page,
      {dynamic arguments,
      int? id,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      bool needLogin = false,
      String? tag}) {
    if (needLogin && !UserManager.instance.isLogin()) {
      return Get.toNamed(verifyCodeLoginPage);
    } else {
      tag = tag ?? DateTime.now().millisecondsSinceEpoch.toString();
      if (page == userCenterPage) {
        return Get.to(UserCenterPage(tag: tag),
            binding: UserCenterBinding(tag: tag),
            routeName: userCenterPage,
            preventDuplicates: false,
            arguments: arguments);
      } else if (page == fansPage) {
        return Get.to(FansPage(tag: tag),
            binding: FansBinding(tag: tag),
            routeName: fansPage,
            preventDuplicates: false,
            arguments: arguments);
      } else if (page == jokeDetailPage) {
        return Get.to(JokeDetailPage(tag: tag),
            binding: JokeDetailBinding(tag: tag),
            routeName: jokeDetailPage,
            preventDuplicates: false,
            arguments: arguments);
      } else if (page == commentDetailPage) {
        return Get.to(CommentDetailPage(tag: tag),
            binding: CommentDetailBinding(tag: tag),
            routeName: jokeDetailPage,
            preventDuplicates: false,
            arguments: arguments);
      } else {
        return Get.toNamed(page,
            arguments: arguments,
            id: id,
            preventDuplicates: false,
            parameters: parameters);
      }
    }
  }
}
