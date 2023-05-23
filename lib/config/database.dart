import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:social_media_app_demo/presentation/pages/settings_page/pages/schedule/schedule_view.dart';
import 'package:social_media_app_demo/presentation/pages/settings_page/pages/schedule/lesson_model.dart';
import 'package:social_media_app_demo/sources/date.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager with projectDate {
  String userDatabaseName = "db_${FirebaseAuth.instance.currentUser!.uid}_db";
  String userTableName = "db_${FirebaseAuth.instance.currentUser!.uid}_lessons";

  String columnLessonName = "lessonName";
  String columnDay = "lessonDay";
  String columnTime = "lessonTime";
  String columnId = "id";
  String columnClass = "lessonClass";

  int version = 1;

  Future<Database> getDB() async {
    return openDatabase(join(await getDatabasesPath(), userDatabaseName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE $userTableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnLessonName VARCHAR(10), $columnDay VARCHAR(10), $columnTime VARCHAR(10), $columnClass VARCHAR(10))"),
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
        where: '$columnDay = ?', whereArgs: [currentDayTR()]);
    return userMaps.map((e) => Lesson.fromMap(e)).toList();
  }

  Future<List<Lesson>> getPazartesiList() async {
    final db = await getDB();
    List<Map> userMaps = await db.query(userTableName,
        where: '$columnDay = ?', whereArgs: ["Pazartesi"]);
    return userMaps.map((e) => Lesson.fromMap(e)).toList();
  }

  Future<List<Lesson>> getSaliList() async {
    final db = await getDB();
    List<Map> userMaps = await db
        .query(userTableName, where: '$columnDay = ?', whereArgs: ["Salı"]);
    return userMaps.map((e) => Lesson.fromMap(e)).toList();
  }

  Future<List<Lesson>> getCarsambaList() async {
    final db = await getDB();
    List<Map> userMaps = await db
        .query(userTableName, where: '$columnDay = ?', whereArgs: ["Çarşamba"]);
    return userMaps.map((e) => Lesson.fromMap(e)).toList();
  }

  Future<List<Lesson>> getPersembeList() async {
    final db = await getDB();
    List<Map> userMaps = await db
        .query(userTableName, where: '$columnDay = ?', whereArgs: ["Perşembe"]);
    return userMaps.map((e) => Lesson.fromMap(e)).toList();
  }

  Future<List<Lesson>> getCumaList() async {
    final db = await getDB();
    List<Map> userMaps = await db
        .query(userTableName, where: '$columnDay = ?', whereArgs: ["Cuma"]);
    return userMaps.map((e) => Lesson.fromMap(e)).toList();
  }

  Future<Lesson?> getItem(int id) async {
    final db = await getDB();
    final lessonMaps = await db.query(userTableName,
        where: '$columnId = ?', whereArgs: [id], columns: [columnId]);

    if (lessonMaps.isNotEmpty) {
      return Lesson.fromMap(lessonMaps.first);
    } else {
      return null;
    }
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
