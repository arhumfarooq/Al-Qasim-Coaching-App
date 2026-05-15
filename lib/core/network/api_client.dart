import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  Future<http.Response> post(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    return await http.post(
      Uri.parse(url),
            headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
     
      body: body == null ? null : jsonEncode(body),
    );
  }
    /// 🔹 GET method
  Future<http.Response> get(String url) async {
    return await http.get(
      Uri.parse(url),
    );
  }
}
