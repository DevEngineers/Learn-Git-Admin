import 'package:flutter/material.dart';

import 'back_end_content.dart';

class BackendHome extends StatefulWidget {
  static const String routeName = '/';
  const BackendHome({Key? key}) : super(key: key);

  @override
  _BackendHomeState createState() => _BackendHomeState();
}

class _BackendHomeState extends State<BackendHome> {
  @override
  Widget build(BuildContext context) {
    StatefulWidget container = const BackEndContent();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          title: const Text("Git Study"),
        ),
        body: container);
  }
}
