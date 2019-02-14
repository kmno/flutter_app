import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("First Page"),
        ),
        body: Builder(
          builder: (context) => Checkbox(
              value: false,
              onChanged: (bool newValue) {
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('Checkbox changed!')));
                // Navigator.pop(ctxt); // Pop from stack
              }),
        ));
  }
}
