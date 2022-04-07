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

  Question getQuestionsByQuestionID(String questionId) {
    return _questions.singleWhere((element) => element.id == questionId);
  }

  Future<bool?> updateQuestion(Question questions) async {
    final response = await _questionService.updateQuestion(questions);

    if (response == true) {
      final storedQuestionIndex =
          _questions.singleWhere((question) => question.id == questions.id);

      if (storedQuestionIndex != -1) {
        _questions.remove(storedQuestionIndex);
        _questions.add(questions);
      }
    }
    notifyListeners();
    return response;
  }

  Future<bool?> deleteQuestion(Question questions) async {
    final response = await _questionService.deleteQuestionByID(questions);

    if (response == true) {
      final storedQuestionIndex =
          _questions.singleWhere((question) => question.id == questions.id);

      if (storedQuestionIndex != -1) {
        _questions.remove(storedQuestionIndex);
      }
    }
    notifyListeners();
    return response;
  }
}
