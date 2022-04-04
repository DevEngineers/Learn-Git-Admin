import 'package:flutter/material.dart';
import 'package:learn_git_admin/screens/add_quiz.dart';
import 'package:learn_git_admin/screens/quiz_home.dart';
import '../components/custom_text.dart';

class Home extends StatefulWidget {
  static const String routeName = '/home';
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                  child: Text('Learn Git Admin',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold))),
              MenuItem(
                  title: 'Tutorial Content',
                  body: '5 tutorials',
                  onPress: () {}),
              MenuItem(
                  title: 'Tutorial Questions',
                  body: '5 Questions',
                  onPress: () {
                    Navigator.of(context).pushNamed(QuizHome.routeName);
                  }),
              MenuItem(title: 'Users', body: '5 Users', onPress: () {})
            ],
          ),
        ));
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final String body;
  final Function onPress;

  const MenuItem({
    Key? key,
    required this.title,
    required this.onPress,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return SizedBox(
        width: width,
        height: 150,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                        child: CustomText(
                            text: title,
                            type: 'title',
                            color: 'white',
                            fontWeight: FontWeight.bold)),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                          child: CustomText(
                            text: body,
                            type: 'bodyText',
                            color: 'white',
                          ),
                        )),
                    const Padding(
                        padding: EdgeInsets.fromLTRB(0, 2, 5, 0),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.arrow_circle_right_outlined,
                              size: 45,
                              color: Color(0xffE78230),
                            )))
                  ],
                ),
              )),
        ));
  }
}
