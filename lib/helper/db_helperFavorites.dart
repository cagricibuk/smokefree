import 'dart:async';
import 'dart:io' as io;
import 'package:iknow/helper/saveForModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../tipsModel.dart';

class DBHelperFavorites {
  static Database _db;

  static const String ID = 'id';
  static const String ACIKLAMA = 'aciklama';
  static const String ISFAVORITE = 'isFavorite';
  static const String KATEGORI = 'kategori';
  static const String TABLE = 'favorites';
  static const String DB_NAME = 'sigara4.db';

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
        "CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY ,$ACIKLAMA STRING , $ISFAVORITE BOOL , $KATEGORI STRING)");
  }

/////////////////////////////
///// CREATE TABLE savefor (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, adi STRING, aciklama STRING, fiyat INTEGER);
  /// SAVEFORS

  Future<TipsModel> saveTips(TipsModel item) async {
    var dbClient = await db;
    item.id = await dbClient.insert(TABLE, item.toMap());
    return item;
    /*
    await dbClient.transaction((txn) async {
      var query = "INSERT INTO $TABLE ($NAME) VALUES ('" + employee.name + "')";
      return await txn.rawInsert(query);
    });
    */
  }

  Future<List<TipsModel>> getTipsBilgilerFavorites() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE,
        columns: [ID, ACIKLAMA, ISFAVORITE, KATEGORI],
        where: 'isFavorite = ?',
        whereArgs: ["true"]);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<TipsModel> tipslist = [];
    if (maps.length > 0) {
      // for (int i = 0; i < maps.length; i++) {
      //   workouts.add(WorkOut.fromMap(maps[i]));
      // }
      for (int i = maps.length - 1; i >= 0; i--) {
        tipslist.add(TipsModel.fromMap(maps[i]));
      }
    }
    return tipslist;
  }

  Future<List<TipsModel>> getTipsBilgilerA() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE,
        columns: [ID, ACIKLAMA, ISFAVORITE, KATEGORI],
        where: 'kategori = ?',
        whereArgs: ["a"]);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<TipsModel> tipslist = [];
    if (maps.length > 0) {
      // for (int i = 0; i < maps.length; i++) {
      //   workouts.add(WorkOut.fromMap(maps[i]));
      // }
      for (int i = maps.length - 1; i >= 0; i--) {
        tipslist.add(TipsModel.fromMap(maps[i]));
      }
    }
    return tipslist;
  }

  Future<List<TipsModel>> getTipsBilgilerB() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE,
        columns: [ID, ACIKLAMA, ISFAVORITE, KATEGORI],
        where: 'kategori = ?',
        whereArgs: ["b"]);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<TipsModel> tipslist = [];
    if (maps.length > 0) {
      // for (int i = 0; i < maps.length; i++) {
      //   workouts.add(WorkOut.fromMap(maps[i]));
      // }
      for (int i = maps.length - 1; i >= 0; i--) {
        tipslist.add(TipsModel.fromMap(maps[i]));
      }
    }
    return tipslist;
  }

  Future<int> deleteTips(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateTips(TipsModel workouts) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, workouts.toMap(),
        where: '$ID = ?', whereArgs: [workouts.id]);
  }
}
