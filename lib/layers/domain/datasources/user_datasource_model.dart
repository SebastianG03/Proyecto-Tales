import '../entities/user/users.dart';

abstract class UserDatasourceModel {
  void uploadUserInfo(UserModel user);
  Future<UserModel> getUserById(String id);
  bool checkUserExists(String id);
  Future<bool> updateUser(UserModel user);
  Future<List<UserTales>> getUserTales(String userId, int page);
  Future<List<UserTales>> getUserTalesByStatus(
      String userId, UserTalesStatus status, int page);
  Future<UserTales> getUserTale(String userId, String taleId);
  void updateUserTale(String userId, UserTales userTale);
  Future<bool> userTaleExists(String userId, String taleId);
}
