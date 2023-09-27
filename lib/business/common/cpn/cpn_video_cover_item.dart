import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joke_fun_flutter/common/cpn/cpn_image.dart';
import 'package:joke_fun_flutter/common/ext/asset_ext.dart';
import 'package:joke_fun_flutter/common/util/media_util.dart';
import 'package:joke_fun_flutter/models/video_entity.dart';

/// 视频封面item组件
class CpnVideoCoverItem extends StatelessWidget {
  final VideoEntity item;
  final int index;

  const CpnVideoCoverItem({required this.item, required this.index, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          cpnImage(
              url: decodeMediaUrl(item.cover),
              boxFit: BoxFit.cover,
              defaultHolderWidth: 72.w,
              defaultHolderHeight: 72.w,
              defaultErrorAssetName: "ic_default_video_cover",
              defaultPlaceHolderAssetName: "ic_default_video_cover"),
          _bottom()
        ],
      ),
    );
  }

  Widget _bottom() {
    return Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          padding: EdgeInsets.only(right: 16.w, top: 4.w),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.white.withOpacity(0.3), Colors.white.withOpacity(0.03)])),
          width: double.infinity,
          alignment: Alignment.centerRight,
          height: 72.w,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("ic_like_heart".webp,
                  width: 28.w, height: 28.w, color: Colors.white),
              SizedBox(width: 8.w),
              Text((item.likeNum ?? 0).toString(),
                  style: TextStyle(color: Colors.white, fontSize: 28.w))
            ],
          ),
        ));
  }
}
