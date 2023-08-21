import 'dart:ui';

import 'package:get/get.dart';
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

  static ColorPalettes get instance => _getInstance();
  static ColorPalettes? _instance;

  static ColorPalettes _getInstance() {
    _instance ??= ColorPalettes._();
    return _instance!;
  }

  final Map<PalettesStyle, IPalette> palettes = {
    PalettesStyle.dark: DarkPalette(),
    PalettesStyle.lightDefault: DefaultPalette(),
    PalettesStyle.blue: BluePalette(),
    PalettesStyle.green: GreenPalette(),
    PalettesStyle.orange: OrangePalette(),
    PalettesStyle.purple: PurplePalette(),
    PalettesStyle.yellow: YellowPalette(),
  };

  final RxObjectMixin<PalettesStyle> _colorStyle =
      PalettesStyle.lightDefault.obs;

  void changeTheme(PalettesStyle style) {
    _colorStyle.value = style;
  }

   bool isDark() => _colorStyle.value == PalettesStyle.dark;

  Color get statusBar => palettes[_colorStyle.value]!.primary;

  Color get pure => palettes[_colorStyle.value]!.pure;

  Color get primary => palettes[_colorStyle.value]!.primary;

  Color get primaryVariant => palettes[_colorStyle.value]!.primaryVariant;

  Color get secondary => palettes[_colorStyle.value]!.secondary;

  Color get background => palettes[_colorStyle.value]!.background;

  Color get firstText => palettes[_colorStyle.value]!.firstText;

  Color get secondText => palettes[_colorStyle.value]!.secondText;

  Color get thirdText => palettes[_colorStyle.value]!.thirdText;

  Color get firstIcon => palettes[_colorStyle.value]!.firstIcon;

  Color get secondIcon => palettes[_colorStyle.value]!.secondIcon;

  Color get thirdIcon => palettes[_colorStyle.value]!.thirdIcon;

  Color get appBarBackground => palettes[_colorStyle.value]!.appBarBackground;

  Color get appBarContent => palettes[_colorStyle.value]!.appBarContent;

  Color get card => palettes[_colorStyle.value]!.card;

  Color get divider => palettes[_colorStyle.value]!.divider;

  Color get separator => palettes[_colorStyle.value]!.separator;

  Color get inputBackground => palettes[_colorStyle.value]!.inputBackground;

}

enum PalettesStyle { dark, lightDefault, blue, green, orange, purple, yellow}
