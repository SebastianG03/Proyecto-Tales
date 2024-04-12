import 'package:firebase_auth/firebase_auth.dart';

import '../entities/user/user.dart';
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
  String getActualUserId();
  User getActualUser();
  Future<bool> updateUser(UserModel user);
  // Future<UserTales> getUserTalesByUserId(String userId);
  // Future<void> updateUserTales(UserTales userTales, String userId);
  Future<void> signOut(bool isGoogleSignIn);
  Future<void> sendEmailToChangePassword(String email);
  String changeEmail(String newEmail);
  Future<bool> isGoogleSigned();
  Stream<User?> userAuthChanges();
}
