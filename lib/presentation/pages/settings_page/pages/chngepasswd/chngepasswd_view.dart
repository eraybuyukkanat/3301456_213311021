import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/presentation/pages/settings_page/pages/chngepasswd/chngepasswrd_view_model.dart';
import 'package:social_media_app_demo/sources/colors.dart';

import '../../../../../sources/customformfield.dart';

class ChangePasswdPageView extends StatefulWidget {
  const ChangePasswdPageView({super.key});

  @override
  State<ChangePasswdPageView> createState() => _ChangePasswdPageViewState();
}

class _ChangePasswdPageViewState extends ChangePasswdPageViewModel {
  @override
  Widget build(BuildContext context) {
    String? pageTitle = "Şifre Değiştir";
    String? field1Title = "Yeni Şifre";
    String? field2Title = "Yeni Şifre";
    String? buttonText = "Kaydet";
    String? infoText = "*Şifreler aynı ve 6 karakterden uzun olmalıdır";
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 3.h,
          elevation: 10,
          backgroundColor: ColorManager.white,
          toolbarHeight: 10.h,
          centerTitle: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: ColorManager.black,
            ),
          ),
          title: Text(
            pageTitle,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: ColorManager.black),
          )),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Form(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(field1Title,
                          style: Theme.of(context).textTheme.bodyMedium),
                      SizedBox(
                        height: 1.h,
                      ),
                      customFormField(
                          isPasswordVisibleController:
                              isPasswordVisibleController,
                          newpasswdTextEditingController:
                              newpasswdTextEditingController),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(field2Title,
                          style: Theme.of(context).textTheme.bodyMedium),
                      SizedBox(
                        height: 1.h,
                      ),
                      customFormField(
                          isPasswordVisibleController:
                              isPassword2VisibleController,
                          newpasswdTextEditingController:
                              newpasswd2TextEditingController),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.primary),
                          onPressed: () {
                            changepasswd();
                          },
                          child: Text(buttonText),
                        ),
                      ),
                      Text(infoText)
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
