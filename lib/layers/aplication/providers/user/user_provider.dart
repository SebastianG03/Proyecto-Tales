import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_pasantia/layers/domain/entities/user/users.dart';
import 'package:proyecto_pasantia/layers/infrastructure/repositories/user_repository.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/widgets/custom/alert_dialog.dart';

final userDatasourceProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});

final userSignInProvider =
    StateNotifierProvider<SignInNotifier, UserRepository>(
        (ref) => SignInNotifier());

class SignInNotifier extends StateNotifier<UserRepository> {
  SignInNotifier() : super(UserRepository());

  Future<UserModel> getUserById(
      {required BuildContext context, required String userId}) async {
    try {
      return await state.getUserById(userId);
    } catch (e) {
      CustomAlertDialog.showAlertDialog(
          context, 'Error', 'No se pudo obtener la información del usuario.');
      rethrow;
    }
  }

  Future<UserModel> signInWithEmailAndPassword(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      return state.signInWithEmailAndPassword(email, password);
    } catch (e) {
      CustomAlertDialog.showAlertDialog(
          context, 'Error al iniciar sesión', 'No se pudo iniciar sesión');
      rethrow;
    }
  }

  Future<UserModel> signInWithGoogle({required BuildContext context}) async {
    try {
      return state.googleSignIn();
    } catch (e) {
      CustomAlertDialog.showAlertDialog(
          context, 'Error al iniciar sesión', 'No se pudo iniciar sesión');
      rethrow;
    }
  }

  void signOut(bool isGoogleSigned) {
    state.signOut(isGoogleSigned);
  }
}
