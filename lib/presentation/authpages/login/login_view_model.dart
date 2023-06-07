import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_demo/auth/auth.dart';
import 'package:social_media_app_demo/config/extensions.dart';
import 'package:social_media_app_demo/presentation/authpages/login/login_view.dart';
import 'package:social_media_app_demo/sources/lang/locale_keys.g.dart';
import 'package:social_media_app_demo/sources/showalertdialog.dart';

abstract class LoginScreenViewModel extends State<LoginScreenView> {
  TextEditingController? emailTextEditingController = TextEditingController();
  TextEditingController? passwordTextEditingController =
      TextEditingController();
  String text = LocaleKeys.login_registerText;
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  changeIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  String title = LocaleKeys.login_welcome;
  String email = LocaleKeys.login_emailTitle;
  String password = LocaleKeys.login_passwordTitle;
  String loginText = LocaleKeys.login_loginText;
  String signInText = LocaleKeys.login_registerButtonText;

  String forgetPassword = LocaleKeys.login_forgetPassword;

  Future<void> login() async {
    changeIsLoading();
    final email = emailTextEditingController!.value.text;
    final password = passwordTextEditingController!.value.text;
    try {
      await Auth().signInWithEmailAndPassword(email, password);
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(LocaleKeys.login_loginsuccess.locale),
          duration: Duration(seconds: 1),
        ));
        Navigator.pushNamed(context, "/mainpage");
      } else {
        await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(LocaleKeys.login_emailVerifyError.locale),
          duration: Duration(seconds: 1),
        ));
        Auth().signOut(FirebaseAuth.instance.currentUser!.email.toString());
      }
    } on FirebaseAuthException catch (e) {
      showAlertDialog(e.message.toString(), context);
      passwordTextEditingController!.clear();
    }
    changeIsLoading();
  }

  Future<void> resetPassword() async {
    String? email = emailTextEditingController!.value.text;
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showAlertDialog(LocaleKeys.login_forgetPasswordSent.locale, context);
    } on FirebaseAuthException catch (e) {
      showAlertDialog(e.message.toString(), context);
    }
  }

  StreamController<bool> isPasswordVisibleController =
      StreamController<bool>.broadcast();

  @override
  void dispose() {
    passwordTextEditingController!.dispose();
    emailTextEditingController!.dispose();
    super.dispose();
  }
}
