// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proyecto_pasantia/layers/domain/entities/user/user.dart';

class UserDatasource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  ///Registro de usuarios mediante email y contraseña
  ///Retorna un valor booleano que indica si el registro fue exitoso.
  Future<bool> createUserWithEmailAndPassword(
      String name, int age, String email, String password) async {
    try {
      final UserCredential credentials = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      UserModel user = UserModel(
        id: credentials.user!.uid,
        email: (credentials.user!.email)!,
        name: name,
        age: age,
        suscription: false,
      );
      _uploadUserInfo(user);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  ///Creación de registro de usuarios en la base de datos.
  void _uploadUserInfo(UserModel user) {
    if (!_checkUserExists(user.id)) {
      _usersCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(user.toJson());
    }
    throw ('El usuario ya existe.');
  }

  ///Obtención de información de usuario mediante su id.
  Future<UserModel> getUserById(String id) async {
    try {
      final DocumentSnapshot user = await _usersCollection.doc(id).get();
      return UserModel.fromJson(user.data() as Map<String, dynamic>);
    } on Exception catch (_) {
      throw ('''No se pudo obtener la información del usuario.
       El usuario no existe o no se encuentra registrado''');
    }
  }

  bool _checkUserExists(String id) {
    _usersCollection.doc(id).get().then((value) {
      if (value.exists) {
        return true;
      } else {
        return false;
      }
    });
    return false;
  }

  ///Actualización de información de usuario.
  Future<bool> updateUser(UserModel user) async {
    try {
      await _usersCollection.doc(user.id).update(user.toJson());
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  //Inicio de sesión mediante email y contraseña, y Google.
  Future<UserModel> signWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential credentials = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final UserModel user = await getUserById(credentials.user!.uid);
      return user;
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
        message = 'No se encontró el email ingresado.';
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
        message = 'Contraseña incorrecta.';
      }
      throw message;
    }
  }

  Future<UserModel> signInWithGoogle() async {
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
      final bool exists = _checkUserExists(userCredentials.user!.uid);
      UserModel user = UserModel(
          id: userCredentials.user!.uid,
          email: userCredentials.user!.email!,
          name: userCredentials.user!.displayName!,
          age: 0,
          suscription: false);
      if (!exists)
        _uploadUserInfo(user);
      else
        user = await getUserById(userCredentials.user!.uid);
      return user;
    } catch (e) {
      debugPrint(e.toString());
      throw ('No se pudo iniciar sesión con Google.');
    }
  }

  //Sign out
  Future<bool> signOut(bool isGoogleSignIn) async {
    try {
      if (isGoogleSignIn) {
        await GoogleSignIn().signOut();
      }
      await _auth.signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}
