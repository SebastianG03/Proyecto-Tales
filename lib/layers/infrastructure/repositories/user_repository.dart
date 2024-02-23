import 'package:proyecto_pasantia/layers/domain/entities/user/user.dart';
import 'package:proyecto_pasantia/layers/domain/repositories/user_repository_model.dart';
import 'package:proyecto_pasantia/layers/infrastructure/datasources/user_datasource.dart';

class UserRepository extends UserRepositoryModel {
  final UserDatasource datasource;

  UserRepository() : datasource = UserDatasource();

  @override
  Future<bool> createUserWithEmailAndPassword(
      {required String name,
      required int age,
      required String email,
      required String password}) {
    return datasource.createUserWithEmailAndPassword(
        name, age, email, password);
  }

  @override
  Future<UserModel> getUserById(String id) {
    return datasource.getUserById(id);
  }

  @override
  Future<UserModel> googleSignIn() {
    try {
      return datasource.signInWithGoogle();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(String email, String password) {
    try {
      return datasource.signWithEmailAndPassword(email, password);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut(bool isGoogleSignIn) {
    return datasource.signOut(isGoogleSignIn);
  }

  @override
  Future<bool> updateUser(UserModel user) {
    return datasource.updateUser(user);
  }
}
