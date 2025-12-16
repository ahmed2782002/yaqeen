import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiManager {
  static const String _baseUrl = 'https://api.aladhan.com/v1';

  static Future<Map<String, dynamic>> get({
    required String endpoint,
    Map<String, String>? query,
  }) async {
    final uri =
    Uri.parse('$_baseUrl$endpoint').replace(queryParameters: query);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Server Error: ${response.statusCode}');
    }
  }
}
