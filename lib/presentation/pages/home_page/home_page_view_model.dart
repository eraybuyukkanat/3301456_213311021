import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_demo/config/database.dart';
import 'package:social_media_app_demo/config/extensions.dart';
import 'package:social_media_app_demo/presentation/pages/home_page/home_page_view.dart';
import 'package:social_media_app_demo/presentation/pages/settings_page/pages/schedule/lesson_model.dart';
import 'package:social_media_app_demo/sources/date.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:social_media_app_demo/sources/lang/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageModel {
  String image;

  ImageModel({
    required this.image,
  });
}

class HomePageViewModel extends ChangeNotifier {
  HomePageViewModel() {
    getTodayList();
    getData();
  }

  bool isLoading = false;
  changeIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
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
        if (element.children[0].children[0].attributes["src"]
            .toString()
            .startsWith("https")) {
          images.add(
            element.children[0].children[0].attributes["src"],
          );
        } else {
          images.add("https://selcuk.edu.tr/" +
              element.children[0].children[0].attributes["src"].toString());
        }
      },
    );
    changeIsLoading();
  }

  DatabaseManager databaseManager = DatabaseManager();
  List<Lesson> lessonList = [];

  Map days = {
    1: LocaleKeys.days_1.locale,
    2: LocaleKeys.days_2.locale,
    3: LocaleKeys.days_3.locale,
    4: LocaleKeys.days_4.locale,
    5: LocaleKeys.days_5.locale,
  };
  Future<void> getTodayList() async {
    lessonList = await databaseManager.getTodayList();
    notifyListeners();
  }

  Map sosyalList = {
    0: LocaleKeys.homepage_communitiesText,
    1: LocaleKeys.homepage_socialText,
    2: LocaleKeys.homepage_menuText,
  };

  String emptyListLesson = LocaleKeys.homepage_emptyLessonList;
  PageController pageController = PageController();
  PageController lessonsPageController = PageController();
}
