import 'package:flutter/material.dart';
import 'package:flutter_diary/model/note.dart';

class NoteDetail extends StatelessWidget {
  final Note note;

  NoteDetail(this.note);

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(title: Text('Note Details')),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[titleRow(), actionRow(), descRow()],
        ),
      ),
    ));
  }

  Row titleRow() {
    return Row();
  }

  Row actionRow() {
    return Row();
  }

  Row descRow() {
    return Row();
  }
}
