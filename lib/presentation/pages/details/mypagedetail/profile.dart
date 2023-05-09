import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/sources/buttons.dart';
import 'package:social_media_app_demo/sources/colors.dart';
import 'package:social_media_app_demo/sources/showalertdialog.dart';

import '../../../main/mainpage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

TextEditingController displayNameController = TextEditingController();
TextEditingController emailController = TextEditingController();
StreamController<FirebaseAuth> streamController =
    StreamController<FirebaseAuth>.broadcast();

bool isLoading = true;

_bind() async {
  streamController.sink.add(FirebaseAuth.instance);
}

setDisplayName() async {
  await FirebaseAuth.instance.currentUser!.updateDisplayName(
      FirebaseAuth.instance.currentUser!.email?.split('@').first);
}

changeDisplayName(context) async {
  print(isLoading);
  isLoading = false;
  print(isLoading);
  try {
    await FirebaseAuth.instance.currentUser!
        .updateDisplayName(displayNameController.value.text);
    _bind();
    Navigator.pop(context);
  } on FirebaseAuthException catch (e) {
    showAlertDialog(e.message.toString(), context);
  }
  print(isLoading);
  isLoading = true;
  print(isLoading);

  displayNameController.clear();
}

changeEmail(context) async {
  //düzeltcem
  try {
    await FirebaseAuth.instance.currentUser!
        .updateEmail(emailController.value.text);
    FirebaseAuth.instance.signOut();
    print("buraya girdi");
    Navigator.pushNamed(context, "/authpage");
  } on FirebaseAuthException catch (e) {
    showAlertDialog(e.message.toString(), context);
  }
  emailController.clear();
}

changeFaculty(context) {}

changeDepartment(context) {}

class _ProfilePageState extends State<ProfilePage> {
  String? pageTitle = "PROFİLİM";
  String? src =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';
  String? name = "${FirebaseAuth.instance.currentUser?.displayName}";
  String? email = "${FirebaseAuth.instance.currentUser?.email.toString()}";
  String? faculty = "aa";
  String? department = "Bilgisayar Mühendisliği";
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser!.displayName == null
        ? setDisplayName()
        : _bind();
  }

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
                      title: "Email",
                      fieldText: email,
                      controller: emailController,
                      func: changeEmail,
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
    required this.func,
    required this.controller,
  }) : super(key: key);

  final String? fieldText;
  final String? title;
  final Function func;

  final TextEditingController controller;
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
                title == "Email"
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
                                            func(context);
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
