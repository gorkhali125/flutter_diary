import 'package:flutter/material.dart';

import 'package:flutter_diary/main.dart';
import 'package:flutter_diary/model/note.dart';
import 'package:flutter_diary/form/edit_text_note.dart';
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
        margin: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            titleContainer(),
            actionRow(context),
            descContainer()
          ],
        ),
      ),
    ));
  }

  Container titleContainer() {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    note.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  note.date,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row actionRow(ctx) {
    Color primaryColor = Theme.of(ctx).primaryColor;
    return Row(
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: IconButton(
                icon: Icon(
                  Icons.list,
                  color: primaryColor,
                ),
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
              child: IconButton(
                icon: Icon(Icons.edit, color: primaryColor),
              ),
              onTap: () {
                Navigator.push(ctx, MaterialPageRoute(builder: (context) {
                  return EditTextNote(note);
                }));
              },
            ),
          ],
        ),
        Column(
          children: <Widget>[
            GestureDetector(
              child: IconButton(
                icon: Icon(Icons.delete, color: primaryColor),
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

  Container descContainer() {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    note.description,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
