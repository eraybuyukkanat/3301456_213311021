import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_demo/config/extensions.dart';
import 'package:social_media_app_demo/presentation/pages/settings_page/pages/report/report_view.dart';
import 'package:social_media_app_demo/sources/lang/locale_keys.g.dart';

abstract class ReportErrorViewModel extends State<ReportErrorView> {
  String pageTitle = LocaleKeys.reportPage_appBarTitle;
  String title = LocaleKeys.reportPage_reportTitle;
  String description = LocaleKeys.reportPage_reportDescription;
  String buttonText = LocaleKeys.reportPage_saveButton;

  bool loading = false;
  TextEditingController? errorTitleTextEditingController =
      TextEditingController();
  TextEditingController? errorDescriptionTextEditingController =
      TextEditingController();

  Future<void> _showAlertDialog(String mesaj) async {
    String? title = LocaleKeys.reportPage_appBarTitle.locale;
    String? okButton = LocaleKeys.showModelDialog_okText.locale;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
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
    String? _title = errorTitleTextEditingController!.value.text;
    String? _description = errorDescriptionTextEditingController!.value.text;
    setState(() => loading = true);

    if (_title.isNotEmpty && _description.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection("hatabildir").add({
          'baslik': _title,
          'aciklama': _description,
        });
        _showAlertDialog(LocaleKeys.reportPage_successMessage.locale);
      } on FirebaseException catch (e) {
        _showAlertDialog(LocaleKeys.reportPage_errorMessage.locale);
      }
    } else {
      _showAlertDialog(LocaleKeys.showModelDialog_emptyTitleDesc.locale);
    }

    errorDescriptionTextEditingController!.clear();
    errorTitleTextEditingController!.clear();
    setState(() => loading = false);
  }
}
