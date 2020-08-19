import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter_diary/model/note.dart';
import 'package:flutter_diary/db/db_helper.dart';

class NoteList extends StatefulWidget {
  NoteList({Key key}) : super(key: key);

  NoteListState createState() => NoteListState();
}

class NoteListState extends State<NoteList> {
  DBHelper dbHelper = DBHelper();
  List<Note> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      final Future<Database> dbFuture = dbHelper.initDB();
      dbFuture.then((database) {
        Future<List<Note>> noteListFuture = dbHelper.getAllNote('text');
        noteListFuture.then((noteList) {
          setState(() {
            this.noteList = noteList;
            this.count = noteList.length;
          });
        });
      });
    }

    final List<int> colorCodes = <int>[300, 200];
    final double listHeight = 80;

    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: this.count,
      itemBuilder: (BuildContext context, int index) {
//        print(jsonEncode(this.noteList[index].toMap()));
        return Container(
          height: listHeight,
          color: Colors.grey[(index % 2 == 0) ? colorCodes[0] : colorCodes[1]],
          child: Center(child: Text(this.noteList[index].title)),
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(color: Colors.white),
    );
  }
}
