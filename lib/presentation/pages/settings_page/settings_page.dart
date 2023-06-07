import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/auth/auth.dart';
import 'package:social_media_app_demo/config/constants.dart';
import 'package:social_media_app_demo/config/extensions.dart';
import 'package:social_media_app_demo/presentation/pages/settings_page/settings_view_model.dart';

import 'package:social_media_app_demo/sources/buttons.dart';
import 'package:social_media_app_demo/sources/colors.dart';
import 'package:social_media_app_demo/sources/lang/locale_keys.g.dart';
import 'package:social_media_app_demo/sources/loading_bar.dart';
import 'package:social_media_app_demo/sources/texts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ProfilePageViewModel {
  String? src =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';
  String? pageTitle = LocaleKeys.settingsPage_appBarTitle;
  String chngPsswdText = LocaleKeys.settingsPage_chngePasswordTitle;
  String scheduleText = LocaleKeys.settingsPage_lessonsTitle;
  String calculatorText = LocaleKeys.settingsPage_calculateTitle;
  String reportText = LocaleKeys.settingsPage_reportTitle;

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
          actions: [
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(
                  Icons.logout,
                  size: 25,
                  color: ColorManager.red,
                ),
                onPressed: () {
                  Auth().signOut(
                      FirebaseAuth.instance.currentUser!.email.toString());
                  Navigator.pushNamed(context, "/loginpage");
                },
              ),
            )
          ],
          title: headlineMediumText(
            text: pageTitle!,
            color: ColorManager.black,
            fontSize: 32,
          )),
      body: StreamBuilder<FirebaseAuth>(
        stream: streamController.stream,
        builder: (context, snapshot) {
          if (isLoading) {
            return Center(child: loadingWidget());
          }
          return SingleChildScrollView(
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(
                      height: 1.h,
                    ),
                    profileInfo(context),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: widthSizedButton(
                          color: ColorManager.primary,
                          text: chngPsswdText,
                          onPressed: (() {
                            Navigator.pushNamed(context, "/changepassword");
                          })),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: widthSizedButton(
                          color: ColorManager.primary,
                          text: scheduleText,
                          onPressed: (() {
                            Navigator.pushNamed(context, "/schedulepage");
                          })),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: widthSizedButton(
                          color: ColorManager.primary,
                          text: calculatorText,
                          onPressed: (() {
                            Navigator.pushNamed(context, "/calculator");
                          })),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: widthSizedButton(
                          color: ColorManager.primary,
                          text: reportText,
                          onPressed: () {
                            Navigator.pushNamed(context, "/report");
                          }),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Container profileInfo(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              ColorManager.primary,
              ColorManager.gradient2,
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
        color: ColorManager.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      height: 200,
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      child: Text(
                        FirebaseAuth.instance.currentUser!.displayName
                            .toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: ColorManager.white),
                        maxLines: 2,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              String title =
                                  LocaleKeys.settingsPage_chngNameTitle.locale;
                              String hintText2 =
                                  LocaleKeys.settingsPage_chngNameHint.locale;
                              String saveButton =
                                  LocaleKeys.settingsPage_chngSaveButton.locale;
                              return AlertDialog(
                                title: Text(title.locale),
                                content: TextFormField(
                                  maxLength: 10,
                                  controller: displayNameController,
                                  decoration:
                                      InputDecoration(hintText: hintText2),
                                ),
                                actions: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: widthSizedButton(
                                        text: saveButton,
                                        color: ColorManager.primary,
                                        onPressed: () {
                                          Navigator.pop(context);
                                          changeDisplayName(context);
                                        }),
                                  ),
                                ],
                              );
                            });
                      },
                      icon: Icon(
                        Icons.edit,
                        color: ColorManager.white,
                      ),
                    ),
                  ],
                ),
                Container(
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: ColorManager.primary,
                    child: CircleAvatar(
                      radius: 75,
                      child: ClipOval(
                        child: Image.network(
                          src!,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Text(
              FirebaseAuth.instance.currentUser!.email.toString(),
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: ColorManager.white),
            ),
          ],
        ),
      ),
    );
  }
}
