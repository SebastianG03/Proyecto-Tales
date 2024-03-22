import 'package:cuentos_pasantia/layers/domain/entities/user/user_tales.dart';
import 'package:cuentos_pasantia/layers/domain/entities/user/user_tales_status.dart';

abstract class UserTalesRepositoryModel {
  Future<List<UserTales>> getUserTales(String userId, int page);
  Future<List<UserTales>> getUserTalesByStatus(
      String userId, UserTalesStatus status, int page);
  Future<UserTales> getUserTale(String userId, String taleId);
  Future<void> updateUserTale(String userId, UserTales userTale);
  Future<bool> userTaleExists(String userId, String taleId);
}
