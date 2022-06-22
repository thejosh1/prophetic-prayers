import "dart:async";
import 'dart:io';
import "package:path/path.dart";
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';

import '../models/streak.dart';

final _streak = "streak";

class DatabaseHelper {
  //singleton
  DatabaseHelper._privateContructor();
  static final DatabaseHelper instance = DatabaseHelper._privateContructor();


  static Database? _database;
  Future<Database> get database async => _database ??= await initDatabase();


  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "streak.db");
    return await openDatabase(
        path,
      version: 1,
      onCreate: _onCreate
    );
  }
  Future _onCreate (Database db, int version) async {
    await db.execute(
      """CREATE TABLE $_streak(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          streak INTEGER,
          lastRecordedDate INTEGER)
      """,);
  }

  Future<Streak> getStreak(int id) async {
    final Database? _db = await _database;

    final List<Map<String, dynamic>> map = await _db!.query(_streak, where: "id = ?", whereArgs: [id], limit: 1);

    return Streak(
        id: map[0]['id'],
        streak: map[0]["streak"],
        lastRecordedDate: DateTime.fromMillisecondsSinceEpoch(map[0]['lastRecordedDate'])
    );

  }

  Future<void> checkStreak() async {
    final Database? _db = await _database;

    final List<Map<String, dynamic>> maps = await _db!.query(_streak);

    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day-1);

    for(Map<String, dynamic> map in maps) {
      DateTime lastDate = DateTime.fromMillisecondsSinceEpoch(map['lastRecordedDate']);

      if (lastDate.isBefore(yesterday)) {
        int id = map['id'];
        _resetStreakCount(id);
      } else {
        int id = map['id'];
        getStreak(id);
      }
    }
  }

  void _resetStreakCount(int StreakId) async {
    final Database? _db = await _database;

    Streak existingStreak = await getStreak(StreakId);
    existingStreak.streak = 0;

    //can return the number of rows updated
    _db!.update(_streak, existingStreak.toMap(),
      where: "id = ?", whereArgs: [StreakId]
    );

    Streak _existingStreak = await getStreak(StreakId);
    existingStreak.streak = 0;

    _db.update(_streak, existingStreak.toMap(),
      where: "id = ? ", whereArgs: [StreakId]
    );
  }


  void updateStreak(Streak streak) async {
    final Database? _db = await _database;

    streak.lastRecordedDate = DateTime.now();
    
    _db!.update(_streak, streak.toMap(),
      where: "id = ? ", whereArgs: [streak.id]
    );
  }
}