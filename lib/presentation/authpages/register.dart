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
  TextEditingController? _password2TextEditingController =
      TextEditingController();

  Future<void> register() async {
    String? email = _emailTextEditingController!.value.text;
    String? password = _passwordTextEditingController!.value.text;
    String? password2 = _password2TextEditingController!.value.text;

    if (password == password2) {
      try {
        await ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Kayıt olma başarılı, anasayfaya yönlendiriliyorsunuz"),
          duration: Duration(seconds: 1),
        ));
        await Auth().registerWithEmailAndPassword(email, password);
        await FirebaseAuth.instance.currentUser
            ?.updateDisplayName(email.split('@')[0]);

        Navigator.pushNamed(context, "/mainpage");
      } on FirebaseAuthException catch (e) {
        showAlertDialog(e.message.toString(), context);
        _passwordTextEditingController!.clear();
      }
    } else {
      showAlertDialog("Şifreler aynı değil", context);
    }
  }

  StreamController<bool> _isPasswordVisibleController =
      StreamController<bool>.broadcast();
  StreamController<bool> _isPasswordVisible2Controller =
      StreamController<bool>.broadcast();

  @override
  void dispose() {
    _passwordTextEditingController!.dispose();
    _password2TextEditingController!.dispose();
    _emailTextEditingController!.dispose();
    super.dispose();
  }

  String title = "Hoşgeldin!";
  String email = "E-mail ";
  String password = "Şifre";
  String password2 = "Tekrar Şifre";
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  height: 2,
                  width: double.maxFinite,
                  color: ColorManager.third,
                ),
              ),
              Text(signInText,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(color: ColorManager.primary, fontSize: 25)),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child:
                    Text(email, style: Theme.of(context).textTheme.titleMedium),
              ),
              Form(
                key: _formKey,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(password,
                            style: Theme.of(context).textTheme.titleMedium),
                      ),
                      passwordInputWidget(
                          isPasswordVisibleController:
                              _isPasswordVisibleController,
                          passwordTextEditingController:
                              _passwordTextEditingController),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(password2,
                            style: Theme.of(context).textTheme.titleMedium),
                      ),
                      passwordInputWidget(
                          isPasswordVisibleController:
                              _isPasswordVisible2Controller,
                          passwordTextEditingController:
                              _password2TextEditingController),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: widthSizedButton(
                          color: ColorManager.primary,
                          text: signInText,
                          onPressed: () {
                            register();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Hesabınız varsa giriş yapın!",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                              ),
                            ),
                          ],
                        ),
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

class passwordInputWidget extends StatelessWidget {
  const passwordInputWidget({
    super.key,
    required StreamController<bool> isPasswordVisibleController,
    required TextEditingController? passwordTextEditingController,
  })  : _isPasswordVisibleController = isPasswordVisibleController,
        _passwordTextEditingController = passwordTextEditingController;

  final StreamController<bool> _isPasswordVisibleController;
  final TextEditingController? _passwordTextEditingController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        initialData: true,
        stream: _isPasswordVisibleController.stream,
        builder: (context, isVisible) {
          return StreamBuilder<String?>(builder: (context, snapshot) {
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
                    _isPasswordVisibleController.sink.add(!isVisible.data!);
                  },
                ),
              ),
            );
          });
        });
  }
}
