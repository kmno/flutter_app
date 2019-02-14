import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;

import 'strings.dart';

class MyNetCall extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyNetCallState();
}

//HTTP request
class MyNetCallState extends State<MyNetCall> {
  var _members = <Member>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text(Strings.appTitle),
        ),
        // body: new Text(Strings.appTitle),
        body: ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: _members.length * 2,
            itemBuilder: (BuildContext context, int position) {
              if (position.isOdd) return new Divider();
              final index = position ~/ 2;
              return _buildRow(index);
            } //itemBuilder
            ));
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Widget _buildRow(int i) {
    return new Padding(
        padding: const EdgeInsets.all(0.0),
        child: new ListTile(
          title: Text("${_members[i].login}", style: _biggerFont),
          leading: new CircleAvatar(
              backgroundColor: Colors.green,
              backgroundImage: NetworkImage(_members[i].avatarUrl)),
        ));
  } //buildRow

  _loadData() async {
    String dataURL = "https://api.github.com/orgs/raywenderlich/members";
    http.Response response = await http.get(dataURL);
    setState(() {
      final membersJSON = json.decode(response.body);

      for (var memberJSON in membersJSON) {
        final member =
            new Member(memberJSON["login"], memberJSON["avatar_url"]);
        _members.add(member);
      }
    }); //setState
  }
} //GHFlutterState

class Member {
  final String login;
  final String avatarUrl;

  Member(this.login, this.avatarUrl) {
    if (login == null) {
      throw new ArgumentError("login of Member cannot be null. "
          "Received : '$login'");
    }

    if (avatarUrl == null) {
      throw new ArgumentError("avatarUrl of Member cannot be null. "
          "Received : '$avatarUrl'");
    }
  }
}
