import 'package:flutter/material.dart';

/*class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Second Page"),),
      body: Builder(builder: (context) =>
        TextField(
          controller: myController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Please enter your name'
          ),
        )
      )
    );
  }
}*/

class MyCustomForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Second Page"),
        ),
        body: Builder(
            builder: (context) => TextField(
                  controller: myController,
                  onEditingComplete: () {
                    print(myController.text);
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Please enter your name'),
                )));
  }
}
