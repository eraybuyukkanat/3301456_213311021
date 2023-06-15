import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:social_media_app_demo/presentation/pages/settings_page/pages/schedule/schedule_view.dart';
import 'package:social_media_app_demo/presentation/pages/settings_page/pages/schedule/lesson_model.dart';
import 'package:social_media_app_demo/sources/date.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager with projectDate {
  String userDatabaseName = "db_${FirebaseAuth.instance.currentUser!.uid}_db";
  String userTableName = "db_${FirebaseAuth.instance.currentUser!.uid}_lessons";

  String columnLessonName = "lessonName";
  String columnWeekDay = "lessonWeekDay";
  String columnTime = "lessonTime";
  String columnId = "id";
  String columnClass = "lessonClass";

  int version = 1;

  Future<Database> getDB() async {
    return openDatabase(join(await getDatabasesPath(), userDatabaseName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE $userTableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnLessonName VARCHAR(10), $columnWeekDay INTEGER, $columnTime VARCHAR(10), $columnClass VARCHAR(10))"),
        version: version);
  }

  Future<List<Lesson>> getList() async {
    final db = await getDB();
    List<Map> userMaps = await db.query(userTableName);
    return userMaps.map((e) => Lesson.fromMap(e)).toList();
  }

  Future<List<Lesson>> getTodayList() async {
    final db = await getDB();
    List<Map> userMaps = await db.query(userTableName,
        where: '$columnWeekDay = ?', whereArgs: [currentWeekDay()]);
    return userMaps.map((e) => Lesson.fromMap(e)).toList();
  }

  Future<void> insert(Lesson lesson) async {
    final db = await getDB();
    await db.insert(userTableName, lesson.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<bool> deleteItem(int id) async {
    final db = await getDB();
    final lessonMaps =
        await db.delete(userTableName, where: '$columnId = ?', whereArgs: [id]);

    return lessonMaps != null;
  }

  Future<void> close() async {
    final db = await getDB();
    await db.close();
  }
}
