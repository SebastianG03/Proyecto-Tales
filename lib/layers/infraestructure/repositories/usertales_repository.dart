import 'package:cuentos_pasantia/layers/domain/entities/user/user_tales.dart';
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
  Future<List<UserTales>> getUserTales(String userId) {
    return userDatasource.getUserTales(userId);
  }

  @override
  Future<void> updateUserTale(String userId, UserTales userTale) async {
    await userDatasource.updateUserTale(userId, userTale);
  }

  @override
  Future<bool> userTaleExists(String userId, String taleId) {
    return userDatasource.userTaleExists(userId, taleId);
  }
}
