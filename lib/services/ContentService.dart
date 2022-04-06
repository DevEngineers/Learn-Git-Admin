import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../model/content_model.dart';

//services for content

class APIService {
  static var client = http.Client();
  static String endpoint = '${dotenv.env['API_URL']}';

  static String productsAPI = 'content';

  static Future<List<ContentModel>?> getContent() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var response = await client.get(
      Uri.parse(endpoint + "/" + productsAPI),
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return productsFromJson(data["data"]);

      //return true;
    } else {
      return null;
    }
  }

  static Future<bool> saveContent(
    ContentModel model,
    bool isEditMode,
    bool isFileSelected,
  ) async {
    if (isEditMode) {
      final response = await client.put(
          Uri.parse(endpoint + "/" + productsAPI).replace(queryParameters: {
            "id": model.id.toString(),
          }),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: json.encode(model));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } else {
      final response =
          await client.post(Uri.parse(endpoint + "/" + productsAPI),
              headers: {
                'Content-type': 'application/json',
                'Accept': 'application/json',
              },
              body: json.encode(model));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }
  }

  static Future<bool> deleteContent(productId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var response = await client.delete(
      Uri.parse(endpoint + "/" + productsAPI).replace(queryParameters: {
        "id": productId,
      }),
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
