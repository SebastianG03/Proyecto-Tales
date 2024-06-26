import 'package:cuentos_pasantia/layers/domain/datasources/auth_datasource_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthDatasource implements AuthDatasourceModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<String> signIn(String email, String password) async {
    try {
      final UserCredential credentials = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credentials.user!.uid;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) throw ('No se pudo iniciar sesión con Google.');
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredentials = await _auth.signInWithCredential(credentials);
      return userCredentials.user!;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential credentials = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return credentials.user!.uid;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> signOut(bool isGoogleSignIn) async {
    try {
      if (isGoogleSignIn) {
        await GoogleSignIn().signOut();
      }
      await _auth.signOut();
    } catch (_) {
      rethrow;
    }
  }

  @override
  String changeEmail(String newEmail) {
    User user = _auth.currentUser!;
    if (newEmail.compareTo(user.email!) == 0) {
      user.verifyBeforeUpdateEmail(newEmail);
      return "Se ha enviado una notificación a $newEmail. Por favor, confirme su correo.";
    } else {
      return "";
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  @override
  @override
  Future<bool> isGoogleSigned() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw StateError('No user is currently signed in');
      }
      return user.providerData.first.providerId == 'google.com';
    } catch (e) {
      return false;
    }
  }

  @override
  Stream<User?> userAuthChanges() {
    return _auth.userChanges();
  }
}
