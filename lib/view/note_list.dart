import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter_diary/model/note.dart';
import 'package:flutter_diary/db/db_helper.dart';
import 'package:flutter_diary/view/note_detail.dart';
import 'package:flutter_diary/form/edit_text_note.dart';
import 'package:flutter_diary/utils/helpers.dart';

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
      refreshNoteList();
    }

    TextStyle titleStyle = Theme.of(context).textTheme.subtitle1;

    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, position) {
          return Card(
            key: ObjectKey(noteList[position].id),
            color: Colors.white,
            elevation: 5.0,
            child: ListTile(
              leading: Icon((this.noteList[position].type == 'text')
                  ? Icons.sms
                  : (this.noteList[position].type == 'image'
                      ? Icons.image
                      : Icons.videocam)),
              title: Text(
                this.noteList[position].title,
                style: titleStyle,
              ),
              subtitle: Text(this.noteList[position].date),
              trailing: Wrap(
                spacing: 10,
                children: <Widget>[
                  GestureDetector(
                    child: Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return EditTextNote(this.noteList[position]);
                      }));
                    },
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onTap: () {
                      showDeleteDialog(this.noteList[position], context);
                    },
                  )
                ],
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NoteDetail(this.noteList[position]);
                }));
              },
            ),
            //...
          );
        });
  }

  void refreshNoteList() {
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
}
