import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/common/cpn/cpn_joke_item.dart';
import 'package:joke_fun_flutter/business/common/logic/joke_comment_list_logic.dart';
import 'package:joke_fun_flutter/business/common/sheet/joke_comment_sheet.dart';
import 'package:joke_fun_flutter/business/joke_detail/joke_detail_logic.dart';
import 'package:joke_fun_flutter/common/cpn/app_bar.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_nested_page.dart';
import 'package:joke_fun_flutter/models/joke_detail_entity.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';


/// 段子详情页
class JokeDetailPage extends CpnNestedPage<JokeDetailLogic> {
  JokeDetailPage({Key? key, super.tag}) : super(key: key);

  @override
  Widget buildNestedHeader(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cpnJokeHeight =
          (logic.globalKey.currentContext!.findRenderObject() as RenderBox)
              .size
              .height;
      logic.expandedHeight.value = cpnJokeHeight;
    });
    return Obx(() {
      return SliverAppBar(
          toolbarHeight: 88.w,
          expandedHeight: logic.expandedHeight.value,
          backgroundColor: ColorPalettes.instance.pure,
          title: commonTitleBar(
              title: "帖子详情", backgroundColor: ColorPalettes.instance.pure),
          automaticallyImplyLeading: false,
          pinned: true,
          elevation: 0,
          titleSpacing: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorPalettes.instance.pure,
              statusBarIconBrightness: Brightness.dark),
          flexibleSpace: _flexibleSpace(context),
          bottom: PreferredSize(
              preferredSize: Size(double.infinity, 100.w), child: _tabBar()));
    });
  }

  Widget _flexibleSpace(BuildContext context) {
    JokeDetailEntity item = logic.jokeDetailEntity.value;
    return FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Column(
          children: [
            Container(
                key: logic.globalKey,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 88.w),
                child: CpnJoke(
                    item: item,
                    likeCallback: () {
                      logic.likeJokeAction(
                          item.joke?.jokesId, item.info?.isLike != true);
                    },
                    unlikeCallback: () {
                      logic.unlikeJokeAction(
                          item.joke?.jokesId, item.info?.isUnlike != true);
                    },
                    attentionCallback: () {
                      bool noAttention = item.info?.isAttention != true;
                      logic.attentionUser(item.user?.userId, noAttention);
                    },
                    videoPlayHelper: logic.videoPlayHelper,
                    commentCallback: () {
                      showSendCommentSheet(
                          GetInstance().find<JokeCommentListLogic>(tag: tag));
                    })),
          ],
        ));
  }

  Widget _tabBar() {
    return TabBar(
      controller: logic.tabController,
      indicatorSize: TabBarIndicatorSize.tab,
      isScrollable: false,
      indicator: UnderlineTabIndicator(
          borderRadius: BorderRadius.circular(4.w),
          insets: EdgeInsets.symmetric(horizontal: 160.w),
          borderSide:
              BorderSide(width: 4.w, color: ColorPalettes.instance.primary)),
      labelPadding: const EdgeInsets.all(0),
      labelColor: ColorPalettes.instance.primary,
      unselectedLabelColor: ColorPalettes.instance.secondText,
      labelStyle: TextStyle(fontSize: 36.w, fontWeight: FontWeight.bold),
      unselectedLabelStyle:
          TextStyle(fontSize: 32.w, fontWeight: FontWeight.normal),
      //未选中时标签的颜色
      onTap: (int index) {
        logic.jumpToPage(index); //点击标签时切换页面
      },
      tabs: logic.tabs.map((tab) {
        return Container(
          height: 72.w,
          alignment: Alignment.center,
          child: Text(
            tab,
            textAlign: TextAlign.center,
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget buildNestedBody(BuildContext context) {
    return TabBarView(
        controller: logic.tabController, children: logic.navPages);
  }

  @override
  double pinnedHeaderHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top + 88.w + 100.w;
  }
}
