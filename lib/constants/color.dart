import 'dart:ui' show Color;

class ColorBase {
  static const softBlue = Color.fromRGBO(105, 127, 248, 1);
  static const lightBlue = Color.fromRGBO(222, 235, 236, 1);
  static const mildBlue = Color.fromRGBO(36, 120, 129, 1);
  static const primaryRed = Color.fromRGBO(158, 6, 32, 1);
  static const primaryBlack = Color.fromRGBO(37, 40, 43, 1);
  static const primaryWhite = Color.fromRGBO(255, 255, 255, 1);

  static const secondaryBlue = Color.fromRGBO(29, 160, 255, 1);
  static const secondaryGreen = Color.fromRGBO(0, 196, 140, 1);
  static const secondaryOrange = Color.fromRGBO(252, 177, 69, 1);
  static const secondaryRed = Color.fromRGBO(244, 67, 53, 1);
  static const secondaryDarkRed = Color.fromRGBO(138, 5, 27, 1);
  static const secondaryWhite = Color.fromRGBO(252, 252, 252, 1);
  static const lightGrey = const Color(0xffc9c9c9);
  static const black100 = Color.fromRGBO(37, 40, 43, 1);
  static const notificationYellow = const Color(0xffFFF7EC);
  static const black80 = Color.fromRGBO(82, 87, 92, 1);
  static const black60 = Color.fromRGBO(160, 164, 168, 1);
  static const black40 = Color.fromRGBO(202, 204, 207, 1);
  static const black10 = Color.fromRGBO(232, 232, 232, 1);
  static const black5 = Color.fromRGBO(249, 249, 249, 1);
  static const notificationColor = const Color(0xffF44335);
  static const grey5 = Color.fromRGBO(224, 224, 224, 1);
  static const grey03 = Color.fromRGBO(51, 51, 51, 0.3);
  static const grey1 = Color.fromRGBO(51, 51, 51, 1);
  static const grey0 = Color.fromRGBO(245, 245, 245, 1);

  static const activeButton = Color.fromRGBO(158, 6, 32, 1);
  static const disableButton = Color.fromRGBO(202, 204, 207, 1);
}

final Map<int, Color> primaryRedColors = {
  50: Color.fromRGBO(158, 6, 32, .1),
  100: Color.fromRGBO(158, 6, 32, .2),
  200: Color.fromRGBO(158, 6, 32, .3),
  300: Color.fromRGBO(158, 6, 32, .4),
  400: Color.fromRGBO(158, 6, 32, .5),
  500: Color.fromRGBO(158, 6, 32, .6),
  600: Color.fromRGBO(158, 6, 32, .7),
  700: Color.fromRGBO(158, 6, 32, .8),
  800: Color.fromRGBO(158, 6, 32, .9),
  900: Color.fromRGBO(158, 6, 32, 1),
};
