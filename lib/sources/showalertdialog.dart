import 'package:flutter/material.dart';
import 'package:social_media_app_demo/config/extensions.dart';
import 'package:social_media_app_demo/sources/colors.dart';
import 'package:social_media_app_demo/sources/lang/locale_keys.g.dart';

import '../presentation/main/mainpage.dart';

showAlertDialog(String? text, BuildContext? context) {
  Widget? okButton = TextButton(
    child: Text(
      LocaleKeys.showModelDialog_okText.locale,
      style: TextStyle(color: ColorManager.primary),
    ),
    onPressed: () {
      Navigator.pop(context!);
    },
  );

  AlertDialog? alert = AlertDialog(
    title: Text(LocaleKeys.showModelDialog_somethingWrong.locale),
    content: Text(text!),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context!,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
