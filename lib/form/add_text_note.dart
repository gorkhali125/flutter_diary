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
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: ListView(
            children: <Widget>[
              Theme(
                data: ThemeData(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  inputDecorationTheme:
                      InputDecorationTheme(border: InputBorder.none),
                ),
                child: Form(
                  key: _addTextNoteFormKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 50),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 2,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'What do you want to write about?',
                          ),
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(hintText: 'Tell me more.'),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
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
