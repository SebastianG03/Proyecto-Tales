import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthDatasourceModel {
  Future<String> signIn(String email, String password);
  Future<User> signInWithGoogle();
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<void> signOut(bool isGoogleSignIn);
  Future<void> sendPasswordResetEmail(String email);
  String changeEmail(String newEmail);
  Stream<User?> userAuthChanges();
  Future<bool> isGoogleSigned();
}
