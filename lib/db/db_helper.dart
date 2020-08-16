import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class DBHelper {
  static DBHelper _dbHelper;
  static Database _db;

  String table = 'diary_data';
  String id = 'id';
  String title = 'title';
  String description = 'description';
  String type = 'type';
  String date = 'date';

  DBHelper._createInstance();

  factory DBHelper() {
    if (_dbHelper == null) {
      _dbHelper = DBHelper._createInstance();
    }
    return _dbHelper;
  }

  Future<Database> get database async {
    if (_db == null) {
      _db = await initDB();
    }
    return _db;
  }

  Future<Database> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'diaries.db';

    var diaryDB = await openDatabase(path, version: 1, onCreate: _createDB);
    return diaryDB;
  }

  void _createDB(Database db, int version) async {}
}
