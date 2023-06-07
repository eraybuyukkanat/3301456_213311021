import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/config/extensions.dart';
import 'package:social_media_app_demo/presentation/pages/home_page/home_page_view.dart';
import 'package:social_media_app_demo/presentation/pages/settings_page/pages/report/report_view_model.dart';
import 'package:social_media_app_demo/sources/colors.dart';
import 'package:social_media_app_demo/sources/texts.dart';
import '../../../../../sources/showalertdialog.dart';
import '../../../../main/mainpage.dart';

class ReportErrorView extends StatefulWidget {
  const ReportErrorView({super.key});

  @override
  State<ReportErrorView> createState() => _ReportErrorViewState();
}

class _ReportErrorViewState extends ReportErrorViewModel {
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
              errorDescriptionTextEditingController!.clear();
              errorTitleTextEditingController!.clear();
            },
            icon: Icon(
              Icons.arrow_back,
              color: ColorManager.black,
            ),
          ),
          title: headlineMediumText(
            text: pageTitle,
            fontSize: 32,
            color: ColorManager.black,
          )),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            margin: const EdgeInsets.all(30),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      bodyMediumText(text: title, fontSize: 18),
                    ],
                  ),
                ),
                Form(
                  child: TextFormField(
                    decoration: InputDecoration(
                      suffixIconColor: ColorManager.primary,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
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
                    maxLength: 20,
                    controller: errorTitleTextEditingController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [bodyMediumText(text: description, fontSize: 18)],
                  ),
                ),
                Form(
                  child: TextFormField(
                    decoration: InputDecoration(
                      suffixIconColor: ColorManager.primary,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
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
                    maxLength: 200,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: errorDescriptionTextEditingController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 7.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primary),
                      onPressed: () {
                        reportError();
                      },
                      child: loading
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: ColorManager.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(buttonText.locale),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
