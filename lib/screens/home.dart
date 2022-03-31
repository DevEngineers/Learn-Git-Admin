import 'package:flutter/material.dart';
import 'package:learn_git_admin/components/button.dart';
import 'package:learn_git_admin/screens/add_quiz.dart';
import 'package:learn_git_admin/screens/view_quiz.dart';
import '../components/button.dart';

class Home extends StatelessWidget {
  static const String routeName = '/';
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Column(children: [
        Button(
            title: 'Add Question',
            onPress: () {
              Navigator.of(context).pushNamed(AddQuiz.routeName);
            }),
        Button(
            title: 'View Question',
            onPress: () {
              Navigator.of(context).pushNamed(ViewQuestion.routeName);
            })
      ]),
    );
  }
}
