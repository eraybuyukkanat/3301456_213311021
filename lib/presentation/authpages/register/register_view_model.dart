import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_demo/presentation/authpages/register/register_view.dart';

import '../../../auth/auth.dart';
import '../../../sources/showalertdialog.dart';

abstract class RegisterScreenViewModel extends State<RegisterScreenView> {
  final formKey = GlobalKey<FormState>();

  String text = "Hesabınız varsa giriş yapın!";

  bool isLoading = false;
  changeIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  TextEditingController? emailTextEditingController = TextEditingController();
  TextEditingController? passwordTextEditingController =
      TextEditingController();
  TextEditingController? password2TextEditingController =
      TextEditingController();

  Future<void> register() async {
    changeIsLoading();
    String? email = emailTextEditingController!.value.text;
    String? password = passwordTextEditingController!.value.text;
    String? password2 = password2TextEditingController!.value.text;

    if (password == password2) {
      try {
        await Auth().registerWithEmailAndPassword(email, password);
        await FirebaseAuth.instance.currentUser!.sendEmailVerification();
        await ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("DOĞRULA"),
          duration: Duration(seconds: 1),
        ));
        await FirebaseAuth.instance.currentUser
            ?.updateDisplayName(email.split('@')[0]);

        Navigator.pushNamed(context, "/loginpage");
      } on FirebaseAuthException catch (e) {
        showAlertDialog(e.message.toString(), context);
        passwordTextEditingController!.clear();
      }
    } else {
      showAlertDialog("Şifreler aynı değil", context);
    }
    changeIsLoading();
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
