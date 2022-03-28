import 'package:flutter/cupertino.dart';

import '../model/question.dart';
import '../services/QuestionService.dart';

class QuestionProvider extends ChangeNotifier {
  late QuestionService _questionService;
  final Set<Question> _questions = {};

  Set<Question> get questions => _questions;

  QuestionProvider() {
    _questionService = const QuestionService();
    getQuestions();
  }

  void addQuestion() async {
    final questions = await _questionService.addQuestion();
  }

  void getQuestions() async {
    final questions = await _questionService.getQuestions();
    _questions.addAll(_questions);
    notifyListeners();
  }

  Set<Question> getQuestionsByTopic(String topicId) {
    Iterable<Question> questions = _questions
        .where((element) => element.topicId == topicId)
        .toSet()
        .toList();
    return questions.toSet();
  }
}
