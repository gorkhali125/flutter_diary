import 'package:flutter/material.dart';

import 'package:flutter_diary/main.dart';
import 'package:flutter_diary/model/note.dart';
import 'package:flutter_diary/db/db_helper.dart';

class NoteDetail extends StatelessWidget {
  final Note note;
  final DBHelper dbHelper = DBHelper();

  NoteDetail(this.note);

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(title: Text('Note Details')),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[titleRow(), actionRow(context), descRow()],
        ),
      ),
    ));
  }

  Row titleRow() {
    return Row(
      children: <Widget>[
        Flexible(
          child: Text(note.title),
        )
      ],
    );
  }

  Row actionRow(ctx) {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            GestureDetector(
              child: Icon(
                Icons.list,
                color: Colors.green,
              ),
              onTap: () {
                Navigator.of(ctx).pushNamed(MyApp.routeName);
              },
            ),
          ],
        ),
        Column(
          children: <Widget>[
            GestureDetector(
              child: Icon(
                Icons.edit,
                color: Colors.blue,
              ),
              onTap: () {
                print("edit tapped");
              },
            ),
          ],
        ),
        Column(
          children: <Widget>[
            GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onTap: () {
                showDeleteDialog(note, ctx);
              },
            ),
          ],
        ),
      ],
    );
  }

  Row descRow() {
    return Row(
      children: <Widget>[
        Flexible(
          child: Text(note.description),
        )
      ],
    );
  }

  void showDeleteDialog(note, ctx) {
// set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(ctx);
      },
    );
    Widget continueButton = FlatButton(
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
        continueButton,
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
}
