import 'package:flutter/material.dart';

import 'package:flutter_diary/main.dart';
import 'package:flutter_diary/model/note.dart';
import "package:flutter_diary/form/add_text_note.dart";
import 'package:flutter_diary/db/db_helper.dart';
import 'package:flutter_diary/utils/helpers.dart';

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
                String type = note.type;
                String routeName = (type == 'text')
                    ? AddTextNote.routeName
                    : (type == 'image'
                    ? AddTextNote.routeName
                    : AddTextNote.routeName);
                Navigator.of(ctx)
                    .pushNamed(routeName, arguments: note);
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

}
