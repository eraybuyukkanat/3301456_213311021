import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/presentation/authpages/login/login_view_model.dart';
import 'package:social_media_app_demo/sources/buttons.dart';
import 'package:social_media_app_demo/sources/colors.dart';
import 'package:social_media_app_demo/sources/customformfield.dart';
import 'package:social_media_app_demo/sources/texts.dart';

class LoginScreenView extends StatefulWidget {
  const LoginScreenView({super.key});

  @override
  State<LoginScreenView> createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends LoginScreenViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              titleLargeText(
                text: title,
                fontSize: 38,
                color: ColorManager.primary,
                padding: EdgeInsets.symmetric(vertical: 5),
              ),
              Container(
                height: 2,
                width: double.maxFinite,
                color: ColorManager.third,
              ),
              titleMediumText(
                text: loginText,
                fontSize: 25,
                color: ColorManager.primary,
                padding: EdgeInsets.symmetric(vertical: 5),
              ),
              Form(
                autovalidateMode: AutovalidateMode.always,
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleSmallText(
                      text: email,
                      fontSize: 17,
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                    ),
                    emailTextFormField(
                      titleTextEditingController: emailTextEditingController,
                      icon: Icon(Icons.person_outline_outlined),
                    ),
                    titleMediumText(
                      text: password,
                      fontSize: 18,
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                    ),
                    passwordTextFormField(
                        isPasswordVisibleController:
                            isPasswordVisibleController,
                        passwordTextEditingController:
                            passwordTextEditingController),
                    TextButton(
                        onPressed: () {
                          resetPassword();
                        },
                        child: bodyMediumText(
                          text: forgetPassword,
                          fontSize: 17,
                        )),
                    widthSizedButton(
                        color: ColorManager.primary,
                        text: loginText,
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            login();
                          }
                        }),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 30.w,
                            child: widthSizedButton(
                                color: ColorManager.primary,
                                text: signInText,
                                textColor: ColorManager.white,
                                onPressed: () {
                                  Navigator.pushNamed(context, "/registerpage");
                                }),
                          ),
                          bodySmallText(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            text: text,
                            fontSize: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
