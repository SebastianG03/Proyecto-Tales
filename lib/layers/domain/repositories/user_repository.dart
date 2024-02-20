import 'package:proyecto_pasantia/layers/domain/entities/user/user.dart';
import 'package:proyecto_pasantia/layers/domain/entities/user/user_tales.dart';

abstract class UserRepository {
  Future<UserModel> googleSignIn();
  Future<UserModel> signInWithEmailAndPassword(String email, String password);
  Future<UserModel> getById(String id);
  Future<bool> createUserWithEmailAndPassword(UserModel user);
  Future<bool> createUserWithGoogle(UserModel user);
  Future<bool> updateUser(UserModel user);
  Future<UserTales> getTales(UserModel user);
  Future<bool> signOut();
}
