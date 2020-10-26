import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../models/dailyModel.dart';

class DBHelperDaily {
  static Database _db;

  static const String ID = 'id';
  static const String DATE = 'tarih';
  static const String DETAY = "detay";
  static const String ICTIMI = "ictimi";
  static const String KACTANE = "kactane";
  static const String ZORLANMA = "zorlanma";
  static const String CRAVINGS = "cravings";
  static const String TABLE = "daily";
  static const String DB_NAME = 'sigara3.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE daily ($ID INTEGER PRIMARY KEY,$DATE STRING,$ICTIMI BOOL,$KACTANE INTEGER,$ZORLANMA INTEGER,$CRAVINGS INTEGER)");
  }

/////////////////////////////
///// CREATE TABLE savefor (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, adi STRING, aciklama STRING, fiyat INTEGER);
  /// SAVEFORS

  Future<DailyModel> saveDaily(DailyModel item) async {
    var dbClient = await db;
    item.id = await dbClient.insert("daily", item.toMap());
    return item;
    /*
    await dbClient.transaction((txn) async {
      var query = "INSERT INTO $TABLE ($NAME) VALUES ('" + employee.name + "')";
      return await txn.rawInsert(query);
    });
    */
  }

  Future<List<DailyModel>> getDailyBilgiler() async {
    var dbClient = await db;
    List<Map> maps = await dbClient
        .query(TABLE, columns: [ID, DATE, ICTIMI, KACTANE, ZORLANMA, CRAVINGS]);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<DailyModel> dailyList = [];
    if (maps.length > 0) {
      // for (int i = 0; i < maps.length; i++) {
      //   workouts.add(WorkOut.fromMap(maps[i]));
      // }
      for (int i = maps.length - 1; i >= 0; i--) {
        dailyList.add(DailyModel.fromMap(maps[i]));
      }
    }
    return dailyList;
  }

//only dates
  Future<List<DailyModel>> getOnlyDates() async {
    var dbClient = await db;
    List<Map> maps = await dbClient
        .query(TABLE, columns: [ID, DATE, ICTIMI, CRAVINGS, ZORLANMA, KACTANE]);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<DailyModel> dailyList = [];
    if (maps.length > 0) {
      // for (int i = 0; i < maps.length; i++) {
      //   workouts.add(WorkOut.fromMap(maps[i]));
      // }
      for (int i = maps.length - 1; i >= 0; i--) {
        dailyList.add(DailyModel.fromMap(maps[i]));
      }
    }
    return dailyList.toList();
  }

  Future<int> deleteDaily(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteDailyTable() async {
    var dbClient = await db;
    return await dbClient.delete(TABLE);
  }

  Future<int> updateDaily(DailyModel workouts) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, workouts.toMap(),
        where: '$ID = ?', whereArgs: [workouts.id]);
  }
}
