import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/strings.dart';
import 'package:flutter/services.dart';

import 'drawer.dart';
import 'theme.dart';

import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'connectivity.dart';

import 'package:connectivity/connectivity.dart';

enum DialogActions { ok, close }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(
        title: Strings.appTitle,
        theme: MyTheme(),
        //tabs
        home: Builder(
            builder: (context) => DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text(Strings.appTitle),
                      bottom: TabBar(
                        tabs: tabsList,
                      ),
                    ),
                    drawer: DWidget(),
                    body: TabBarView(children: <Widget>[
                      FirstWidget(),
                      SecondWidget(),
                    ]),
                    floatingActionButton: FloatingActionButton(
                        child: Icon(Icons.add_alert),
                        onPressed: () {
                          /*Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ScanScreen()),
                  );*/
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Alert Dialog"),
                                  content: Text(
                                    "this is a alert dialog.",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          _dialogResult(
                                              DialogActions.ok, context);
                                        },
                                        child: Text("OK")),
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          _dialogResult(
                                              DialogActions.close, context);
                                        },
                                        child: Text("Close"))
                                  ],
                                );
                              });
                        }),
                  ),
                )));
  }

  void _dialogResult(DialogActions value, BuildContext ctx) {
    //Scaffold.of(ctx).showSnackBar(SnackBar(content: Text('you selected $value')));
    Fluttertoast.showToast(
        msg: 'you selected $value',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1);
  }
}

var tabsList = [Tab(icon: Icon(Icons.star)), Tab(text: Strings.setting)];

//tabview
class FirstWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FirstWidgetApp();
}

class FirstWidgetApp extends State<FirstWidget> {
  var barcode = "scan result = unknown";

  final Connectivity _connectivity = Connectivity();
  var _subscription;

  @override
  initState() {
    super.initState();

    //check network connection
    /*if(checkConnectivity.isNetworkReachable() == false){
      print("network not reachable ...");
    }else{
      print("network is ok!");
    }*/

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result.toString() == ConnectivityResult.none) {
        print("network not reachable ...");
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    // _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(barcode, textAlign: TextAlign.center),
          RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              splashColor: Colors.blueGrey,
              onPressed: scan,
              child: const Text('START CAMERA SCAN'))
        ],
      ),
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = "scan result = $barcode");
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(
          () => this.barcode = 'null (User returned using the "back"-button'
              ' before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}

class SecondWidget extends StatefulWidget {
  @override
  SecondWidgetApp createState() => SecondWidgetApp();
}

class SecondWidgetApp extends State<SecondWidget> {
  int counter = 0;
  bool cboxValue = false;

  @override
  Widget build(BuildContext ctxt) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text("count = $counter"),
        Image.asset('assets/images/os.png'),
        Checkbox(
            value: cboxValue,
            onChanged: (bool newValue) {
              setState(() {
                cboxValue = newValue;
                counter++;
              });
            })
      ],
    ));
  }
}
