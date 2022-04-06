import 'package:flutter/material.dart';
import 'package:learn_git_admin/components/button.dart';
import 'package:learn_git_admin/model/content_model.dart';
import 'package:learn_git_admin/model/route_arguments.dart';
import 'package:learn_git_admin/providers/content_provider.dart';
import 'package:learn_git_admin/providers/question_provider.dart';
import 'package:learn_git_admin/screens/add_question.dart';
import 'package:learn_git_admin/screens/view_question.dart';
import 'package:provider/provider.dart';
import '../components/custom_text.dart';

class QuestionHome extends StatefulWidget {
  static const String routeName = '/question_home';
  const QuestionHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QuestionHome();
}

class _QuestionHome extends State<QuestionHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Set<ContentModel> _content =
        Provider.of<ContentProvider>(context).contents;
    print("QUESTION HOME CONTENT : $_content");
    return Scaffold(
      appBar: AppBar(title: const Text('Tutorial Questions')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
              child: Button(
                title: "Add Question",
                onPress: () {
                  Navigator.of(context).pushNamed(
                    AddQuestion.routeName,
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
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: _content.length,
                    itemBuilder: (context, index) {
                      return QuestionMenuItem(
                        title: _content.elementAt(index).title.toString(),
                        onPress: () {
                          Navigator.of(context).pushNamed(
                            ViewQuestion.routeName,
                            arguments: RouteArguments(
                                ' ',
                                _content.elementAt(index).title.toString(),
                                _content.elementAt(index).id.toString()),
                          );
                        },
                        body: _content.elementAt(index).id.toString(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionMenuItem extends StatelessWidget {
  final String title;
  final String body;
  final Function onPress;
  final IconData? icon;

  const QuestionMenuItem({
    Key? key,
    required this.onPress,
    this.icon,
    required this.body,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    int questionCount =
        Provider.of<QuestionProvider>(context).getQuestionsByTopic(body).length;
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
                      fontWeight: FontWeight.w600),
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: CustomText(
                        text: '${questionCount.toString()} Questions',
                        type: 'bodyText',
                        color: 'white',
                      ),
                    )),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 2, 5, 0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.arrow_circle_right_sharp,
                        size: 45,
                        color: Color(0xffE78230),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
