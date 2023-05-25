import 'dart:async';

import 'package:flutter/material.dart';
import 'package:social_media_app_demo/sources/colors.dart';

class chngePasswdFormField extends StatelessWidget {
  const chngePasswdFormField({
    Key? key,
    required StreamController<bool>? isPasswordVisibleController,
    required TextEditingController? newpasswdTextEditingController,
  })  : _isPasswordVisibleController = isPasswordVisibleController,
        _newpasswdTextEditingController = newpasswdTextEditingController,
        super(key: key);

  final StreamController<bool>? _isPasswordVisibleController;
  final TextEditingController? _newpasswdTextEditingController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        initialData: true,
        stream: _isPasswordVisibleController!.stream,
        builder: (context, isVisible) {
          return StreamBuilder<String?>(builder: (context, snapshot) {
            return TextFormField(
              controller: _newpasswdTextEditingController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: isVisible.data!,
              decoration: InputDecoration(
                suffixIconColor: ColorManager.primary,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                errorText: snapshot.data,
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
                suffixIcon: IconButton(
                  icon: isVisible.data!
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                  onPressed: () {
                    _isPasswordVisibleController!.sink.add(!isVisible.data!);
                  },
                ),
              ),
            );
          });
        });
  }
}

class emailTextFormField extends StatelessWidget {
  emailTextFormField(
      {super.key, required this.titleTextEditingController, this.icon});

  final TextEditingController? titleTextEditingController;
  Icon? icon;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(builder: (context, snapshot) {
      return TextFormField(
        validator: FormFieldValidator().isNotEmpty,
        controller: titleTextEditingController,
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
          suffixIcon: icon ?? SizedBox(),
          errorText: snapshot.data,
        ),
      );
    });
  }
}

class passwordTextFormField extends StatelessWidget {
  const passwordTextFormField({
    super.key,
    required this.isPasswordVisibleController,
    required this.passwordTextEditingController,
  });

  final StreamController<bool> isPasswordVisibleController;
  final TextEditingController? passwordTextEditingController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        initialData: true,
        stream: isPasswordVisibleController.stream,
        builder: (context, isVisible) {
          return StreamBuilder<String?>(builder: (context, snapshot) {
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
                    isPasswordVisibleController.sink.add(!isVisible.data!);
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
