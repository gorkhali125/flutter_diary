import 'package:flutter/material.dart';

import 'package:flutter_diary/model/note.dart';
import 'package:flutter_diary/db/db_helper.dart';

class NoteList extends StatefulWidget {
  NoteList({Key key}) : super(key: key);

  NoteListState createState() => NoteListState();
}

class NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>[
      'I really liked this monkey.',
      'A man helping an old man.',
      'This picture was so cool.'
    ];
    final List<int> colorCodes = <int>[300, 200];
    final double listHeight = 80;

    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: listHeight,
          color: Colors.grey[(index % 2 == 0) ? colorCodes[0] : colorCodes[1]],
          child: Center(child: Text('${entries[index]}')),
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(color: Colors.white),
    );
  }
}
