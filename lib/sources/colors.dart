import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = Color.fromARGB(255, 24, 69, 204);
  static Color secondary = HexColor.fromHex("#F6F1F1");
  static Color third = HexColor.fromHex("#AFD3E2");

  static Color grey = HexColor.fromHex("#737477");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color red = HexColor.fromHex("#e61f34");
  static Color black = HexColor.fromHex("#000000");
  static Color yellow = HexColor.fromHex("#FFD966");

  static Color gradient2 = Color.fromARGB(255, 0, 126, 158);
}

extension HexColor on Color {
  static Color fromHex(String? hexColorString) {
    hexColorString = hexColorString!.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF" + hexColorString;
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
