import 'package:cuentos_pasantia/layers/domain/entities/user/user_tales.dart';

abstract class UserTalesRepositoryModel {
  Future<List<UserTales>> getUserTales(String userId);
  Future<UserTales> getUserTale(String userId, String taleId);
  Future<void> updateUserTale(String userId, UserTales userTale);
  Future<bool> userTaleExists(String userId, String taleId);
}
