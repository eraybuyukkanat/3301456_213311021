import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chngepasswd_view.dart';

abstract class ChangePasswdPageViewModel extends State<ChangePasswdPageView> {
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
        const String? title = 'Şifre Değiştirme';
        String? okButton = 'Tamam';
        return AlertDialog(
          title: const Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(mesaj),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                okButton,
                style: Theme.of(context).textTheme.bodyLarge,
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
        String? message = "Şifre Değiştirildi";
        _showAlertDialog(message);
      } on FirebaseAuthException catch (e) {
        _showAlertDialog(e.message.toString());
      }
    } else {
      String? errorMessasge = "Şifreler aynı değil, değiştirilemedi";
      _showAlertDialog(errorMessasge);
    }

    newpasswd2TextEditingController!.clear();
    newpasswdTextEditingController!.clear();
  }
}
