import 'dart:convert';

import '../repository/login_repository.dart';
import 'package:http/http.dart' as http;

class LoginRepositoryImpl implements LoginRepository {
  @override
  Future<bool> login(String email, String password) async {
    final url = Uri.https('reqres.in', '/api/login');
    final Map<String, dynamic> body = {
      'email': email,
      'password': password,
    };
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      return jsonData.containsKey('token');
    } else {
      throw Exception("Login failed: ${response.body}");
    }
  }
}
