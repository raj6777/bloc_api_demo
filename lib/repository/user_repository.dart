import 'package:api_calling_bloc_mvvm_demo/model/NewsModel.dart';

import '../model/UserModel.dart';

abstract class UserRepository {
  Future<UserModel> fetchUsers();

  Future<NewsModel> fetchTopHeadlines();

  Future<bool> login(String email, String password);
}
