import 'package:cuentos_pasantia/layers/infraestructure/datasources/auth_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user/user.dart';
import '../../domain/repositories/user_repository_model.dart';
import '../datasources/user_datasource.dart';

class UserAuthRepository extends UserRepositoryModel {
  final UserDatasource userDatasource;
  final AuthDatasource authDatasource;

  UserAuthRepository()
      : userDatasource = UserDatasource(),
        authDatasource = AuthDatasource();

  @override
  Future<bool> createUserWithEmailAndPassword(
      {required String name,
      required int age,
      required String email,
      required String password}) async {
    final id =
        await authDatasource.createUserWithEmailAndPassword(email, password);
    userDatasource
        .uploadUserInfo(UserModel(id: id, name: name, email: email, age: age));
    return true;
  }

  @override
  Future<UserModel> getUserById(String id) {
    return userDatasource.getUserById(id);
  }

  @override
  String getActualUserId() {
    return FirebaseAuth.instance.currentUser?.uid ?? '';
  }

  @override
  User getActualUser() {
    return FirebaseAuth.instance.currentUser!;
  }

  @override
  Future<UserModel> googleSignIn() async {
    try {
      final user = await authDatasource.signInWithGoogle();
      UserModel userModel =
          UserModel(id: user.uid, name: user.displayName!, email: user.email!);
      userDatasource.uploadUserInfo(userModel);
      return userModel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final id = await authDatasource.signIn(email, password);
      return userDatasource.getUserById(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut(bool isGoogleSignIn) {
    return authDatasource.signOut(isGoogleSignIn);
  }

  @override
  Future<bool> updateUser(UserModel user) {
    return userDatasource.updateUser(user);
  }

  @override
  String changeEmail(String newEmail) {
    User user = FirebaseAuth.instance.currentUser!;
    if (newEmail.compareTo(user.email!) == 0) {
      user.verifyBeforeUpdateEmail(newEmail);
      return "Se ha enviado una notificación a $newEmail. Por favor, confirme su correo.";
    } else {
      return "";
    }
  }

  @override
  Future<void> sendEmailToChangePassword(String email) async {
    await authDatasource.sendPasswordResetEmail(email);
  }

  @override
  Future<bool> isGoogleSigned() {
    return authDatasource.isGoogleSigned();
  }

  @override
  Stream<User?> userAuthChanges() {
    return authDatasource.userAuthChanges();
  }
}
