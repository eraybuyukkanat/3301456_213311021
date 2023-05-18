import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/auth/auth.dart';

import 'package:social_media_app_demo/sources/buttons.dart';
import 'package:social_media_app_demo/sources/colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String pageTitle = "AYARLAR";
  String profileText = "PROFİLİM";
  String chngPsswdText = "ŞİFRE DEĞİŞTİR";
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
            pageTitle,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: ColorManager.black),
          )),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(
                  height: 1.h,
                ),
                Text("-  ${FirebaseAuth.instance.currentUser?.email}  -"),
                SizedBox(
                  height: 3.h,
                ),
                widthSizedButton(
                    color: ColorManager.primary,
                    text: profileText,
                    onPressed: () {
                      Navigator.pushNamed(context, "/profile");
                    }),
                SizedBox(
                  height: 3.h,
                ),
                widthSizedButton(
                    color: ColorManager.primary,
                    text: chngPsswdText,
                    onPressed: (() {
                      Navigator.pushNamed(context, "/changepassword");
                    })),
                SizedBox(
                  height: 3.h,
                ),
                widthSizedButton(
                    color: ColorManager.primary,
                    text: reportText,
                    onPressed: () {
                      Navigator.pushNamed(context, "/report");
                    }),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                  height: 8.h,
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      Auth().signOut(
                          FirebaseAuth.instance.currentUser!.email.toString());
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
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(ColorManager.red)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}