import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter_diary/model/note.dart';

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

  //Initialize
  Future<Database> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'diaries.db';

    var diaryDB = await openDatabase(path, version: 1, onCreate: _createDB);
    return diaryDB;
  }

  //Create DB
  void _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $table($id INTEGER PRIMARY KEY AUTOINCREMENT '
        ', $title VARCHAR(255) NOT NULL, $description TEXT, $type VARCHAR(10) NOT NULL, $date TEXT)');
  }

  //Insert operation
  Future<int> addNote(Note note) async {
    Database db = await this.database;
    var result = db.insert(table, note.toMap());
    return result;
  }

  //Get all Note with specified type.
  Future<List<Note>> getAllNote(String typ) async {
    Database db = await this.database;
    var dbNoteList = await db.query(table,
        orderBy: '$date DESC', where: '$type = ?', whereArgs: [typ]);
    int count = dbNoteList.length;
    List<Note> noteList = List<Note>();
    for (int i = 0; i < count; i++) {
      noteList.add(Note.fromMapObject(dbNoteList[i]));
    }
    return noteList;
  }
}
