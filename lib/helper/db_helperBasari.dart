import 'dart:async';
import 'dart:io' as io;
import 'package:iknow/basariModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelperBasari {
  static Database _db;

  static const String ID = 'id';
  static const String ACIKLAMA = "aciklama";
  static const String KATEGORI = "kategori";
  static const String TARIH = "tarih";
  static const String KAZANILDI = "kazanildi";

  static const String TABLE = "basari";
  static const String DB_NAME = 'sigara6.db';

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
        "CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY,$ACIKLAMA STRING,$KATEGORI STRING,$TARIH TARIH,$KAZANILDI STRING)");
  }

/////////////////////////////
///// CREATE TABLE savefor (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, adi STRING, aciklama STRING, fiyat INTEGER);
  /// SAVEFORS

  Future<BasariModel> saveBasari(BasariModel item) async {
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

  Future<List<BasariModel>> getBasari() async {
    var dbClient = await db;
    List<Map> maps = await dbClient
        .query(TABLE, columns: [ID, ACIKLAMA, KATEGORI, TARIH, KAZANILDI]);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<BasariModel> basariList = [];
    if (maps.length > 0) {
      // for (int i = 0; i < maps.length; i++) {
      //   workouts.add(WorkOut.fromMap(maps[i]));
      // }
      for (int i = maps.length - 1; i >= 0; i--) {
        basariList.add(BasariModel.fromMap(maps[i]));
      }
    }
    return basariList;
  }

  Future<List<BasariModel>> getLatestBasari() async {
    var dbClient = await db;
    List<Map> maps =
        await dbClient.query(TABLE, columns: [ID, ACIKLAMA, KATEGORI, TARIH]);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<BasariModel> basariList = [];
    if (maps.length > 0) {
      // for (int i = 0; i < maps.length; i++) {
      //   workouts.add(WorkOut.fromMap(maps[i]));
      // }
      for (int i = maps.length - 1; i >= 0; i--) {
        basariList.add(BasariModel.fromMap(maps[i]));
      }
    }
    return basariList;
  }

  Future<int> deleteBasari(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateBasari(BasariModel workouts) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, workouts.toMap(),
        where: '$ID = ?', whereArgs: [workouts.id]);
  }
}
