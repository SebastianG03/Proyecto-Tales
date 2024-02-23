import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_pasantia/layers/domain/entities/user/users.dart';
import 'package:proyecto_pasantia/layers/infrastructure/datasources/user_datasource.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/widgets/custom/alert_dialog.dart';

final userDatasourceProvider = Provider<UserDatasource>((ref) {
  return UserDatasource();
});

final userSignInProvider =
    StateNotifierProvider<SignInNotifier, UserDatasource>(
        (ref) => SignInNotifier());

class SignInNotifier extends StateNotifier<UserDatasource> {
  SignInNotifier() : super(UserDatasource());

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
      return state.signWithEmailAndPassword(email, password);
    } catch (e) {
      CustomAlertDialog.showAlertDialog(
          context, 'Error al iniciar sesión', 'No se pudo iniciar sesión');
      rethrow;
    }
  }

  Future<UserModel> signInWithGoogle({required BuildContext context}) async {
    try {
      return state.signInWithGoogle();
    } catch (e) {
      CustomAlertDialog.showAlertDialog(
          context, 'Error al iniciar sesión', 'No se pudo iniciar sesión');
      rethrow;
    }
  }
}
