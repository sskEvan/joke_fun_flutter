import 'dart:ui';

import 'package:get/get.dart';
import 'package:joke_fun_flutter/common/util/preference_utils.dart';
import 'package:joke_fun_flutter/theme/palette/dark/dark_palette.dart';
import 'package:joke_fun_flutter/theme/palette/ipalette.dart';
import 'package:joke_fun_flutter/theme/palette/light/blue_palette.dart';
import 'package:joke_fun_flutter/theme/palette/light/default_palette.dart';
import 'package:joke_fun_flutter/theme/palette/light/green_palette.dart';
import 'package:joke_fun_flutter/theme/palette/light/orange_palette.dart';
import 'package:joke_fun_flutter/theme/palette/light/purple_palette.dart';
import 'package:joke_fun_flutter/theme/palette/light/yellow_palette.dart';

class ColorPalettes {
  ColorPalettes._();

  final String key = "keyPalettesIndex";

  static ColorPalettes get instance => _getInstance();
  static ColorPalettes? _instance;

  static ColorPalettes _getInstance() {
    _instance ??= ColorPalettes._();
    return _instance!;
  }

  /// App主题色集合
  final Map<PalettesStyle, IPalette> palettes = {
    PalettesStyle.dark: DarkPalette(),
    PalettesStyle.lightDefault: DefaultPalette(),
    PalettesStyle.blue: BluePalette(),
    PalettesStyle.green: GreenPalette(),
    PalettesStyle.orange: OrangePalette(),
    PalettesStyle.purple: PurplePalette(),
    PalettesStyle.yellow: YellowPalette(),
  };

  /// 当前主题色类型
  late Rx<PalettesStyle> palettesStyle;


  /// 初始化--使用上一次的主题色
  void init() {
    int curPalettesIndex = PreferenceUtils.instance.getInteger(key, 1);
    PalettesStyle curPalettes = palettes.keys
        .where((element) => element.index == curPalettesIndex)
        .first;
    palettesStyle = curPalettes.obs;
  }

  /// 改变主题色
  void changeTheme(PalettesStyle style) {
    palettesStyle.value = style;
    PreferenceUtils.instance.putInteger(key, style.index);
  }

  /// 是否是暗黑模式
  bool isDark() => palettesStyle.value == PalettesStyle.dark;

  Color get statusBar => palettes[palettesStyle.value]!.primary;

  Color get pure => palettes[palettesStyle.value]!.pure;

  Color get primary => palettes[palettesStyle.value]!.primary;

  Color get primaryVariant => palettes[palettesStyle.value]!.primaryVariant;

  Color get secondary => palettes[palettesStyle.value]!.secondary;

  Color get background => palettes[palettesStyle.value]!.background;

  Color get firstText => palettes[palettesStyle.value]!.firstText;

  Color get secondText => palettes[palettesStyle.value]!.secondText;

  Color get thirdText => palettes[palettesStyle.value]!.thirdText;

  Color get firstIcon => palettes[palettesStyle.value]!.firstIcon;

  Color get secondIcon => palettes[palettesStyle.value]!.secondIcon;

  Color get thirdIcon => palettes[palettesStyle.value]!.thirdIcon;

  Color get card => palettes[palettesStyle.value]!.card;

  Color get divider => palettes[palettesStyle.value]!.divider;

  Color get separator => palettes[palettesStyle.value]!.separator;

  Color get inputBackground => palettes[palettesStyle.value]!.inputBackground;
}

/// 主题色类型
enum PalettesStyle { dark, lightDefault, blue, green, orange, purple, yellow }
