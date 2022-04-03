import 'package:flutter/material.dart';
import 'package:learn_git_admin/components/button.dart';
import 'package:learn_git_admin/model/question.dart';
import 'package:learn_git_admin/provider/question_provider.dart';
import 'package:provider/provider.dart';
import 'package:learn_git_admin/components/custom_text_field.dart';

class AddQuiz extends StatefulWidget {
  static const String routeName = '/addQuiz';

  const AddQuiz({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddQuizState();
}

class _AddQuizState extends State<AddQuiz> {
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

      final res = Provider.of<QuestionProvider>(context, listen: false)
          .addQuestion(question);
      print(res);
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
                  // ListView.builder(
                  //     itemCount: 5,
                  //     itemBuilder: (context, index) {
                  //       return CustomTextField(
                  //           label: "Answers ${index + 1}",
                  //           maxLine: 1,
                  //           minLine: 1,
                  //           onChange: (String? value) {
                  //             setState(() {
                  //               _answer.insert(index, value!);
                  //             });
                  //           });
                  //     }),
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: CustomTextField(
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
