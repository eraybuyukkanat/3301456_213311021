import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_demo/presentation/pages/settings_page/settings_page.dart';

import '../../../../../sources/showalertdialog.dart';

abstract class ProfilePageViewModel extends State<SettingsPage> {
  TextEditingController displayNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  StreamController<FirebaseAuth> streamController =
      StreamController<FirebaseAuth>.broadcast();

  _bind() async {
    changeLoading();
    streamController.sink.add(FirebaseAuth.instance);
    changeLoading();
  }

  bool isLoading = false;
  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> setDisplayName() async {
    await FirebaseAuth.instance.currentUser!.updateDisplayName(
        FirebaseAuth.instance.currentUser!.email?.split('@').first);
  }

  Future<void> changeDisplayName(context) async {
    changeLoading();
    try {
      await FirebaseAuth.instance.currentUser!
          .updateDisplayName(displayNameController.value.text);
    } on FirebaseAuthException catch (e) {
      showAlertDialog(e.message.toString(), context);
    }

    _bind();

    displayNameController.clear();
    changeLoading();
  }

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
