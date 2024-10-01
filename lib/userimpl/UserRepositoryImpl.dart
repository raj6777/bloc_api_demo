import 'dart:convert';

import 'package:api_calling_bloc_mvvm_demo/model/UserModel.dart';

import '../repository/user_repository.dart';
import 'package:http/http.dart' as http;

class UserRepositoryImpl implements UserRepository {
  @override
  Future<UserModel> fetchUsers() async {
    final response =
        await http.get(Uri.parse("https://reqres.in/api/users?per_page=12"));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      return UserModel.fromJson(jsonData);
    } else {
      throw Exception("Failed to load user");
    }
  }
 }

