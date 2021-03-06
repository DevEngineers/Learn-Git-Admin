import 'package:flutter/material.dart';
import 'package:learn_git_admin/components/button.dart';
import 'package:learn_git_admin/components/custom_text.dart';
import 'package:learn_git_admin/model/content_model.dart';
import 'package:learn_git_admin/model/question.dart';
import 'package:learn_git_admin/model/route_arguments.dart';
import 'package:learn_git_admin/providers/content_provider.dart';
import 'package:learn_git_admin/providers/question_provider.dart';
import 'package:learn_git_admin/screens/question_home.dart';
import 'package:learn_git_admin/screens/question_view.dart';
import 'package:provider/provider.dart';
import 'package:learn_git_admin/components/custom_text_field.dart';

class AddQuestion extends StatefulWidget {
  static const String routeName = '/add_question';

  const AddQuestion({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddQuestion();
}

class _AddQuestion extends State<AddQuestion> {
  final _formKey = GlobalKey<FormState>();
  List<ContentModel> _content = [];
  String? valueTopicID;
  String _question = '';
  List<dynamic> _answer = [];
  List<dynamic> _storedAnswers = [];
  String _correctAnswer = '';
  String _questionID = '';
  String _topicID = '';
  String _topic = '';

  Future<void> getRouteArguments() async {
    final RouteArguments arg =
        ModalRoute.of(context)!.settings.arguments as RouteArguments;

    if (arg.questionId != null) {
      final Question qus = Provider.of<QuestionProvider>(context, listen: false)
          .getQuestionsByQuestionID(arg.questionId);

      final ContentModel content = Provider.of<ContentProvider>(context)
          .getContentByContentID(arg.topicId);

      setState(() {
        _question = qus.question;
        _storedAnswers = qus.answers;
        _correctAnswer = qus.correctAnswer;
        _questionID = arg.questionId;
        _topicID = qus.topicId;
        _topic = content.title!;
      });
    }
  }

  void getContents() {
    _content = Provider.of<ContentProvider>(context).contents.toList();
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_questionID == '') {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text("Learn Git"),
            content: const Text('Are You sure to Submit.'),
            actions: [
              TextButton(
                onPressed: () {
                  _answer = [];
                  Navigator.pop(context, 'Cancel');
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                  onPressed: () {
                    Question question = Question(
                        id: '',
                        topicId: valueTopicID.toString(),
                        question: _question,
                        answers: _answer,
                        correctAnswer: _correctAnswer);

                    Provider.of<QuestionProvider>(context, listen: false)
                        .addQuestion(question);
                    Navigator.of(context).pushNamed(ViewQuestion.routeName,
                        arguments: RouteArguments(
                            _questionID, _topic, valueTopicID.toString()));
                  },
                  child: const Text("Submit")),
            ],
          ),
        );
      } else {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text("Learn Git"),
            content: const Text('Are You sure to Update.'),
            actions: [
              TextButton(
                onPressed: () {
                  _answer = [];
                  // Navigator.pop(context, 'Cancel');
                  Navigator.of(context).pushNamed(ViewQuestion.routeName,
                      arguments: RouteArguments(_questionID, _topic, _topicID));
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                  onPressed: () {
                    Question question = Question(
                        id: _questionID,
                        topicId: _topicID,
                        question: _question,
                        answers: _answer,
                        correctAnswer: _correctAnswer);

                    Provider.of<QuestionProvider>(context, listen: false)
                        .updateQuestion(question);

                    Navigator.of(context).pushNamed(ViewQuestion.routeName,
                        arguments:
                            RouteArguments(_questionID, _topic, _topicID));
                  },
                  child: const Text("Update")),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getRouteArguments();
    getContents();

    return Scaffold(
      appBar: AppBar(
        title: Text(_questionID == '' ? 'Question' : 'Update Question'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(QuestionHome.routeName);
            },
          )
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(15.0),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      if (_questionID == '') ...{
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                  value: valueTopicID,
                                  iconSize: 36,
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                  ),
                                  isExpanded: true,
                                  items: _content.map(buildMenuItem).toList(),
                                  onChanged: (value) => setState(
                                        () => valueTopicID = value,
                                      )),
                            ),
                          ),
                        ),
                      } else ...{
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: CustomText(
                            text: _topic,
                            type: 'headText',
                          ),
                        ),
                      },
                      Padding(
                          padding: const EdgeInsets.fromLTRB(2, 0, 2, 10),
                          child: CustomTextField(
                            value: _question,
                            label: "Question",
                            maxLine: 2,
                            minLine: 1,
                            onChange: (String? value) {
                              setState(() {
                                _question = value!;
                              });
                            },
                          )),
                      ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(2, 8, 2, 10),
                              child: CustomTextField(
                                value: _questionID == ''
                                    ? ''
                                    : _storedAnswers.elementAt(index),
                                label: "Answers ${index + 1}",
                                maxLine: 1,
                                minLine: 1,
                                onChange: (String? value) {
                                  setState(() {
                                    _answer.insert(index, value);
                                  });
                                },
                              ),
                            );
                          }),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(2, 8, 2, 10),
                          child: CustomTextField(
                            value: _correctAnswer,
                            label: "Correct Answer ",
                            minLine: 1,
                            maxLine: 1,
                            onChange: (String? value) {
                              setState(() {
                                _correctAnswer = value!;
                              });
                            },
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Button(
                          title: _questionID == '' ? 'Submit' : 'Update',
                          color: const Color(0xffE78230),
                          onPress: onSubmit,
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(ContentModel contentModel) =>
      DropdownMenuItem(
        value: contentModel.id.toString(),
        child: Text(
          contentModel.title.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
}
