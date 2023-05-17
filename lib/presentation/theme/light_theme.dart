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
            //display
            displayLarge: TextStyle(
                fontSize: 18,
                color: ColorManager.black,
                fontWeight: FontWeight.w700),
            displayMedium: TextStyle(
                fontSize: 18,
                color: ColorManager.black,
                fontWeight: FontWeight.normal),
            displaySmall: TextStyle(
                fontSize: 18,
                color: ColorManager.black,
                fontWeight: FontWeight.w300),
            //body
            bodyLarge: TextStyle(
                fontSize: 18,
                color: ColorManager.black,
                fontWeight: FontWeight.w700),
            bodyMedium: TextStyle(
                fontSize: 18,
                color: ColorManager.black,
                fontWeight: FontWeight.normal),
            bodySmall: TextStyle(
                fontSize: 18,
                color: ColorManager.black,
                fontWeight: FontWeight.w300),
            //title
            titleLarge: TextStyle(
                fontSize: 18,
                color: ColorManager.black,
                fontWeight: FontWeight.bold),
            titleMedium: TextStyle(
                fontSize: 18,
                color: ColorManager.black,
                fontWeight: FontWeight.normal),
            titleSmall: TextStyle(
                fontSize: 18,
                color: ColorManager.black,
                fontWeight: FontWeight.w300),
          ),
      buttonTheme: ButtonThemeData(
          colorScheme: ColorScheme.light(
              onPrimary: ColorManager.primary, onSecondary: ColorManager.red)),
      scaffoldBackgroundColor: ColorManager.white);
}
