import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthDatasourceModel {
  Future<String> signIn(String email, String password);
  Future<User> signInWithGoogle();
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<void> signOut(bool isGoogleSignIn);
  Future<void> sendPasswordResetEmail(String email);
  Future<void> changePassword(String password);
  Future<void> changeEmail(String email);
}
