import 'package:flutter/material.dart';
import 'package:social_media_app_demo/sources/colors.dart';

import '../presentation/main/mainpage.dart';

showAlertDialog(String? text, BuildContext? context) {
  Widget? okButton = TextButton(
    child: Text(
      "Tamam",
      style: TextStyle(color: ColorManager.primary),
    ),
    onPressed: () {
      Navigator.pop(context!);
    },
  );

  AlertDialog? alert = AlertDialog(
    title: Text("Bazı şeyler yolunda gitmedi..."),
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
