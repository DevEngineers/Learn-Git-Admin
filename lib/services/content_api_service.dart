import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../model/content_model.dart';

class APIService {
  static var client = http.Client();
  static String endpoint = '${dotenv.env['API_URL']}';
  static String productsAPI = 'content';

  static Future<List<ContentModel>?> getContent() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      endpoint,
      productsAPI,
    );

    var response = await client.get(
      url,
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
    var productURL = productsAPI;

    if (isEditMode) {
      productURL = productURL + "/" + model.id.toString();
    }

    var url = Uri.http(endpoint, productURL);

    var requestMethod = isEditMode ? "PUT" : "POST";

    var request = http.MultipartRequest(requestMethod, url);
    request.fields["title"] = model.title!;
    request.fields["content"] = model.content!.toString();

    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteContent(productId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      endpoint,
      productsAPI + "/" + productId,
    );

    var response = await client.delete(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
