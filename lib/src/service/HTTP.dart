import 'dart:convert';
import 'package:http/http.dart' as http;

class HTTP {

  static String baseUrl = 'api.weatherapi.com';

  static Future request(String path, Map<String , dynamic> queryParams, String type ) async {

    if (type == "post") {
      return await http.post(
        Uri.http( baseUrl , path ),
        // body: json.encode(data),
        headers: {
          "Content-Type": "application/json"
        },
        encoding: Encoding.getByName("utf-8"),
      );
    }

    return await http.get(
      Uri.http( baseUrl , path , queryParams),
      headers: {

        "Content-Type": "application/json"
      },
    );
  }
}
