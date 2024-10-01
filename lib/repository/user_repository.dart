
import '../model/UserModel.dart';

abstract class UserRepository {
  Future<UserModel> fetchUsers();
}
