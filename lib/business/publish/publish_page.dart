import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/common/cpn/cpn_video_play.dart';
import 'package:joke_fun_flutter/business/publish/publish_logic.dart';
import 'package:joke_fun_flutter/common/cpn/app_bar.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_image.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_view_state.dart';
import 'package:joke_fun_flutter/common/ext/asset_ext.dart';
import 'package:joke_fun_flutter/common/util/permisson_util.dart';
import 'package:joke_fun_flutter/router/routers.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

/// 发布段子页面
class PublishPage extends CpnViewState<PublishLogic> {
  const PublishPage({Key? key}) : super(key: key, bindViewState: false);

  @override
  AppBar? buildAppBar() {
    return commonAppBar(
      bottom: commonTitleBar(
          leftIcon: "ic_close",
          leftClick: handleBack,
          rightWidget: Container(
            alignment: Alignment.center,
            height: 52.w,
            width: 96.w,
            decoration: BoxDecoration(
                color: logic.isInputValid.value
                    ? ColorPalettes.instance.primary
                    : ColorPalettes.instance.inputBackground,
                borderRadius: BorderRadius.all(Radius.circular(32.w))),
            child: Text(
              "发布",
              style: TextStyle(
                  color: logic.isInputValid.value
                      ? Colors.white
                      : ColorPalettes.instance.thirdText,
                  fontSize: 26.w),
            ),
          ),
          rightClick: () {
            if (logic.isInputValid.value) {
              if (logic.imagePaths.isNotEmpty || logic.videoPath.isNotEmpty) {
                _showBaseDialog(
                    title: "温馨提示",
                    info: "当前版本暂不支持图片/视频上传功能，只支持文本发布",
                    height: 360.w,
                    cancelButtonText: "取消",
                    confirmButtonText: "发布",
                    confirmCallback: () {
                      logic.publish();
                    });
              } else {
                logic.publish();
              }
            }
          }),
    );
  }

  bool handleBack() {
    if (logic.hasEdit()) {
      _showBaseDialog(
          title: "是否保留本次编辑",
          info: "保留后，再次进入可继续编辑",
          height: 360.w,
          cancelButtonText: "不保留",
          confirmButtonText: "保留",
          cancelCallback: () {
            logic.clearEditInfo();
          },
          confirmCallback: () {
            logic.saveEditInfo();
          });
      return false;
    } else {
      Get.back();
      return true;
    }
  }

  void _showBaseDialog(
      {required String title,
      required String info,
      required double height,
      String cancelButtonText = "取消",
      String confirmButtonText = "确定",
      VoidCallback? cancelCallback,
      VoidCallback? confirmCallback}) {
    logic.focusNode.unfocus();

    Get.dialog(Center(
      child: Center(
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: ColorPalettes.instance.background,
                borderRadius: BorderRadius.all(Radius.circular(32.w))),
            padding: EdgeInsets.symmetric(vertical: 48.w, horizontal: 32.w),
            width: 580.w,
            height: height,
            child: Material(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontSize: 32.w,
                          color: ColorPalettes.instance.firstText,
                          fontWeight: FontWeight.bold)),
                  Center(
                    child: Text(info,
                        style: TextStyle(
                            fontSize: 28.w,
                            color: ColorPalettes.instance.secondText)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          if (cancelCallback != null) {
                            cancelCallback();
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 72.w,
                          width: 192.w,
                          decoration: BoxDecoration(
                              border: Border.fromBorderSide(BorderSide(
                                  color: ColorPalettes.instance.thirdText,
                                  width: 2.w)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(36.w))),
                          child: Text(
                            cancelButtonText,
                            style: TextStyle(
                                color: ColorPalettes.instance.secondText,
                                fontSize: 30.w),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          if (confirmCallback != null) {
                            confirmCallback();
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 72.w,
                          width: 192.w,
                          decoration: BoxDecoration(
                              color: ColorPalettes.instance.primary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(36.w))),
                          child: Text(
                            confirmButtonText,
                            style:
                                TextStyle(color: Colors.white, fontSize: 30.w),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )),
      ),
    ));
  }

  @override
  Widget buildBody(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return handleBack();
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _inputText(),
            _actionButtons(context),
            SizedBox(
              height: 32.w,
            ),
            _picsVideoContent(context)
          ],
        ),
      ),
    );
  }

  Widget _inputText() {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: TextField(
        controller: logic.textEditingController,
        focusNode: logic.focusNode,
        // autofocus: true,
        maxLength: 300,
        maxLines: 10,
        style:
            TextStyle(fontSize: 28.w, color: ColorPalettes.instance.firstText),
        cursorColor: ColorPalettes.instance.primary,
        decoration: InputDecoration(
          hintText: "我的快乐源泉",
          border: InputBorder.none,
          counterText: "",
          hintStyle: TextStyle(
              fontSize: 28.w, color: ColorPalettes.instance.thirdText),
        ),
        onChanged: (value) {
          logic.updateInput(value);
        },
      ),
    );
  }

  Widget _actionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            PermissionUtil.instance.checkPermission(
                permissionList: [Permission.storage],
                onSuccess: () {
                  if (logic.videoPath.isNotEmpty) {
                    _showBaseDialog(
                        title: "温馨提示",
                        info: "如果选择视频，将覆盖已选择的图片",
                        height: 360.w,
                        confirmCallback: () {
                          logic.selectPics(context);
                        });
                  } else {
                    logic.selectPics(context);
                  }
                });
          },
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Image.asset("ic_publish_pic".webp,
                width: 36.w,
                height: 36.w,
                color: ColorPalettes.instance.thirdIcon),
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            PermissionUtil.instance.checkPermission(
                permissionList: [Permission.storage],
                onSuccess: () {
                  if (logic.imagePaths.isNotEmpty) {
                    _showBaseDialog(
                        title: "温馨提示",
                        info: "如果选择图片，将覆盖已选择的视频",
                        height: 360.w,
                        confirmCallback: () {
                          logic.selectVideo(context);
                        });
                  } else {
                    logic.selectVideo(context);
                  }
                });
          },
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Image.asset("ic_publish_video".webp,
                width: 36.w,
                height: 36.w,
                color: ColorPalettes.instance.thirdIcon),
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        Container(
          width: 2.w,
          color: ColorPalettes.instance.divider,
          height: 28.w,
        ),
        SizedBox(
          width: 32.w,
        ),
        Text("${logic.input.value.length}/300",
            style: TextStyle(
                color: ColorPalettes.instance.thirdText, fontSize: 24.w)),
        SizedBox(
          width: 32.w,
        ),
      ],
    );
  }

  Widget _picsVideoContent(BuildContext context) {
    Widget widget = const SizedBox.shrink();
    if (logic.imagePaths.isNotEmpty) {
      widget = _pics(context);
    } else if (logic.videoPath.value.isNotEmpty) {
      widget = _video(context);
    }
    return widget;
  }

  Widget _pics(BuildContext context) {
    /// 多图
    double spacing = 12.w;
    int columnCount = 3;
    double displaySize = (686.w - (columnCount - 1) * spacing) / columnCount;
    List<Widget> images = logic.imagePaths
        .map((v) => GestureDetector(
              onTap: () {
                AppRoutes.jumpPage(AppRoutes.picPreviewPage, arguments: {
                  // "url": url,
                  "urlList": logic.imagePaths,
                  "index": logic.imagePaths.indexOf(v),
                });
              },
              child: SizedBox(
                width: displaySize,
                height: displaySize,
                child: Stack(
                  children: [
                    cpnRadiusImage(
                        url: v,
                        width: displaySize,
                        height: displaySize,
                        boxFit: BoxFit.cover,
                        radius: 8.w),
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          logic.removePic(v);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.w),
                          child: Image.asset(
                            "ic_clear_input".webp,
                            width: 56.w,
                            height: 56.w,
                            color: ColorPalettes.instance.thirdIcon,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ))
        .toList();
    if (images.length < 9 && images.isNotEmpty) {
      images.add(GestureDetector(
        onTap: () {
          PermissionUtil.instance.checkPermission(
              permissionList: [Permission.storage],
              onSuccess: () {
                logic.selectPics(context);
              });
        },
        child: Container(
          alignment: Alignment.center,
          width: displaySize,
          height: displaySize,
          decoration: BoxDecoration(
              color: ColorPalettes.instance.inputBackground,
              borderRadius: BorderRadius.circular(8.w)),
          child: Image.asset(
            "ic_add_pic".webp,
            width: 100.w,
            height: 100.w,
            color: ColorPalettes.instance.thirdIcon,
          ),
        ),
      ));
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Wrap(
        alignment: WrapAlignment.start,
        runSpacing: spacing,
        spacing: spacing,
        children: images,
      ),
    );
  }

  Widget _video(BuildContext context) {
    AssetEntity videoAsset = logic.selectedVideoAsset!;
    int videoWidth = videoAsset.width;
    int videoHeight = videoAsset.height;
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = (displayWidth / videoWidth) * videoHeight;
    if (displayHeight > displayWidth) {
      displayHeight = displayWidth;
      displayWidth = (displayWidth / displayHeight) * displayWidth;
    }

    return CpnVideoPlay(
        key: Key(logic.videoPath.value),
        width: displayWidth,
        height: displayHeight,
        path: logic.videoPath.value,
        isNetwork: false);
  }
}
