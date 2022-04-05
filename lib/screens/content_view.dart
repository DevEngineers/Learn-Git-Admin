import 'package:flutter/material.dart';
import 'content_list.dart';

class ContentView extends StatefulWidget {
  static const String routeName = '/content-view';
  const ContentView({Key? key}) : super(key: key);

  @override
  _ContentViewState createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  @override
  Widget build(BuildContext context) {
    StatefulWidget container = const ContentList();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Content"),
        ),
        body: container);
  }
}
