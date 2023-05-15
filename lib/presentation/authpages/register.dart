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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController? _emailTextEditingController = TextEditingController();
  TextEditingController? _passwordTextEditingController =
      TextEditingController();

  register() async {
    String? email = _emailTextEditingController!.value.text;
    String? password = _passwordTextEditingController!.value.text;
    try {
      await Auth().registerWithEmailAndPassword(email, password);
      FirebaseAuth.instance.currentUser?.updateDisplayName(email.split('@')[0]);
      Navigator.pushNamed(context, "/loginpage");
    } on FirebaseAuthException catch (e) {
      showAlertDialog(e.message.toString(), context);
      _passwordTextEditingController!.clear();
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
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(fontSize: 38, color: ColorManager.primary),
              ),
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
              Text(signInText,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(color: ColorManager.primary, fontSize: 25)),
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
                                obscureText: isVisible.data!,
                                obscuringCharacter: "*",
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
                      SizedBox(
                        height: 3.h,
                      ),
                      widthSizedButton(
                          color: ColorManager.primary,
                          text: signInText,
                          onPressed: register),
                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 40.w,
                            child: widthSizedButton(
                                color: ColorManager.third,
                                text: loginText,
                                textColor: ColorManager.black,
                                onPressed: () {
                                  Navigator.pushNamed(context, "/loginpage");
                                }),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(
                            "Hesabınız varsa giriş yapın!",
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
