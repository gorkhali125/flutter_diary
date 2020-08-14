import 'package:flutter/material.dart';

import 'package:flutter_diary/main.dart';

class AddTextNote extends StatefulWidget {
  static const routeName = 'add-text-note';

  AddTextNote({Key key}) : super(key: key);

  _AddTextNoteState createState() => _AddTextNoteState();
}

class _AddTextNoteState extends State<AddTextNote> {
  final _addTextNoteFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text('Add Text Note')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _handleAddTextNote();
        },
        child: Icon(
          Icons.check,
          semanticLabel: 'Save',
        ),
      ),
    );
  }

  _handleAddTextNote() {
    Navigator.of(context).pushNamed(MyApp.routeName);
  }
}
