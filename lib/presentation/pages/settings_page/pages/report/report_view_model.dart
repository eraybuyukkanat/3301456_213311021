import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_demo/presentation/pages/settings_page/pages/report/report_view.dart';

abstract class ReportErrorViewModel extends State<ReportErrorView> {
  String pageTitle = "HATA BİLDİR";
  String title = "Hata Başlığı";
  String description = "Açıklama";
  String buttonText = "Hata Bildir";

  bool loading = false;
  TextEditingController? errorTitleTextEditingController =
      TextEditingController();
  TextEditingController? errorDescriptionTextEditingController =
      TextEditingController();

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
    String? _title = errorTitleTextEditingController!.value.text;
    String? _description = errorDescriptionTextEditingController!.value.text;
    setState(() => loading = true);

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

    errorDescriptionTextEditingController!.clear();
    errorTitleTextEditingController!.clear();
    setState(() => loading = false);
  }
}
