import '../entities/user/users.dart';

abstract class UserDatasourceModel {
  void uploadUserInfo(UserModel user);
  Future<UserModel> getUserById(String id);
  bool checkUserExists(String id);
  Future<bool> updateUser(UserModel user);
}
