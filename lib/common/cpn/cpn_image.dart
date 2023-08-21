import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joke_fun_flutter/common/ext/asset_ext.dart';

Widget cpnNetworkImage({
  String? url,
  double? width,
  double? height,
  BoxFit? boxFit = BoxFit.fitWidth,
  fadeOutDuration = const Duration(milliseconds: 150),
  fadeInDuration = const Duration(milliseconds: 150),
  double? defaultHolderWidth,
  double? defaultHolderHeight,
  String defaultPlaceHolderAssetName = "ic_default_place_holder",
  String defaultErrorAssetName = "ic_default_place_holder",
  Widget? placeHolderWidget,
  Widget? errorWidget,
}) {
  return CachedNetworkImage(
      imageUrl: url ?? "",
      width: width,
      height: height,
      fit: boxFit,
      fadeOutDuration: fadeOutDuration,
      fadeInDuration: fadeInDuration,
      placeholder: (context, url) => Container(
          alignment: Alignment.center,
          width: width,
          height: height,
          child: placeHolderWidget ??
              Image.asset(defaultPlaceHolderAssetName.webp,
                  width: defaultHolderWidth ?? width,
                  height: defaultHolderHeight ?? height)),
      errorWidget: (context, url, error) => Container(
          alignment: Alignment.center,
          width: width,
          height: height,
          child: errorWidget ??
              Image.asset(defaultPlaceHolderAssetName.webp,
                  width: defaultHolderWidth ?? width,
                  height: defaultHolderHeight ?? height)));
}

Widget cpnCircleNetworkImage({
  String? url,
  double? width,
  double? height,
  BoxFit? boxFit = BoxFit.fitWidth,
  fadeOutDuration = const Duration(milliseconds: 150),
  fadeInDuration = const Duration(milliseconds: 150),
  double? defaultHolderWidth,
  double? defaultHolderHeight,
  String defaultPlaceHolderAssetName = "ic_default_place_holder",
  String defaultErrorAssetName = "ic_default_place_holder",
  Widget? placeHolderWidget,
  Widget? errorWidget,
}) {
  return ClipOval(
      //圆角图片
      child: CachedNetworkImage(
          imageUrl: url ?? "",
          width: width,
          height: height,
          fit: boxFit,
          fadeOutDuration: fadeOutDuration,
          fadeInDuration: fadeInDuration,
          placeholder: (context, url) => Container(
              alignment: Alignment.center,
              width: width,
              height: height,
              child: placeHolderWidget ??
                  Image.asset(defaultPlaceHolderAssetName.webp,
                      width: defaultHolderWidth ?? width,
                      height: defaultHolderHeight ?? height)),
          errorWidget: (context, url, error) => Container(
              alignment: Alignment.center,
              width: width,
              height: height,
              child: errorWidget ??
                  Image.asset(defaultPlaceHolderAssetName.webp,
                      width: defaultHolderWidth ?? width,
                      height: defaultHolderHeight ?? height))));
}

Widget cpnCircleBorderNetworkImage({
  String? url,
  double size = 100,
  Border? border,
  BoxFit? boxFit = BoxFit.fitWidth,
  fadeOutDuration = const Duration(milliseconds: 150),
  fadeInDuration = const Duration(milliseconds: 150),
  String defaultPlaceHolderAssetName = "ic_default_place_holder",
  String defaultErrorAssetName = "ic_default_place_holder",
  Widget? placeHolderWidget,
  Widget? errorWidget,
}) {
  return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        border: border
      ),
      child: ClipOval(
          //圆角图片
          child: CachedNetworkImage(
              imageUrl: url ?? "",
              width: size,
              height: size,
              fit: boxFit,
              fadeOutDuration: fadeOutDuration,
              fadeInDuration: fadeInDuration,
              placeholder: (context, url) => Container(
                  alignment: Alignment.center,
                  width: size,
                  height: size,
                  child: placeHolderWidget ??
                      Image.asset(defaultPlaceHolderAssetName.webp,
                          width: size, height: size)),
              errorWidget: (context, url, error) => Container(
                  alignment: Alignment.center,
                  width: size,
                  height: size,
                  child: errorWidget ??
                      Image.asset(defaultPlaceHolderAssetName.webp,
                          width: size, height: size)))));
}

Widget cpnRadiusNetworkImage({
  String? url,
  double? width,
  double? height,
  BoxFit? boxFit = BoxFit.fitWidth,
  fadeOutDuration = const Duration(milliseconds: 150),
  fadeInDuration = const Duration(milliseconds: 150),
  double? radius,
  double? defaultHolderWidth,
  double? defaultHolderHeight,
  String defaultPlaceHolderAssetName = "ic_default_place_holder",
  String defaultErrorAssetName = "ic_default_place_holder",
  Widget? placeHolderWidget,
  Widget? errorWidget,
}) {
  return ClipRRect(
      //圆角图片
      borderRadius: BorderRadius.circular(radius ?? 0.0),
      //圆角图片
      child: CachedNetworkImage(
          imageUrl: url ?? "",
          width: width,
          height: height,
          fit: boxFit,
          fadeOutDuration: fadeOutDuration,
          fadeInDuration: fadeInDuration,
          placeholder: (context, url) => Container(
              alignment: Alignment.center,
              width: width,
              height: height,
              child: placeHolderWidget ??
                  Image.asset(defaultPlaceHolderAssetName.webp,
                      width: defaultHolderWidth ?? width,
                      height: defaultHolderHeight ?? height)),
          errorWidget: (context, url, error) => Container(
              alignment: Alignment.center,
              width: width,
              height: height,
              child: errorWidget ??
                  Image.asset(defaultPlaceHolderAssetName.webp,
                      width: defaultHolderWidth ?? width,
                      height: defaultHolderHeight ?? height))));
}
