import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/config/constants.dart';
import 'package:social_media_app_demo/presentation/authpages/register/register_view_model.dart';
import 'package:social_media_app_demo/sources/buttons.dart';
import 'package:social_media_app_demo/sources/colors.dart';
import 'package:social_media_app_demo/sources/customformfield.dart';
import 'package:social_media_app_demo/sources/texts.dart';
import 'package:easy_localization/easy_localization.dart';

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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        print(context.locale.languageCode);
                        context.locale.languageCode == "tr"
                            ? context.setLocale(AppConstants.EN_LOCALE)
                            : context.setLocale(AppConstants.TR_LOCALE);
                      },
                      child: headlineMediumText(
                        text: context.locale.languageCode.toUpperCase(),
                        fontSize: 18,
                        color: ColorManager.black,
                      )),
                ],
              ),
              titleLargeText(
                text: title,
                fontSize: 58,
                color: ColorManager.black,
              ),
              titleMediumText(
                text: signInText,
                fontSize: 45,
                color: ColorManager.primary,
              ),
              Form(
                autovalidateMode: AutovalidateMode.always,
                key: formKey,
                child: Container(
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleSmallText(
                            text: email,
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            padding: EdgeInsets.only(top: 20, bottom: 10),
                          ),
                          emailTextFormField(
                            titleTextEditingController:
                                emailTextEditingController,
                            icon: Icon(Icons.person_outline_outlined),
                          ),
                          titleMediumText(
                            text: password,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            padding: EdgeInsets.symmetric(vertical: 10),
                          ),
                          passwordTextFormField(
                              isPasswordVisibleController:
                                  isPasswordVisibleController,
                              passwordTextEditingController:
                                  passwordTextEditingController),
                          titleMediumText(
                            text: password2,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            padding: EdgeInsets.symmetric(vertical: 10),
                          ),
                          passwordTextFormField(
                              isPasswordVisibleController:
                                  isPasswordVisible2Controller,
                              passwordTextEditingController:
                                  password2TextEditingController),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Container(
                              width: 50.w,
                              height: 8.h,
                              decoration: BoxDecoration(
                                color: ColorManager.primary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: widthSizedButton(
                                color: ColorManager.primary,
                                text: registerText,
                                onPressed: () {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    register();
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          bodySmallText(
                            text: login1Text,
                            fontSize: 18,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/loginpage");
                            },
                            child: bodySmallText(
                              text: login2Text,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.primary,
                              fontSize: 18,
                            ),
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
