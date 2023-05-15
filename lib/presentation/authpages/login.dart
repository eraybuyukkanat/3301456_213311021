import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:social_media_app_demo/auth/auth.dart';
import 'dart:async';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/presentation/main/mainpage.dart';
import 'package:social_media_app_demo/presentation/pages/details/mypagedetail/profile.dart';
import 'package:social_media_app_demo/sources/buttons.dart';
import 'package:social_media_app_demo/sources/colors.dart';
import 'package:social_media_app_demo/sources/showalertdialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController? _emailTextEditingController = TextEditingController();
  TextEditingController? _passwordTextEditingController =
      TextEditingController();

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) return;
    final email = _emailTextEditingController!.value.text;
    final password = _passwordTextEditingController!.value.text;
    try {
      await Auth().signInWithEmailAndPassword(email, password);
      Navigator.pushNamed(context, "/mainpage");
    } on FirebaseAuthException catch (e) {
      showAlertDialog(e.message.toString(), context);
      _passwordTextEditingController!.clear();
    }
  }

  Future<void> resetPassword() async {
    String? email = _emailTextEditingController!.value.text;
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showAlertDialog("Şifre değiştirme bağlantısı gönderildi!", context);
    } on FirebaseAuthException catch (e) {
      showAlertDialog(e.message.toString(), context);
    }
  }

  StreamController<bool> _isPasswordVisibleController =
      StreamController<bool>.broadcast();

  @override
  void dispose() {
    _passwordTextEditingController!.dispose();
    _emailTextEditingController!.dispose();
    super.dispose();
  }

  String title = "Hoşgeldin!";
  String email = "E-mail ";
  String password = "Şifre";
  String loginText = "Giriş Yap";
  String signInText = "Kayıt Ol";
  String resetPasswordText = "Şifremi Unuttum";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(fontSize: 38, color: ColorManager.primary)),
              SizedBox(
                height: 1.h,
              ),
              Container(
                height: 2,
                width: double.maxFinite,
                color: ColorManager.third,
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                loginText,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: ColorManager.primary, fontSize: 25),
              ),
              SizedBox(
                height: 5.h,
              ),
              Form(
                key: _formKey,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(email,
                          style: Theme.of(context).textTheme.titleMedium),
                      SizedBox(
                        height: 1.h,
                      ),
                      StreamBuilder<String?>(builder: (context, snapshot) {
                        return TextFormField(
                          controller: _emailTextEditingController,
                          decoration: InputDecoration(
                            suffixIconColor: ColorManager.primary,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: ColorManager.third,
                                  width: 2.0,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: ColorManager.primary,
                                  width: 2.0,
                                )),
                            suffixIcon: Icon(Icons.person_outline_outlined),
                            errorText: snapshot.data,
                          ),
                        );
                      }),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(password,
                          style: Theme.of(context).textTheme.titleMedium),
                      SizedBox(
                        height: 1.h,
                      ),
                      StreamBuilder<bool>(
                          initialData: true,
                          stream: _isPasswordVisibleController.stream,
                          builder: (context, isVisible) {
                            return StreamBuilder<String?>(
                                builder: (context, snapshot) {
                              return TextFormField(
                                controller: _passwordTextEditingController,
                                keyboardType: TextInputType.visiblePassword,
                                obscuringCharacter: "*",
                                obscureText: isVisible.data!,
                                decoration: InputDecoration(
                                  suffixIconColor: ColorManager.primary,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        color: ColorManager.third,
                                        width: 2.0,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        color: ColorManager.primary,
                                        width: 2.0,
                                      )),
                                  errorText: snapshot.data,
                                  suffixIcon: IconButton(
                                    icon: isVisible.data!
                                        ? Icon(Icons.visibility)
                                        : Icon(Icons.visibility_off),
                                    onPressed: () {
                                      _isPasswordVisibleController.sink
                                          .add(!isVisible.data!);
                                    },
                                  ),
                                ),
                              );
                            });
                          }),
                      TextButton(
                          onPressed: () {
                            resetPassword();
                          },
                          child: Text(
                            "Şifrenizi mi unuttunuz?",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.black),
                          )),
                      SizedBox(
                        height: 3.h,
                      ),
                      widthSizedButton(
                          color: ColorManager.primary,
                          text: loginText,
                          onPressed: login),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 40.w,
                            child: widthSizedButton(
                                color: ColorManager.third,
                                text: signInText,
                                textColor: ColorManager.black,
                                onPressed: () {
                                  Navigator.pushNamed(context, "/registerpage");
                                }),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(
                            "Hesabınız yoksa kayıt olun!",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
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
