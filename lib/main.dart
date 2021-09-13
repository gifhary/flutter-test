import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final TextEditingController _controller = TextEditingController();
  List _userNames = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void search() {
    var _url =
        Uri.parse('https://api.github.com/search/users?q=${_controller.text}');
    http.get(
      _url,
      headers: {
        'Accept': 'application/vnd.github.v3+json',
      },
    ).then((value) {
      if(value.statusCode == 200){
        var users = json.decode(value.body);
        _userNames = users['items'];
        print(_userNames);
      }
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Flutter test'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(6),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter search term'),
            ),
            ElevatedButton(onPressed: search, child: const Text('Search')),
          ],
        ),
      ),
    );
  }
}
