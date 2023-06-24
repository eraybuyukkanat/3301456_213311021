import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/cache/shared_manager.dart';
import 'package:social_media_app_demo/config/constants.dart';
import 'package:social_media_app_demo/config/extensions.dart';
import 'package:social_media_app_demo/presentation/authpages/login/login_view_model.dart';
import 'package:social_media_app_demo/sources/buttons.dart';
import 'package:social_media_app_demo/sources/colors.dart';
import 'package:social_media_app_demo/sources/customformfield.dart';
import 'package:social_media_app_demo/sources/loading_bar.dart';
import 'package:social_media_app_demo/sources/texts.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginScreenView extends StatefulWidget {
  const LoginScreenView({super.key});

  @override
  State<LoginScreenView> createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends LoginScreenViewModel {
  SharedManager sharedManager = SharedManager();
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
                  text: loginText, fontSize: 45, color: ColorManager.primary),
              Form(
                autovalidateMode: AutovalidateMode.always,
                key: formKey,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        titleSmallText(
                          text: email,
                          fontSize: 18,
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
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 8.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                            color: ColorManager.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: isLoading
                              ? loadingWidget(
                                  color: ColorManager.white,
                                )
                              : TextButton(
                                  onPressed: () {
                                    if (formKey.currentState?.validate() ??
                                        false) {
                                      login();
                                    }
                                  },
                                  child: Text(
                                    loginText.locale,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: ColorManager.white,
                                        ),
                                  )),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          bodySmallText(
                            text: register1Text,
                            fontSize: 18,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/registerpage");
                            },
                            child: bodySmallText(
                              text: register2Text,
                              color: ColorManager.primary,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
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
