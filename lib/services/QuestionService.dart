import 'dart:convert';
import 'package:http/http.dart';

import '../model/question.dart';

class QuestionService {
  static const String endpoint = "";
  const QuestionService();

  Future<Response> addQuestion() async {
    return null;
  }

  Future<List<Question>?> getQuestions() async {
    // final response = await get(Uri.parse(endpoint).replace(queryParameters: {
    //   "topic": topicId,
    // }));

    // if (response.statusCode == 200) {
    //   return jsonDecode(response.body)['age'];
    // }
    //throw Exception('Error in getting the age');

    // return q;
  }
}
