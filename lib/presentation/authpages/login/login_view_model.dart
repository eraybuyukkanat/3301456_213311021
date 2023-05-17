import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_demo/auth/auth.dart';
import 'package:social_media_app_demo/presentation/authpages/login/login_view.dart';
import 'package:social_media_app_demo/sources/showalertdialog.dart';

abstract class LoginScreenViewModel extends State<LoginScreenView> {
  TextEditingController? emailTextEditingController = TextEditingController();
  TextEditingController? passwordTextEditingController =
      TextEditingController();

  final formKey = GlobalKey<FormState>();

  String title = "Hoşgeldin!";
  String email = "E-mail ";
  String password = "Şifre";
  String loginText = "Giriş Yap";
  String signInText = "Kayıt Ol";
  String resetPasswordText = "Şifremi Unuttum";

  Future<void> login() async {
    final email = emailTextEditingController!.value.text;
    final password = passwordTextEditingController!.value.text;
    try {
      await Auth().signInWithEmailAndPassword(email, password);
      await ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Giriş başarılı, anasayfaya yönlendiriliyorsunuz"),
        duration: Duration(seconds: 1),
      ));
      Navigator.pushNamed(context, "/mainpage");
    } on FirebaseAuthException catch (e) {
      showAlertDialog(e.message.toString(), context);
      passwordTextEditingController!.clear();
    }
  }

  Future<void> resetPassword() async {
    String? email = emailTextEditingController!.value.text;
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showAlertDialog("Şifre değiştirme bağlantısı gönderildi!", context);
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
