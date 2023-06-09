import 'package:flutter/material.dart';
import 'package:social_media_app_demo/presentation/pages/home_page/communities/communities.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class CommunitiesViewModel extends ChangeNotifier {
  List<CommunityModel> communities = [];

  CommunitiesViewModel() {
    getDatas();
  }

  bool isLoading = false;
  changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  var url = Uri.parse(
      "https://www.selcuk.edu.tr/Birim/coordinatorships/ogrenci_topluluklari/2122/ogrenci-topluluklari-listesi/40110");

  Future<void> getDatas() async {
    changeLoading();
    var res = await http.get(url);
    final body = res.body;
    final document = parser.parse(body);
    var response = document
        .getElementsByClassName("col-sm-12 col-md-9 col-xl-9 pl-0")[0]
        .getElementsByClassName("col-12 p-4")[0]
        .getElementsByTagName("p")
        .forEach(
      (element) {
        element.text.trim().toString() != ""
            ? communities.add(CommunityModel(name: element.text.toString()))
            : null;
      },
    );
    changeLoading();
  }
}
