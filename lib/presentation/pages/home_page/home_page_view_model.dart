import 'package:flutter/material.dart';
import 'package:social_media_app_demo/config/database.dart';
import 'package:social_media_app_demo/presentation/pages/home_page/home_page_view.dart';
import 'package:social_media_app_demo/presentation/pages/settings_page/pages/schedule/lesson_model.dart';
import 'package:social_media_app_demo/sources/date.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:url_launcher/url_launcher.dart';

class ImageModel {
  String image;

  ImageModel({
    required this.image,
  });
}

abstract class HomePageViewModel extends State<HomePageView>
    with TickerProviderStateMixin, projectDate {
  bool isLoading = false;
  changeIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  var url = Uri.parse("https://selcuk.edu.tr/");

  Future<void> launchLink(link) async {
    final Uri _url = Uri.parse(link);

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  List images = [];
  Future<void> getData() async {
    changeIsLoading();
    var res = await http.get(url);
    final body = res.body;
    final document = parser.parse(body);
    var response = document
        .getElementsByClassName("carousel-inner")[0]
        .getElementsByClassName("carousel-item")
        .forEach(
      (element) {
        setState(
          () {
            images.add(
              element.children[0].children[0].attributes["src"].toString(),
            );
          },
        );
      },
    );
    changeIsLoading();
  }

  DatabaseManager databaseManager = DatabaseManager();
  List<Lesson> lessonList = [];

  Future<void> getTodayList() async {
    lessonList = await databaseManager.getTodayList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
    getTodayList();
  }

  Map sosyalList = {
    0: "Topluluklar",
    1: "Sosyal Etkinlikler",
    2: "Yemekhane Menüsü",
  };

  String? appBarTitle = "SAYFAM";
  String? tabbarText1 = "ÜNİVERSİTE DUYURULARI";
  String? listViewTitle1 = "Sosyal";
  String? listViewTitle2 = "Ders";
  String emptyListLesson = "Bugün hiç dersin yok";
  PageController pageController = PageController();
  PageController lessonsPageController = PageController();

  @override
  void dispose() {
    super.dispose();
  }
}
