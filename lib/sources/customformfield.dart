import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
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

class addCommentFormFieldWidget extends StatelessWidget {
  const addCommentFormFieldWidget({
    super.key,
    required this.commentTextEditingController,
  });

  final TextEditingController commentTextEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      child: TextFormField(
        maxLength: 100,
        controller: commentTextEditingController,
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(),
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
        ),
      ),
    );
  }
}

class editPostTitleFormField extends StatelessWidget {
  const editPostTitleFormField({
    super.key,
    required this.postEditTitleTextEditingController,
  });

  final TextEditingController? postEditTitleTextEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 20,
      style: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(color: ColorManager.white, fontSize: 17),
      decoration: InputDecoration(
        counterText: "",
        contentPadding: EdgeInsets.all(10),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: ColorManager.white,
          width: 2.0,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: ColorManager.primary,
          width: 2.0,
        )),
      ),
      controller: postEditTitleTextEditingController,
    );
  }
}

class editPostDescriptionFormField extends StatelessWidget {
  const editPostDescriptionFormField({
    super.key,
    required this.postEditDescriptionTextEditingController,
  });

  final TextEditingController? postEditDescriptionTextEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(color: ColorManager.black, fontSize: 18),
      validator: FormFieldValidator().isNotEmpty,
      decoration: InputDecoration(
        counterText: "",
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: ColorManager.primary,
          width: 2.0,
        )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: ColorManager.red,
              width: 2.0,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.transparent,
          width: 2.0,
        )),
      ),
      maxLength: 200,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: postEditDescriptionTextEditingController,
    );
  }
}

class postTitleInputFormField extends StatelessWidget {
  const postTitleInputFormField({
    super.key,
    required this.postTitleTextEditingController,
  });

  final TextEditingController? postTitleTextEditingController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(builder: (context, snapshot) {
      String? hintText1 = 'Gönderi başlığı giriniz...';
      return TextFormField(
        decoration: InputDecoration(
          counterText: "",
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
        ),
        controller: postTitleTextEditingController,
        maxLength: 20,
      );
    });
  }
}

class postDescriptionInputFormField extends StatelessWidget {
  const postDescriptionInputFormField({
    super.key,
    required this.scrollController,
    required this.postDescriptionTextEditingController,
  });

  final ScrollController scrollController;
  final TextEditingController? postDescriptionTextEditingController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(builder: (context, snapshot) {
      String? hintText2 = 'Gönderi açıklaması giriniz...';
      return Container(
        constraints: BoxConstraints(maxHeight: 150),
        child: Scrollbar(
          thickness: 10,
          radius: Radius.circular(20),
          controller: scrollController,
          thumbVisibility: true,
          child: TextFormField(
            decoration: InputDecoration(
              counterText: "",
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
            ),
            keyboardType: TextInputType.multiline,
            maxLength: 300,
            maxLines: 10,
            scrollController: scrollController,
            controller: postDescriptionTextEditingController,
          ),
        ),
      );
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
