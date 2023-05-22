import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/auth/auth.dart';
import 'package:social_media_app_demo/presentation/pages/settings_page/settings_view_model.dart';

import 'package:social_media_app_demo/sources/buttons.dart';
import 'package:social_media_app_demo/sources/colors.dart';
import 'package:social_media_app_demo/sources/loading_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ProfilePageViewModel {
  String? src =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';
  String? pageTitle = "AYARLAR";
  String profileText = "PROFİLİM";
  String chngPsswdText = "ŞİFRE DEĞİŞTİR";
  String scheduleText = "DERS PROGRAMIM";
  String reportText = "HATA BİLDİR";
  String exitText = "Çıkış Yap";
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
          title: Text(
            pageTitle!,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: ColorManager.black),
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
                          text: reportText,
                          onPressed: () {
                            Navigator.pushNamed(context, "/report");
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        height: 8.h,
                        width: double.maxFinite,
                        child: ElevatedButton(
                          onPressed: () {
                            Auth().signOut(FirebaseAuth
                                .instance.currentUser!.email
                                .toString());
                            Navigator.pushNamed(context, "/loginpage");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(exitText),
                              SizedBox(
                                width: 2.w,
                              ),
                              Icon(Icons.exit_to_app),
                            ],
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  ColorManager.red)),
                        ),
                      ),
                    )
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
                              return AlertDialog(
                                title: Text("Öğrenci Adı"),
                                content: TextFormField(
                                  maxLength: 10,
                                  controller: displayNameController,
                                  decoration: InputDecoration(
                                      hintText: "Öğrenci Adınızı Giriniz..."),
                                ),
                                actions: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: widthSizedButton(
                                        text: "Kaydet",
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
