import 'dart:async';
import 'dart:io' as io;
import 'package:iknow/helper/saveForModel.dart';
import 'package:iknow/kayitModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database _db;

  static const String ID = 'id';
  static const String AD = 'adi';
  static const String SOYAD = 'soyadi';
  static const String IL = 'il';
  static const String GUNLUKICME = 'gunlukIcme';
  static const String ICMEYIL = 'icmeYil';
  static const String FIYAT = 'fiyat';
  static const String DATE = 'birthDate';
  static const String BIRAKMADATE = 'birakmaDate';
  static const String TABLE = 'kayit';
  static const String DB_NAME = 'sigara1.db';

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
        "CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, $AD STRING, $SOYAD STRING, $IL STRING, $GUNLUKICME INTEGER, $ICMEYIL INTEGER ,$FIYAT INTEGER, $DATE STRING, $BIRAKMADATE STRING)");
  }

  Future<KayitModel> save(KayitModel kayitSave) async {
    var dbClient = await db;
    kayitSave.id = await dbClient.insert(TABLE, kayitSave.toMap());
    return kayitSave;
    /*
    await dbClient.transaction((txn) async {
      var query = "INSERT INTO $TABLE ($NAME) VALUES ('" + employee.name + "')";
      return await txn.rawInsert(query);
    });
    */
  }

  Future<List<KayitModel>> getBilgiler() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [
      ID,
      AD,
      SOYAD,
      IL,
      GUNLUKICME,
      ICMEYIL,
      FIYAT,
      DATE,
      BIRAKMADATE
    ]);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<KayitModel> bilgiler = [];
    if (maps.length > 0) {
      // for (int i = 0; i < maps.length; i++) {
      //   workouts.add(WorkOut.fromMap(maps[i]));
      // }
      for (int i = maps.length - 1; i >= 0; i--) {
        bilgiler.add(KayitModel.fromMap(maps[i]));
      }
    }
    return bilgiler;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  Future<int> update(SaveForModel workouts) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, workouts.toMap(),
        where: '$ID = ?', whereArgs: [workouts.id]);
  }
/////////////////////////////
///// CREATE TABLE savefor (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, adi STRING, aciklama STRING, fiyat INTEGER);
  /// SAVEFORS

}
