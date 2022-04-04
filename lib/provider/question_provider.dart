import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
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

  Future<bool?> addQuestion(Question question) async {
    final response = await _questionService.addQuestion(question);
    _questions.add(question);
    notifyListeners();
    return response;
  }

  void getQuestions() async {
    final questions = await _questionService.getQuestions();
    _questions.addAll(questions!);
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
