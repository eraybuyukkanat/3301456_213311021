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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  titleLargeText(
                    text: title,
                    fontSize: 38,
                    color: ColorManager.primary,
                    padding: EdgeInsets.symmetric(vertical: 5),
                  ),
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
              Container(
                height: 2,
                width: double.maxFinite,
                color: ColorManager.third,
              ),
              titleMediumText(
                text: signInText,
                fontSize: 25,
                color: ColorManager.primary,
                padding: EdgeInsets.symmetric(vertical: 5),
              ),
              Form(
                autovalidateMode: AutovalidateMode.always,
                key: formKey,
                child: Container(
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
                        padding: EdgeInsets.symmetric(vertical: 10),
                      ),
                      passwordTextFormField(
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
                              width: 30.w,
                              child: widthSizedButton(
                                  color: ColorManager.primary,
                                  text: loginText,
                                  textColor: ColorManager.white,
                                  onPressed: () {
                                    Navigator.pushNamed(context, "/loginpage");
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
              ),
            ],
          ),
        )),
      ),
    );
  }
}
