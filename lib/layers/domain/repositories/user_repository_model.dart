import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyecto_pasantia/layers/domain/entities/user/user.dart';
// import 'package:proyecto_pasantia/layers/domain/entities/user/user_tales.dart';

abstract class UserRepositoryModel {
  Future<UserModel> googleSignIn();
  Future<UserModel> signInWithEmailAndPassword(String email, String password);
  Future<bool> createUserWithEmailAndPassword(
      {required String name,
      required int age,
      required String email,
      required String password});
  Future<UserModel> getUserById(String id);
  Future<bool> updateUser(UserModel user);
  // Future<UserTales> getUserTalesByUserId(String userId);
  // Future<void> updateUserTales(UserTales userTales, String userId);
  Future<void> signOut(bool isGoogleSignIn);
  Future<void> sendPasswordResetEmail(String email);
  Future<void> changePassword(String password);
  Future<void> changeEmail(String email);
  Future<bool> isGoogleSigned();
  Stream<User?> userAuthChanges();
}
