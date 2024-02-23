abstract class AuthDatasourceModel {
  Future<String> signIn(String email, String password);
  Future<String> signInWithGoogle();
  Future<void> signOut(bool isGoogleSignIn);
  Future<void> sendPasswordResetEmail(String email);
  Future<void> changePassword(String password);
  Future<void> changeEmail(String email);
}
