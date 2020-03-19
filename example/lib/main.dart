import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:native_tools/native_tools.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  List<CellItem> _items() => [CellItem(title: "屏幕常亮", action: () {})];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Native tools'),
        ),
        body: ListView(
          children: _items()
              .map((item) => Container(
                    margin: EdgeInsets.only(bottom: 10),
                    color: Colors.white,
                    child: ListTile(
                      onTap: item.action,
                      title: Text(item.title),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class CellItem {
  String title;
  Function action;

  CellItem({this.title, this.action});
}
