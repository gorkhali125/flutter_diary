import 'package:flutter/material.dart';
import 'package:flutter_diary/model/note.dart';

class NoteDetail extends StatelessWidget {
  final Note note;

  NoteDetail({this.note});

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(title: Text('Note Details')),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Title: ' + note.title, style: TextStyle(fontSize: 22)),
            Text('Description: ' + note.description,
                style: TextStyle(fontSize: 22)),
            Text('Date: ' + note.date, style: TextStyle(fontSize: 22)),
          ],
        ),
      ),
    ));
  }
}
