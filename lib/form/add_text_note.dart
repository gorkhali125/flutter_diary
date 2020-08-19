import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_diary/main.dart';
import 'package:flutter_diary/model/note.dart';
import 'package:flutter_diary/db/db_helper.dart';

class AddTextNote extends StatefulWidget {
  static const routeName = 'add-text-note';

  AddTextNote({Key key}) : super(key: key);

  _AddTextNoteState createState() => _AddTextNoteState();
}

class _AddTextNoteState extends State<AddTextNote> {
  final _addTextNoteFormKey = GlobalKey<FormState>();
  Note note = Note('', DateFormat.yMMMd().format(DateTime.now()), 'text');
  DBHelper dbHelper = DBHelper();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

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
                          maxLines: 3,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'What do you want to write about?',
                          ),
                          controller: titleController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'You might want to write something.';
                            }
                            return null;
                          },
                          onChanged: (String value) {
                            note.title = titleController.text.trim();
                          },
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(hintText: 'Tell me more.'),
                        controller: descriptionController,
                        onChanged: (String value) {
                          note.description = descriptionController.text.trim();
                        },
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
          setState(() {
            if (_addTextNoteFormKey.currentState.validate()) {
              _saveTextNote();
            }
          });
        },
        child: Icon(
          Icons.check,
          semanticLabel: 'Save',
        ),
      ),
    );
  }

  void _saveTextNote() async {
    Navigator.of(context).pushNamed(MyApp.routeName);
    int saved = await dbHelper.addNote(note);

    if (saved != 0) {
      _showAlertDialog('Success', 'Your note is saved successfully!!');
    } else {
      _showAlertDialog('Error', 'An error occurred while saving note.');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        new FlatButton(
          child: const Text("Close"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
