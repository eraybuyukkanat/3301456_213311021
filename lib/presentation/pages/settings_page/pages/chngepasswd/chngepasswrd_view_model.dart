import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_demo/config/extensions.dart';
import 'package:social_media_app_demo/sources/lang/locale_keys.g.dart';
import 'package:social_media_app_demo/sources/texts.dart';

import 'chngepasswd_view.dart';

abstract class ChangePasswdPageViewModel extends State<ChangePasswdPageView> {
  String pageTitle = LocaleKeys.changePasswordPage_appBarTitle;
  String field1Title = LocaleKeys.changePasswordPage_newPasswordTitle;
  String field2Title = LocaleKeys.changePasswordPage_newPasswordTitle;
  String buttonText = LocaleKeys.changePasswordPage_saveButton;
  String infoText = LocaleKeys.changePasswordPage_warningText;

  TextEditingController? newpasswdTextEditingController =
      TextEditingController();
  TextEditingController? newpasswd2TextEditingController =
      TextEditingController();

  StreamController<bool>? isPasswordVisibleController =
      StreamController<bool>.broadcast();
  StreamController<bool>? isPassword2VisibleController =
      StreamController<bool>.broadcast();
  @override
  void dispose() {
    newpasswdTextEditingController!.dispose();
    newpasswd2TextEditingController!.dispose();
    super.dispose();
  }

  Future<void> _showAlertDialog(String mesaj) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.changePasswordPage_errorTitle.locale),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(mesaj),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: bodyLargeText(
                text: LocaleKeys.changePasswordPage_errorOKButton,
                fontSize: 18,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  changepasswd() async {
    final newpasswd = newpasswdTextEditingController!.value.text;
    final newpasswd2 = newpasswd2TextEditingController!.value.text;

    if (newpasswd == newpasswd2) {
      try {
        await FirebaseAuth.instance.currentUser?.updatePassword(newpasswd2);
        String? message = LocaleKeys.changePasswordPage_okPasswordText.locale;
        _showAlertDialog(message);
      } on FirebaseAuthException catch (e) {
        _showAlertDialog(e.message.toString());
      }
    } else {
      String? errorMessasge =
          LocaleKeys.changePasswordPage_errorPasswordText.locale;
      _showAlertDialog(errorMessasge);
    }

    newpasswd2TextEditingController!.clear();
    newpasswdTextEditingController!.clear();
  }
}
