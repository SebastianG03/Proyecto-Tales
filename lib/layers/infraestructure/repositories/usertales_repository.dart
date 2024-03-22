import 'package:cuentos_pasantia/layers/domain/entities/user/user_tales.dart';
import 'package:cuentos_pasantia/layers/domain/entities/user/user_tales_status.dart';
import 'package:cuentos_pasantia/layers/domain/repositories/usertales_repository_model.dart';
import 'package:cuentos_pasantia/layers/infraestructure/datasources/user_datasource.dart';

class UserTalesRepository extends UserTalesRepositoryModel {
  final UserDatasource userDatasource;

  UserTalesRepository() : userDatasource = UserDatasource();

  @override
  Future<UserTales> getUserTale(String userId, String taleId) {
    return userDatasource.getUserTale(userId, taleId);
  }

  @override
  Future<List<UserTales>> getUserTales(String userId, int page) {
    return userDatasource.getUserTales(userId, page);
  }

  @override
  Future<void> updateUserTale(String userId, UserTales userTale) async {
    await userDatasource.updateUserTale(userId, userTale);
  }

  @override
  Future<List<UserTales>> getUserTalesByStatus(
      String userId, UserTalesStatus status, int page) {
    return userDatasource.getUserTalesByStatus(userId, status, page);
  }

  @override
  Future<bool> userTaleExists(String userId, String taleId) {
    return userDatasource.userTaleExists(userId, taleId);
  }
}
