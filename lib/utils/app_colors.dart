import 'package:flutter/material.dart';

import 'hex_color.dart';

class AppColors {
  static Color navbarColor = HexColor("#8871ff");
  static Color greyTextColor = HexColor("#99A5B2");
  static Color unSelectedTab = HexColor("#DDE6F5");
  static Color redColor = HexColor("#F34E3F");
  static Color redTextColor = HexColor("#FF5252");
  static Color headerColor = HexColor("#001F3E");
  static Color titleColor = HexColor("#585858");
  static Color subTitleColor = HexColor("#ADADAD");
  static Color hintColor = HexColor("#AAAAAA");
  static Color primaryBlack = HexColor("#212121");
  static Color nightModeBgColor = HexColor("#303030");
  static Color subBlack = HexColor("#5B5B5B");
  static Color successColor = HexColor("#4CD964");
  static Color darkHighlight = HexColor("#1D1D1D");
  static Color blackTextColor = HexColor("#202020");
  static Color primaryColor2 = HexColor("#007EE1");
  static Color primaryColor = primaryColor2;
  static Color whiteColor = HexColor("#ffffff");
  static Color refColor = HexColor("#fb4455");
  static Color primaryColor3 = HexColor("#16B8E0");
  static Color unFavColor = HexColor("#30C574");
  static Color fillColor = HexColor("#ffffff");
  static Color fillColor2 = HexColor("#EDEDED");
  static Color btnColor = HexColor("#1F55BF");

  static List<Color> nightModeGradientColor = [primaryBlack, primaryBlack];
  static List<Color> whitesColor = [
    Colors.white,
    Colors.white,
  ];
  static List<Color> primaryGradientColor20 = greenGradientColor20;
  static List<Color> greenGradientColor20 = [
    primaryColor.withOpacity(0.2),
    primaryColor.withOpacity(0.2)
  ];
  static List<Color> primaryGradient = [primaryColor, primaryColor];
  static List<Color> grayGradient = [Colors.grey, Colors.grey];

  static Gradient whiteGradient = LinearGradient(
    colors: [whiteColor, whiteColor],
  );

  static Gradient subBlackGradient = LinearGradient(
    colors: [subBlack, subBlack],
  );

  static Gradient customGradient(Color color) => LinearGradient(
    colors: [color, color],
  );
}
