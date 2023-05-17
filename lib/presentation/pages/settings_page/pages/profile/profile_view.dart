import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/presentation/pages/settings_page/pages/profile/profile_view_model.dart';
import 'package:social_media_app_demo/sources/buttons.dart';
import 'package:social_media_app_demo/sources/colors.dart';
import 'package:social_media_app_demo/sources/showalertdialog.dart';

import '../../../../main/mainpage.dart';

class ProfilePageView extends StatefulWidget {
  const ProfilePageView({super.key});

  @override
  State<ProfilePageView> createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends ProfilePageViewModel {
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
            return SingleChildScrollView(
                child: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: CircleAvatar(
                            radius: 75,
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
                    SizedBox(
                      height: 2.h,
                    ),
                    fieldWidget(
                      title: "Öğrenci Adı",
                      fieldText: FirebaseAuth.instance.currentUser!.displayName,
                      controller: displayNameController,
                      func: changeDisplayName,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    fieldWidget(
                      title: "Kullanıcı Adı",
                      fieldText: username,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    fieldWidget(
                      title: "Email",
                      fieldText: email,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    /* fieldWidget(
                      title: "Fakülte",
                      fieldText: faculty,
                      controller: emailController,
                      func: changeFaculty,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    fieldWidget(
                      title: "Bölüm",
                      fieldText: department,
                      controller: emailController,
                      func: changeDepartment,
                    )
                    */
                  ],
                ),
              ),
            ));
          }),
    );
  }
}

class fieldWidget extends StatelessWidget {
  const fieldWidget({
    Key? key,
    required this.title,
    required this.fieldText,
    this.func,
    this.controller,
  }) : super(key: key);

  final String? fieldText;
  final String? title;
  final Function? func;

  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(
          height: 1.h,
        ),
        Container(
          height: 6.h,
          width: double.maxFinite,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorManager.primary),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Text(
                    fieldText!,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: ColorManager.white, fontSize: 20),
                  ),
                ),
                title == "Email" || title == "Kullanıcı Adı"
                    ? SizedBox()
                    : IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(title!),
                                  content: TextFormField(
                                    controller: controller,
                                    decoration: InputDecoration(
                                        hintText: "${title} Giriniz..."),
                                  ),
                                  actions: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: widthSizedButton(
                                          text: "Kaydet",
                                          color: ColorManager.primary,
                                          onPressed: () {
                                            func!(context);
                                          }),
                                    ),
                                  ],
                                );
                              });
                        },
                        icon: Icon(Icons.edit_rounded),
                        color: ColorManager.white,
                      )
              ],
            ),
          ),
        )
      ],
    );
  }
}
