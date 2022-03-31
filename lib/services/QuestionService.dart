import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import '../model/question.dart';

class QuestionService {
  static String endpoint = '${dotenv.env['API_URL']}/question';
  const QuestionService();

  Future<bool?> addQuestion(Set question) async {
    print('question Service Q : - ${question}');
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
