import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/presentation/authpages/register/register_view_model.dart';
import 'package:social_media_app_demo/sources/buttons.dart';
import 'package:social_media_app_demo/sources/colors.dart';

class RegisterScreenView extends StatefulWidget {
  const RegisterScreenView({super.key});

  @override
  State<RegisterScreenView> createState() => _RegisterScreenViewState();
}

class _RegisterScreenViewState extends RegisterScreenViewModel {
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
                autovalidateMode: AutovalidateMode.always,
                key: formKey,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StreamBuilder<String?>(builder: (context, snapshot) {
                        return TextFormField(
                          validator: FormFieldValidator().isNotEmpty,
                          controller: emailTextEditingController,
                          decoration: InputDecoration(
                            suffixIconColor: ColorManager.primary,
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: ColorManager.red,
                                  width: 2.0,
                                )),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: ColorManager.red,
                                  width: 2.0,
                                )),
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
                              isPasswordVisibleController,
                          passwordTextEditingController:
                              passwordTextEditingController),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(password2,
                            style: Theme.of(context).textTheme.titleMedium),
                      ),
                      passwordInputWidget(
                          isPasswordVisibleController:
                              isPasswordVisible2Controller,
                          passwordTextEditingController:
                              password2TextEditingController),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: widthSizedButton(
                          color: ColorManager.primary,
                          text: signInText,
                          onPressed: () {
                            if (formKey.currentState?.validate() ?? false) {
                              register();
                            }
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
                                  textColor: ColorManager.white,
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
              validator: FormFieldValidator().isNotEmpty,
              controller: _passwordTextEditingController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: isVisible.data!,
              obscuringCharacter: "*",
              decoration: InputDecoration(
                suffixIconColor: ColorManager.primary,
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: ColorManager.red,
                      width: 2.0,
                    )),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: ColorManager.red,
                      width: 2.0,
                    )),
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

class FormFieldValidator {
  String? isNotEmpty(String? data) {
    return (data?.isNotEmpty ?? false) ? null : ValidateMessage._isNotEmpty;
  }
}

class ValidateMessage {
  static const String _isNotEmpty = "Bu alan boş geçilemez";
}
