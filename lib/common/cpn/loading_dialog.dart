import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joke_fun_flutter/common/ext/asset_ext.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';
import 'package:lottie/lottie.dart';

/// 通用加载对话框
class LoadingDialog extends Dialog {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency, //透明类型
      child: Center(
        child: Container(
          width: 180.w,
          height: 180.w,
          alignment: Alignment.center,
          decoration: ShapeDecoration(
            color: ColorPalettes.instance.pure,
            shape:  RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16.w),
              ),
            ),
          ),
          child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                ColorPalettes.instance.secondary,
                BlendMode.srcIn,
              ),
              child: Lottie.asset("view_loading".lottie,
                  width: 160.w, height: 160.w)),
        ),
      ),
    );
  }
}
