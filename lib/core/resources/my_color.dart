

import "package:flutter/material.dart";


class MyColors {
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color transparent = Colors.transparent;
  static Color green = Colors.green;
  static Color red = Colors.red;
  static Color blue = Colors.blue;
  static Color grey = Colors.grey;
  static Color yellow = Colors.yellow;
  static Color orange = Colors.orange;

  /// most used colors
  static Color primary = HexColor.fromHex("#004F70");
  static Color secondary = HexColor.fromHex("#3E90CC");
  static Color greyNormal = HexColor.fromHex("#545454");
  static Color greyLight = HexColor.fromHex("#7F7F7F");
  static Color greenLight = HexColor.fromHex("#0AB39C");
  static Color redLight = HexColor.fromHex("#FF001F");

  /// few used colors
  static Color lightGreen = HexColor.fromHex("#08D1B6");



  //
// static Color getColor({
//   required Mode? themeMode,
// }) {
//   var _color = Colors.red;
//   switch (themeMode) {
//     case Mode.blue:
//       _color = Colors.blue;
//       break;
//     case Mode.red:
//       _color = Colors.red;
//       break;
//     default:
//       break;
//   }
//   return _color;
//
// }
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll("#", "");
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString";
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}


