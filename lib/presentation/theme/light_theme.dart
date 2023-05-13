import 'package:flutter/material.dart';
import 'package:social_media_app_demo/sources/colors.dart';

class LightTheme {
  ThemeData theme = ThemeData(
      appBarTheme: AppBarTheme(
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(20)))),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: ColorManager.primary),
      textTheme: ThemeData.light().textTheme.copyWith(
          titleMedium: TextStyle(fontSize: 20, color: ColorManager.black)),
      buttonTheme: ButtonThemeData(
          colorScheme: ColorScheme.light(
              onPrimary: ColorManager.primary,
              onSecondary: ColorManager.redAccent)),
      scaffoldBackgroundColor: ColorManager.white);
}
