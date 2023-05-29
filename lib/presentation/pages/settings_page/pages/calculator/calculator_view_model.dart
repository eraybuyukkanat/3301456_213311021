import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_media_app_demo/presentation/pages/settings_page/pages/calculator/calculator_view.dart';

abstract class CalculatorViewModel extends State<CalculatorViewPage> {
  String pageTitle = "Not Hesapla";

  String? inputVizeValue = "0";
  String? inputFinalValue = "0";
  double avg = 0;
  double calculateAvg(firstValue, secondValue) {
    avg = (double.parse(firstValue!) * 40 / 100) +
        (double.parse(secondValue!) * 60 / 100);
    return avg;
  }

  String? calculateLetter() {
    if (avg <= 100 && avg >= 88) {
      return "AA";
    } else if (avg <= 87 && avg >= 80) {
      return "BA";
    } else if (avg <= 79 && avg >= 73) {
      return "BB";
    } else if (avg <= 72 && avg >= 66) {
      return "CB";
    } else if (avg <= 65 && avg >= 60) {
      return "CC";
    } else if (avg <= 59 && avg >= 55) {
      return "DC";
    } else if (avg <= 54 && avg >= 50) {
      return "DD";
    } else {
      return "FF";
    }
  }

  TextEditingController vizeNotuController = TextEditingController();
  TextEditingController finalNotuController = TextEditingController();
}

class CustomRangeTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '')
      return TextEditingValue();
    else if (int.parse(newValue.text) < 0)
      return TextEditingValue().copyWith(text: '0');

    return int.parse(newValue.text) > 100
        ? TextEditingValue().copyWith(text: '100')
        : newValue;
  }
}
