import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map<String, dynamic>?> fetchUser(String id) async {
    final url = Uri.parse('https://reqres.in/api/users/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'];
    } else {
      return null;
    }
  }
}
