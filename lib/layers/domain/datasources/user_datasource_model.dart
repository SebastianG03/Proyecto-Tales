import '../entities/user/users.dart';

abstract class UserDatasourceModel {
  void uploadUserInfo(UserModel user);
  Future<UserModel> getUserById(String id);
  bool checkUserExists(String id);
  Future<bool> updateUser(UserModel user);
  Future<List<UserTales>> getTales(String userId);
  Future<String> getTale(String userId, String taleId);
  void addUserTale(String userId, UserTales userTale);
  void updateUserTale(String userId, UserTales userTale);
  bool userTaleExists(String userId, String taleId);
}
