import 'package:flutter/material.dart';
import 'package:learn_git_admin/components/button.dart';
import 'package:learn_git_admin/screens/add_quiz.dart';
import 'package:learn_git_admin/screens/view_quiz.dart';

class QuizHome extends StatelessWidget {
  static const String routeName = '/QuizHome';
  const QuizHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QuizHome')),
      body: Container(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Button(
                title: 'Add Quiz',
                onPress: () {
                  Navigator.of(context).pushNamed(AddQuiz.routeName);
                },
                width: 200,
              ),
              Button(
                title: 'View Quiz',
                onPress: () {
                  Navigator.of(context).pushNamed(ViewQuestion.routeName);
                },
                width: 200,
              )
            ],
          ),
        ]),
      ),
    );
  }
}
