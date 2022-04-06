import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import '../model/question.dart';

class QuestionService {
  static String endpoint = '${dotenv.env['API_URL']}/question';
  const QuestionService();

  Future<bool?> addQuestion(Question question) async {
    final response = await post(Uri.parse(endpoint),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(question));
    if (response.statusCode == 200) {
      return true;
    }
    throw Exception("Error in Getting the Question post");
  }

  Future<Set<Question>?> getQuestions() async {
    final response = await get(Uri.parse(endpoint), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      Set<Question> questionList = {};
      List<dynamic> data = jsonDecode(response.body);

      for (dynamic item in data) {
        Question question = Question(
            id: item['_id'],
            topicId: item['topicId'],
            answers: item['answers'],
            correctAnswer: item['correctAnswer'],
            question: item['question']);
        questionList.add(question);
      }

      return questionList;
    }
    throw Exception('Error in getting the questions');
  }

  Future<bool?> updateQuestion(Question question) async {
    final response = await put(Uri.parse(endpoint),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(question));

    if (response.statusCode == 200) {
      return true;
    }
    throw Exception('Error in updating the answers');
  }

  Future<bool?> deleteQuestionByID(String questionID) async {
    final response = await delete(Uri.parse(endpoint),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(questionID));

    if (response.statusCode == 200) {
      return true;
    }
    throw Exception('Error in getting the age');
  }
}
