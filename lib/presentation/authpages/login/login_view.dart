import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/presentation/authpages/login/login_view_model.dart';
import 'package:social_media_app_demo/sources/buttons.dart';
import 'package:social_media_app_demo/sources/colors.dart';

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
                autovalidateMode: AutovalidateMode.always,
                key: formKey,
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
                          stream: isPasswordVisibleController.stream,
                          builder: (context, isVisible) {
                            return StreamBuilder<String?>(
                                builder: (context, snapshot) {
                              return TextFormField(
                                validator: FormFieldValidator().isNotEmpty,
                                controller: passwordTextEditingController,
                                keyboardType: TextInputType.visiblePassword,
                                obscuringCharacter: "*",
                                obscureText: isVisible.data!,
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
                                      isPasswordVisibleController.sink
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
                            forgetPassword,
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
                          onPressed: () {
                            if (formKey.currentState?.validate() ?? false) {
                              login();
                            }
                          }),
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
                                textColor: ColorManager.white,
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

class FormFieldValidator {
  String? isNotEmpty(String? data) {
    return (data?.isNotEmpty ?? false) ? null : ValidateMessage._isNotEmpty;
  }
}

class ValidateMessage {
  static const String _isNotEmpty = "Bu alan boş geçilemez";
}
