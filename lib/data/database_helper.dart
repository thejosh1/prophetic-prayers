import "dart:async";
import "package:path/path.dart";
import 'package:prophetic_prayers/utils/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../models/streak.dart';

final _streak = "streak";

class DatabaseHelper {
  //singleton
  static DatabaseHelper _databaseHelper = DatabaseHelper._createInstance();
  static Database? _database;

  DatabaseHelper._createInstance();
  factory DatabaseHelper() {
      return _databaseHelper;
  }

  Future<Database> initDatabase() async {
    var database = await openDatabase(
      join(await getDatabasesPath(), "streak.db"),
      //when the database is first created add data to the database
      onCreate: (db, version) {
        db.execute(
          """CREATE TABLE $_streak(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          streak INTEGER,
          lastRecordedDate INTEGER)
          """,
        );
      },
      version: 1,
    );
    return database;
  }

  Future<Streak> _getStreak(int id) async {
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
        _getStreak(id);
      }
    }
  }

  void _resetStreakCount(int StreakId) async {
    final Database? _db = await _database;

    Streak existingStreak = await _getStreak(StreakId);
    existingStreak.streak = 0;

    //can return the number of rows updated
    _db!.update(_streak, existingStreak.toMap(),
      where: "id = ?", whereArgs: [StreakId]
    );

    Streak _existingStreak = await _getStreak(StreakId);
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