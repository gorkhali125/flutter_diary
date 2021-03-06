import 'package:flutter/material.dart';
import 'dart:math' as math;

import "package:flutter_diary/view/note_list.dart";
import "package:flutter_diary/form/add_text_note.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      initialRoute: '/',
      routes: {
        MyApp.routeName: (context) => MyApp(),
        AddTextNote.routeName: (context) => AddTextNote(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final globalKey = GlobalKey<ScaffoldState>();
  AnimationController _controller;

  static const List<IconData> icons = const [
    Icons.videocam,
    Icons.image,
    Icons.sms
  ];

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).cardColor;
    Color foregroundColor = Theme.of(context).accentColor;

    return new Scaffold(
      key: globalKey,
      appBar: new AppBar(title: new Text('Notes Collection')),
      body: NoteList(),
      floatingActionButton: new Column(
        mainAxisSize: MainAxisSize.min,
        children: new List.generate(icons.length, (int index) {
          Widget child = new Container(
            height: 70.0,
            width: 56.0,
            alignment: FractionalOffset.topCenter,
            child: new ScaleTransition(
              scale: new CurvedAnimation(
                parent: _controller,
                curve: new Interval(0.0, 1.0 - index / icons.length / 2.0,
                    curve: Curves.easeOut),
              ),
              child: new FloatingActionButton(
                heroTag: null,
                backgroundColor: backgroundColor,
                mini: true,
                child: new Icon(icons[index], color: foregroundColor),
                onPressed: () {
                  _controller.reverse();
                  String routeName = (index == 0)
                      ? AddTextNote.routeName
                      : (index == 1
                          ? AddTextNote.routeName
                          : AddTextNote.routeName);
                  Navigator.of(context).pushNamed(routeName);
                },
              ),
            ),
          );
          return child;
        }).toList()
          ..add(
            new FloatingActionButton(
              heroTag: null,
              child: new AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget child) {
                  return new Transform(
                    transform: new Matrix4.rotationZ(
                        _controller.value * 0.5 * math.pi),
                    alignment: FractionalOffset.center,
                    child: new Icon(
                        _controller.isDismissed ? Icons.add : Icons.close),
                  );
                },
              ),
              onPressed: () {
                if (_controller.isDismissed) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
              },
            ),
          ),
      ),
    );
  }
}
