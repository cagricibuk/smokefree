import 'dart:async';
import 'dart:io' as io;
import 'package:iknow/helper/saveForModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelperSF {
  static Database _db;

  static const String ID = 'id';
  static const String AD = 'adi';
  static const String ACIKLAMA = 'aciklama';

  static const String FIYAT = 'fiyat';

  static const String TABLE = 'savefor';
  static const String DB_NAME = 'sigara2.db';

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
        "CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY , $AD STRING, $ACIKLAMA STRING , $FIYAT INTEGER)");
  }

/////////////////////////////
///// CREATE TABLE savefor (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, adi STRING, aciklama STRING, fiyat INTEGER);
  /// SAVEFORS

  Future<SaveForModel> saveSaveFors(SaveForModel item) async {
    var dbClient = await db;
    item.id = await dbClient.insert("savefor", item.toMap());
    return item;
    /*
    await dbClient.transaction((txn) async {
      var query = "INSERT INTO $TABLE ($NAME) VALUES ('" + employee.name + "')";
      return await txn.rawInsert(query);
    });
    */
  }

  Future<List<SaveForModel>> getSaveForBilgiler() async {
    var dbClient = await db;
    List<Map> maps =
        await dbClient.query("savefor", columns: [ID, AD, ACIKLAMA, FIYAT]);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<SaveForModel> saveforlist = [];
    if (maps.length > 0) {
      // for (int i = 0; i < maps.length; i++) {
      //   workouts.add(WorkOut.fromMap(maps[i]));
      // }
      for (int i = maps.length - 1; i >= 0; i--) {
        saveforlist.add(SaveForModel.fromMap(maps[i]));
      }
    }
    return saveforlist;
  }

  Future<int> deleteSaveFor(int id) async {
    var dbClient = await db;
    return await dbClient.delete("savefor", where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateSaveFor(SaveForModel workouts) async {
    var dbClient = await db;
    return await dbClient.update("savefor", workouts.toMap(),
        where: '$ID = ?', whereArgs: [workouts.id]);
  }
}
