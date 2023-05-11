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

  login() async {
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

  resetPassword() async {
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

  @override
  Widget build(BuildContext context) {
    String? title = "Hoşgeldin!";

    String? email = "E-mail ";
    String? password = "Şifre";
    String? loginText = "Giriş Yap";
    String? signInText = "Kayıt Ol";
    String? resetPasswordText = "Şifremi Unuttum";

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*SizedBox(
                  height: 25.h,
                  width: 80.w,
                  child: Lottie.asset("assets/json_assets/welcome.json")),
              */
              Text(
                title,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: ColorManager.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                height: 2,
                width: double.maxFinite,
                color: ColorManager.black,
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                loginText,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ColorManager.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 30),
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
                          style: Theme.of(context).textTheme.bodyMedium),
                      SizedBox(
                        height: 1.h,
                      ),
                      StreamBuilder<String?>(builder: (context, snapshot) {
                        return TextFormField(
                          controller: _emailTextEditingController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            suffixIcon: Icon(Icons.person_outline_outlined),
                            errorText: snapshot.data,
                          ),
                        );
                      }),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(password,
                          style: Theme.of(context).textTheme.bodyMedium),
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
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
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
                                color: ColorManager.grey,
                                text: signInText,
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
