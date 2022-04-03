import 'package:flutter/material.dart';
import 'package:learn_git_admin/components/button.dart';
import 'package:learn_git_admin/model/question.dart';
import 'package:learn_git_admin/provider/question_provider.dart';
import 'package:provider/provider.dart';
import '../components/custom_text_field.dart';

class EditQuiz extends StatefulWidget {
  static const String routeName = '/editQuiz';

  const EditQuiz({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditQuizState();
}

class _EditQuizState extends State<EditQuiz> {
  final _formKey = GlobalKey<FormState>();
  String _question = '';
  List<String> _answer = [];
  String _correctAnswer = '';

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Question question = Question(
          id: '',
          topicId: 'topicId',
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
      appBar: AppBar(title: const Text('Add Quiz')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: CustomTextFiled(
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
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(8),
                            child: CustomTextFiled(
                                label: "Answers ${index + 1}",
                                maxLine: 1,
                                minLine: 1,
                                onChange: (String? value) {
                                  setState(() {
                                    _answer.insert(index, value!);
                                  });
                                }));
                      }),
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: CustomTextFiled(
                          label: "Correct Answer ",
                          minLine: 1,
                          maxLine: 1,
                          onChange: (String? value) {
                            setState(() {
                              _correctAnswer = value!;
                            });
                          })),
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Button(
                        title: 'Submit',
                        onPress: onSubmit,
                        width: 250,
                      )),
                ],
              ))
        ],
      ),
    );
  }
}
