import 'dart:convert';

import 'package:api_calling_bloc_mvvm_demo/model/NewsModel.dart';
import 'package:api_calling_bloc_mvvm_demo/model/UserModel.dart';

import '../repository/user_repository.dart';
import 'package:http/http.dart' as http;

class UserRepositoryImpl implements UserRepository {
  @override
  Future<UserModel> fetchUsers() async {
    final response =
        await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      return UserModel.fromJson(jsonData);
    } else {
      throw Exception("Failed to load user");
    }
  }

  final String apiKey = 'e991664226354a229291d8f3bd6d41c9';
  final String country = 'us';
  final String category = 'business';

  Future<NewsModel> fetchTopHeadlines() async {
    // Build the URI with query parameters
    final uri = Uri.https('newsapi.org', '/v2/top-headlines', {
      'country': country,
      'category': category,
      'apiKey': apiKey, // Your API key here
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      return NewsModel.fromJson(jsonData); // Handle the parsed data here
    } else {
      throw Exception("Failed to load news");
    }
  }

  @override
  Future<bool> login(String email,String password) async{
    final url = Uri.https('reqres.in','/api/login');
    final Map<String,dynamic> body = {
      'email': email,
      'password': password,
    };
    final response = await http.post(url,body: body);
    if(response.statusCode == 200){
      Map<String, dynamic> jsonData = json.decode(response.body);
      return jsonData.containsKey('token');
    }else{
      throw Exception("Login failed: ${response.body}");
    }
  }
}
