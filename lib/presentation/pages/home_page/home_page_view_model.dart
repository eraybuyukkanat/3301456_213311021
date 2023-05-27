import 'package:flutter/material.dart';
import 'package:social_media_app_demo/config/database.dart';
import 'package:social_media_app_demo/presentation/pages/home_page/home_page_view.dart';
import 'package:social_media_app_demo/presentation/pages/settings_page/pages/schedule/lesson_model.dart';
import 'package:social_media_app_demo/sources/date.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

abstract class HomePageViewModel extends State<HomePageView>
    with TickerProviderStateMixin, projectDate {
  bool isLoading = false;
  changeIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  var url = Uri.parse("https://selcuk.edu.tr/");
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
    2: "Bilimsel Etkinlikler",
    3: "Konserler"
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
