import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/presentation/pages/settings_page/pages/chngepasswd/chngepasswrd_view_model.dart';
import 'package:social_media_app_demo/sources/colors.dart';
import 'package:social_media_app_demo/sources/texts.dart';

import '../../../../../sources/customformfield.dart';

class ChangePasswdPageView extends StatefulWidget {
  const ChangePasswdPageView({super.key});

  @override
  State<ChangePasswdPageView> createState() => _ChangePasswdPageViewState();
}

class _ChangePasswdPageViewState extends ChangePasswdPageViewModel {
  @override
  Widget build(BuildContext context) {
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
          title: headlineMediumText(
            text: pageTitle,
            color: ColorManager.black,
            fontSize: 32,
          )),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    bodyMediumText(
                      text: field1Title,
                      fontSize: 18,
                      padding: EdgeInsets.symmetric(vertical: 5),
                    ),
                    chngePasswdFormField(
                        isPasswordVisibleController:
                            isPasswordVisibleController,
                        newpasswdTextEditingController:
                            newpasswdTextEditingController),
                    bodyMediumText(
                      text: field2Title,
                      fontSize: 18,
                      padding: EdgeInsets.only(top: 20, bottom: 5),
                    ),
                    chngePasswdFormField(
                        isPasswordVisibleController:
                            isPassword2VisibleController,
                        newpasswdTextEditingController:
                            newpasswd2TextEditingController),
                    Container(
                      padding: EdgeInsets.only(top: 20),
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
            ],
          ),
        )),
      ),
    );
  }
}
