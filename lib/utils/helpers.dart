import 'package:flutter/material.dart';
import 'package:flutter_diary/main.dart';
import 'package:flutter_diary/model/note.dart';
import 'package:flutter_diary/db/db_helper.dart';

final Note note = Note('','','');
final DBHelper dbHelper = DBHelper();

void showDeleteDialog(note, ctx) {
// set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.pop(ctx);
    },
  );
  Widget submitButton = FlatButton(
    child: Text("Yes"),
    onPressed: () {
      dbHelper.deleteNote(note.id);
      Navigator.of(ctx).pushNamed(MyApp.routeName);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Delete Note"),
    content: Text("Are you sure you want to delete this note?"),
    actions: [
      cancelButton,
      submitButton,
    ],
  );
  // show the dialog
  showDialog(
    context: ctx,
    builder: (BuildContext context) {
      return alert;
    },
  );
}