//drawer
import 'package:flutter/material.dart';

//pages
import 'drawer_first_page.dart';
import 'drawer_second_page.dart';
import 'drawer_sharedprefs.dart';
import 'drawer_net_call.dart';
import 'drawer_location.dart';
import 'animations.dart';

class DWidget extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        new DrawerHeader(
          child: new Text("DRAWER HEADER.."),
          decoration: new BoxDecoration(color: Colors.orange),
        ),
        new ListTile(
          title: new Text("Item => 1"),
          onTap: () {
            Navigator.pop(ctxt);
            Navigator.push(ctxt,
                new MaterialPageRoute(builder: (ctxt) => new FirstPage()));
          },
        ),
        new ListTile(
          title: new Text("Edit Text"),
          onTap: () {
            Navigator.pop(ctxt);
            Navigator.push(ctxt,
                new MaterialPageRoute(builder: (ctxt) => new MyCustomForm()));
          },
        ),
        new ListTile(
          title: new Text("Sharedpreferences"),
          onTap: () {
            Navigator.pop(ctxt);
            Navigator.push(ctxt,
                new MaterialPageRoute(builder: (ctxt) => new SharedPrefs()));
          },
        ),
        new ListTile(
          title: new Text("api call"),
          onTap: () {
            Navigator.pop(ctxt);
            Navigator.push(ctxt,
                new MaterialPageRoute(builder: (ctxt) => new MyNetCall()));
          },
        ),
        new ListTile(
          title: new Text("location"),
          onTap: () {
            Navigator.pop(ctxt);
            Navigator.push(
                ctxt, new MaterialPageRoute(builder: (ctxt) => new MapsDemo()));
          },
        ),
        new ListTile(
          title: new Text("animations"),
          onTap: () {
            Navigator.pop(ctxt);
            Navigator.push(
                ctxt,
                new MaterialPageRoute(
                    builder: (ctxt) => new EasingAnimationWidget()));
          },
        )
      ],
    ));
  }
}
