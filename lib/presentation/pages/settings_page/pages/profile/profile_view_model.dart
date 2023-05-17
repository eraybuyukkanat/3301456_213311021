import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_demo/presentation/pages/settings_page/pages/profile/profile_view.dart';

import '../../../../../sources/showalertdialog.dart';

abstract class ProfilePageViewModel extends State<ProfilePageView> {
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
  String? pageTitle = "PROFİLİM";
  String? src =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';
  String? name = "${FirebaseAuth.instance.currentUser?.displayName}";
  String? email = "${FirebaseAuth.instance.currentUser?.email.toString()}";
  String? username =
      "${FirebaseAuth.instance.currentUser!.email?.split('@').first}";
  String? faculty = "aa";
  String? department = "Bilgisayar Mühendisliği";
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser!.displayName == null
        ? setDisplayName()
        : _bind();
  }
}
