import 'package:flutter/material.dart';
import 'package:learn_git_admin/provider/question_provider.dart';
import 'package:provider/provider.dart';
import '../components/custom_text.dart';
import '../model/question.dart';

class ViewQuestion extends StatefulWidget {
  static const String routeName = '/view_question';
  const ViewQuestion({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ViewQuestion();
}

class _ViewQuestion extends State<ViewQuestion> {
  String topicId = '6238c42e523b9f9d1325096e';

  @override
  Widget build(BuildContext context) {
    final Set<Question> _questions =
        Provider.of<QuestionProvider>(context).getQuestionsByTopic(topicId);

    return Scaffold(
        appBar: AppBar(title: const Text('Questions')),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
                padding: EdgeInsets.all(8),
                child: CustomText(
                  text: 'Learn Basic Git',
                  type: 'headText',
                )),
            ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: _questions.length,
              itemBuilder: (context, index) {
                return QuizQuestion(
                  question: _questions.elementAt(index),
                  questionNo: index,
                );
              },
            ),
          ],
        )));
  }
}

class QuizQuestion extends StatefulWidget {
  final Question question;
  final int questionNo;

  const QuizQuestion({
    Key? key,
    required this.question,
    required this.questionNo,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QuizQuestion();
}

class _QuizQuestion extends State<QuizQuestion> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: CustomText(
            text: 'Question ${widget.questionNo + 1}',
            color: 'grey',
            type: 'bodyText',
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
          child: CustomText(
              text: widget.question.question,
              color: 'black',
              type: 'bodyTextTwo'),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.question.answers.length,
            itemBuilder: (context, index) {
              return AnswersList(
                answer: widget.question.answers.elementAt(index),
                groupValue: '',
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: CustomText(
              text: 'Correct Answer :  ${widget.question.correctAnswer}',
              color: 'black'),
        ),
      ],
    );
  }
}

class AnswersList extends StatelessWidget {
  final String answer;
  final String groupValue;

  const AnswersList({
    Key? key,
    required this.answer,
    required this.groupValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 70,
      child: Card(
        elevation: 3,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: RichText(
                  text: TextSpan(
                      text: '• ',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[TextSpan(text: '  $answer')]),
                ),
              ),
            ]),
      ),
    );
  }
}
