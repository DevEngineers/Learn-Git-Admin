import 'package:flutter_dotenv/flutter_dotenv.dart';

class Service {
  //Example to add the API_URL
  static String endpoint = '${dotenv.env['API_URL']}';
  const Service();
}
