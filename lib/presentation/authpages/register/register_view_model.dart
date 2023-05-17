import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_demo/presentation/authpages/register/register_view.dart';

import '../../../auth/auth.dart';
import '../../../sources/showalertdialog.dart';

abstract class RegisterScreenViewModel extends State<RegisterScreenView> {
  final formKey = GlobalKey<FormState>();

  TextEditingController? emailTextEditingController = TextEditingController();
  TextEditingController? passwordTextEditingController =
      TextEditingController();
  TextEditingController? password2TextEditingController =
      TextEditingController();

  Future<void> register() async {
    String? email = emailTextEditingController!.value.text;
    String? password = passwordTextEditingController!.value.text;
    String? password2 = password2TextEditingController!.value.text;

    if (password == password2) {
      try {
        await Auth().registerWithEmailAndPassword(email, password);
        await ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Kayıt olma başarılı, anasayfaya yönlendiriliyorsunuz"),
          duration: Duration(seconds: 1),
        ));
        await FirebaseAuth.instance.currentUser
            ?.updateDisplayName(email.split('@')[0]);

        Navigator.pushNamed(context, "/mainpage");
      } on FirebaseAuthException catch (e) {
        showAlertDialog(e.message.toString(), context);
        passwordTextEditingController!.clear();
      }
    } else {
      showAlertDialog("Şifreler aynı değil", context);
    }
  }

  StreamController<bool> isPasswordVisibleController =
      StreamController<bool>.broadcast();
  StreamController<bool> isPasswordVisible2Controller =
      StreamController<bool>.broadcast();

  @override
  void dispose() {
    passwordTextEditingController!.dispose();
    password2TextEditingController!.dispose();
    emailTextEditingController!.dispose();
    super.dispose();
  }

  String title = "Hoşgeldin!";
  String email = "E-mail ";
  String password = "Şifre";
  String password2 = "Tekrar Şifre";
  String loginText = "Giriş Yap";
  String signInText = "Kayıt Ol";
  String resetPasswordText = "Şifremi Unuttum";
}
