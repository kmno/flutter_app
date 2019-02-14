import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SharedPrefsState();
}

class _SharedPrefsState extends State<SharedPrefs> {
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("SharedPreferences Page"),
        ),
        body: Builder(
            builder: (context) => RaisedButton(
                  onPressed: _incrementCounter,
                  child: Text('Increment Counter'),
                )));
  }
}

_incrementCounter() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int counter = (prefs.getInt('counter') ?? 0) + 1;
  print('pressed $counter times.');
  await prefs.setInt('counter', counter);

  //prefs.remove('counter');
}
