import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/presentation/pages/homepage.dart';
import 'package:social_media_app_demo/sources/colors.dart';
import '../../../../sources/showalertdialog.dart';
import '../../../main/mainpage.dart';

class ReportErrorPage extends StatefulWidget {
  const ReportErrorPage({super.key});

  @override
  State<ReportErrorPage> createState() => _ReportErrorPageState();
}

bool _loading = false;
TextEditingController? _errorTitleTextEditingController =
    TextEditingController();
TextEditingController? _errorDescriptionTextEditingController =
    TextEditingController();

class _ReportErrorPageState extends State<ReportErrorPage> {
  Future<void> _showAlertDialog(String mesaj) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        const String? title = 'Hata Bildir';
        String? okButton = 'Tamam';
        return AlertDialog(
          title: const Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(mesaj),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                okButton,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> reportError() async {
    String? _title = _errorTitleTextEditingController!.value.text;
    String? _description = _errorDescriptionTextEditingController!.value.text;
    setState(() => _loading = true);

    if (_title.isNotEmpty && _description.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection("hatabildir").add({
          'baslik': _title,
          'aciklama': _description,
        });
        _showAlertDialog("Hata bildirildi!");
      } on FirebaseException catch (e) {
        _showAlertDialog("Hata bildirilemedi!");
      }
    } else {
      _showAlertDialog("Başlık ve açıklamayı boş bırakamazsınız...");
    }

    _errorDescriptionTextEditingController!.clear();
    _errorTitleTextEditingController!.clear();
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    String? pageTitle = "HATA BİLDİR";
    String? title = "Hata Başlığı";
    String? description = "Açıklama";
    String? buttonText = "Hata Bildir";
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
              _errorDescriptionTextEditingController!.clear();
              _errorTitleTextEditingController!.clear();
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
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            margin: const EdgeInsets.all(30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Form(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    maxLength: 20,
                    controller: _errorTitleTextEditingController,
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Form(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    maxLength: 200,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: _errorDescriptionTextEditingController,
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.primary),
                    onPressed: () {
                      reportError();
                    },
                    child: _loading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: ColorManager.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(buttonText),
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
