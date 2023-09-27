import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/color_palettes.dart';

/// BottomSheet通用按钮组件
class CpnBottomSheetActionButton extends StatelessWidget {
  final String name;
  final bool isCancel;
  final VoidCallback onClick;

  const CpnBottomSheetActionButton(this.name, this.isCancel, this.onClick, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onClick,
      child: Container(
        height: 120.w,
        alignment: Alignment.center,
        child: Text(
          name,
          style: TextStyle(
            fontSize: isCancel ? 28.w : 32.w,
            color: ColorPalettes.instance.firstText,
            fontWeight: isCancel ? FontWeight.w400 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
