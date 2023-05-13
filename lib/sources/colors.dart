import 'package:flutter/material.dart';

class ColorManager {
  static Color? primary = HexColor.fromHex("#0A4D68");
  static Color? grey = HexColor.fromHex("#737477");
  static Color? white = HexColor.fromHex("#FFFFFF");
  static Color? redAccent = HexColor.fromHex("#e61f34");
  static Color? black = HexColor.fromHex("#000000");
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
