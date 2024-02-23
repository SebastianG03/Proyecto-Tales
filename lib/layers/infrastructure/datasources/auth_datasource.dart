import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proyecto_pasantia/layers/domain/datasources/auth_datasource_model.dart';

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
  Future<void> changeEmail(String email) async {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<void> changePassword(String password) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
