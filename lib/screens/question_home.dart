import 'package:flutter/material.dart';
import 'package:learn_git_admin/components/button.dart';
import 'package:learn_git_admin/screens/add_quiz.dart';
import 'package:learn_git_admin/screens/view_quiz.dart';
import '../components/custom_text.dart';

class QuestionHome extends StatefulWidget {
  static const String routeName = '/question_home';
  const QuestionHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QuestionHome();
}

class _QuestionHome extends State<QuestionHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Tutorial Questions')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
              child: Button(
                title: "Add Question",
                onPress: () {
                  Navigator.of(context).pushNamed(
                    AddQuiz.routeName,
                  );
                },
                color: const Color(0xffE78230),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: CustomText(
                    text: 'Questions',
                    type: 'headText',
                    fontWeight: FontWeight.w600),
              ),
            ),
            Flexible(
                child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              children: [
                QuestionMenuItem(
                  name: 'Content Heading',
                  onPress: () {
                    Navigator.of(context).pushNamed(
                      ViewQuestion.routeName,
                    );
                  },
                ),
                QuestionMenuItem(
                  name: 'Content Heading',
                  onPress: () {
                    Navigator.of(context).pushNamed(
                      ViewQuestion.routeName,
                    );
                  },
                  icon: Icons.cast_for_education,
                )
              ],
            ))
          ],
        ));
  }
}

class QuestionMenuItem extends StatelessWidget {
  final String name;
  final Function onPress;
  final IconData? icon;

  const QuestionMenuItem({
    Key? key,
    required this.name,
    required this.onPress,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SizedBox(
        width: width / 2,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Card(
              color: const Color(0xff30445C),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: InkWell(
                onTap: () => onPress(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: CustomText(
                            text: name,
                            type: 'headText',
                            color: 'white',
                            fontWeight: FontWeight.w600)),
                    const Padding(
                        padding: EdgeInsets.fromLTRB(0, 2, 5, 0),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.arrow_circle_right_sharp,
                              size: 45,
                              color: Color(0xffE78230),
                            ))),
                  ],
                ),
              )),
        ));
  }
}
