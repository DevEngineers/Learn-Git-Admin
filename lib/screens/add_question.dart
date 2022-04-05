import 'package:flutter/material.dart';
import 'package:learn_git_admin/components/button.dart';
import 'package:learn_git_admin/model/question.dart';
import 'package:learn_git_admin/model/route_arguments.dart';
import 'package:learn_git_admin/provider/question_provider.dart';
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
  String _question = '';
  final List<String> _answer = [];
  String _correctAnswer = '';
  String _questionID = '';
  String _topicID = '';

  Future<void> getRouteArguments() async {
    final RouteArguments arg =
        ModalRoute.of(context)!.settings.arguments as RouteArguments;

    setState(() {
      _questionID = arg.questionId;
      _topicID = arg.topicId;
    });
  }

  final items = ["Item 01", "Item 02", "Item 03", "Item 04"];
  String? value;

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Question question = Question(
          id: '',
          topicId: '6238c42e523b9f9d1325096e',
          question: _question,
          answers: _answer,
          correctAnswer: _correctAnswer);

      Provider.of<QuestionProvider>(context, listen: false)
          .addQuestion(question);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Question')),
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            // border: Border.all(color: Colors.black, width: 4),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                value: value,
                                iconSize: 36,
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black,
                                ),
                                isExpanded: true,
                                items: items.map(buildMenuItem).toList(),
                                onChanged: (value) => setState(
                                      () => this.value = value,
                                    )),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(2, 0, 2, 10),
                          child: CustomTextField(
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
                                  label: "Answers ${index + 1}",
                                  maxLine: 1,
                                  minLine: 1,
                                  onChange: (String? value) {
                                    setState(() {
                                      _answer.insert(index, value!);
                                    });
                                  }),
                            );
                          }),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(2, 8, 2, 10),
                          child: CustomTextField(
                              label: "Correct Answer ",
                              minLine: 1,
                              maxLine: 1,
                              onChange: (String? value) {
                                setState(() {
                                  _correctAnswer = value!;
                                });
                              })),
                      if (_questionID.isEmpty) ...{
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Button(
                              title: 'Submit',
                              color: const Color(0xffE78230),
                              onPress: onSubmit,
                            )),
                      } else ...{
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Button(
                              title: 'Update',
                              color: const Color(0xffE78230),
                              onPress: onSubmit,
                            )),
                      }
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
}
