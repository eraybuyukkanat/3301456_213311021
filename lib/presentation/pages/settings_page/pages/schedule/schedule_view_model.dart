import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:social_media_app_demo/config/database.dart';
import 'package:social_media_app_demo/config/extensions.dart';
import 'package:social_media_app_demo/presentation/pages/settings_page/pages/schedule/schedule_view.dart';
import 'package:social_media_app_demo/presentation/pages/settings_page/pages/schedule/lesson_model.dart';
import 'package:social_media_app_demo/sources/lang/locale_keys.g.dart';
import 'package:sqflite/sqflite.dart';

abstract class SchedulePageViewModel extends State<SchedulePageView> {
  DatabaseManager databaseManager = DatabaseManager();

  TextEditingController lessonNameEditingController = TextEditingController();
  TextEditingController lessonTimeEditingController = TextEditingController();
  TextEditingController lessonClassEditingController = TextEditingController();
  StreamController<List<Lesson>> streamController =
      StreamController<List<Lesson>>.broadcast();
  List<Lesson> lessonList = [];

  bool ekleniyoMu = false;
  void ekleniyor() async {
    ekleniyoMu = !ekleniyoMu;
    setState(() {});
  }

  Map days = {
    1: LocaleKeys.days_1.locale,
    2: LocaleKeys.days_2.locale,
    3: LocaleKeys.days_3.locale,
    4: LocaleKeys.days_4.locale,
    5: LocaleKeys.days_5.locale,
  };

  int? selectedValue;

  Future getLessonsList() async {
    lessonList = await databaseManager.getList();
    setState(() {});
  }

  Future<void> openDB() async {
    await databaseManager.getDB();
  }

  @override
  void initState() {
    openDB();
    super.initState();
    getLessonsList();
  }

  _bind() async {
    getLessonsList();
    streamController.sink.add(lessonList.toList());
  }

  Future<void> saveModel(Lesson lessonModel) async {
    final result = await databaseManager.insert(lessonModel);
    lessonNameEditingController.clear();
    selectedValue = null;
    lessonTimeEditingController.clear();
    lessonClassEditingController.clear();
    _bind();
  }

  Future<void> deleteModel(id) async {
    final result = await databaseManager.deleteItem(id);
    _bind();
  }
}
