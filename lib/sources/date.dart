import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class projectDate {
  DateTime date = DateTime.now();

  Map daysTR = {
    1: "Pazartesi",
    2: "Salı",
    3: "Çarşamba",
    4: "Perşembe",
    5: "Cuma",
    6: "Cumartesi",
    7: "Pazar"
  };
  Map daysEN = {
    1: "Monday",
    2: "Tuesday",
    3: "Wednesday",
    4: "Thursday",
    5: "Friday",
    6: "Saturday",
    7: "Sunday"
  };

  Map<int, String> months = {
    1: "Ocak",
    2: "Şubat",
    3: "Mart",
    4: "Nisan",
    5: "Mayıs",
    6: "Haziran",
    7: "Temmuz",
    8: "Ağustos",
    9: "Eylül",
    10: "Ekim",
    11: "Kasım",
    12: "Aralık"
  };

  String currentDateTR() {
    return "${currentDay()} ${currentMonthTR()} ${currentYear()}";
  }

  String currentDay() {
    return date.day.toString();
  }

  String currentYear() {
    return date.year.toString();
  }

  String currentMonthTR() {
    return months[date.month].toString();
  }

  String currentDayTR() {
    return daysTR[date.weekday].toString();
  }
}
