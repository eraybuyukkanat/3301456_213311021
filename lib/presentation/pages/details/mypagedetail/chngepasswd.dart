import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/presentation/main/mainpage.dart';
import 'package:social_media_app_demo/presentation/pages/details/mypagedetail/chngepasswd.dart';
import 'package:social_media_app_demo/sources/colors.dart';

import '../../../../auth/auth.dart';
import '../../../../sources/customformfield.dart';

class ChangePasswdPage extends StatefulWidget {
  const ChangePasswdPage({super.key});

  @override
  State<ChangePasswdPage> createState() => _ChangePasswdPageState();
}

class _ChangePasswdPageState extends State<ChangePasswdPage> {
  TextEditingController? _newpasswdTextEditingController =
      TextEditingController();
  TextEditingController? _newpasswd2TextEditingController =
      TextEditingController();

  StreamController<bool>? _isPasswordVisibleController =
      StreamController<bool>.broadcast();
  StreamController<bool>? _isPassword2VisibleController =
      StreamController<bool>.broadcast();
  @override
  void dispose() {
    _newpasswdTextEditingController!.dispose();
    _newpasswd2TextEditingController!.dispose();
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
    final newpasswd = _newpasswdTextEditingController!.value.text;
    final newpasswd2 = _newpasswd2TextEditingController!.value.text;

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

    _newpasswd2TextEditingController!.clear();
    _newpasswdTextEditingController!.clear();
  }

  @override
  Widget build(BuildContext context) {
    String? pageTitle = "Şifre Değiştir";
    String? field1Title = "Yeni Şifre";
    String? field2Title = "Yeni Şifre";
    String? buttonText = "Kaydet";
    String? infoText = "*Şifreler aynı ve 6 karakterden uzun olmalıdır";
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 3.h,
          elevation: 10,
          backgroundColor: ColorManager.white,
          toolbarHeight: 10.h,
          centerTitle: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: ColorManager.black,
            ),
          ),
          title: Text(
            pageTitle,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: ColorManager.black),
          )),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Form(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(field1Title,
                          style: Theme.of(context).textTheme.bodyMedium),
                      SizedBox(
                        height: 1.h,
                      ),
                      customFormField(
                          isPasswordVisibleController:
                              _isPasswordVisibleController,
                          newpasswdTextEditingController:
                              _newpasswdTextEditingController),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(field2Title,
                          style: Theme.of(context).textTheme.bodyMedium),
                      SizedBox(
                        height: 1.h,
                      ),
                      customFormField(
                          isPasswordVisibleController:
                              _isPassword2VisibleController,
                          newpasswdTextEditingController:
                              _newpasswd2TextEditingController),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.primary),
                          onPressed: () {
                            changepasswd();
                          },
                          child: Text(buttonText),
                        ),
                      ),
                      Text(infoText)
                    ],
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
