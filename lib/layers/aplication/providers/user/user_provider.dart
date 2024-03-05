import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_pasantia/layers/domain/entities/user/users.dart';
import 'package:proyecto_pasantia/layers/infrastructure/repositories/user_repository.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/widgets/custom/alert_dialog.dart';

final userDatasourceProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});

final userSignInProvider =
    StateNotifierProvider<SignInNotifier, UserState>((ref) => SignInNotifier());

final authUserProvider = StreamProvider<User?>((ref) =>
    ref.watch(userSignInProvider.notifier).repository.userAuthChanges());

class UserState extends ChangeNotifier {
  final UserModel? user;
  final bool isGoogleSigned;
  UserState({this.user, this.isGoogleSigned = false});

  copyWith({UserModel? user, bool? isGoogleSigned}) {
    return UserState(
      user: user ?? this.user,
      isGoogleSigned: isGoogleSigned ?? this.isGoogleSigned,
    );
  }
}

class SignInNotifier extends StateNotifier<UserState> {
  final UserRepository repository;
  SignInNotifier()
      : repository = UserRepository(),
        super(UserState());

  void getUserById(
      {required BuildContext context, required String userId}) async {
    try {
      final user = await repository.getUserById(userId);
      state = state.copyWith(user: user);
    } catch (e) {
      if (context.mounted) {
        CustomAlertDialog.showAlertDialog(context, 'Error',
            'No se pudo obtener la información del usuario.', null, null);
      }
      rethrow;
    }
  }

  void signInWithEmailAndPassword(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      final user = await repository.signInWithEmailAndPassword(email, password);
      state = state.copyWith(user: user);
    } catch (e) {
      if (context.mounted) {
        CustomAlertDialog.showAlertDialog(context, 'Error al iniciar sesión',
            'No se pudo iniciar sesión', null, null);
      }
      rethrow;
    }
  }

  void signInWithGoogle({required BuildContext context}) async {
    try {
      final user = await repository.googleSignIn();
      state = state.copyWith(user: user, isGoogleSigned: true);
    } catch (e) {
      if (context.mounted) {
        CustomAlertDialog.showAlertDialog(context, 'Error al iniciar sesión',
            'No se pudo iniciar sesión', null, null);
      }
      rethrow;
    }
  }

  void signOut(bool isGoogleSigned) {
    repository.signOut(isGoogleSigned);
    state = state.copyWith(user: null, isGoogleSigned: false);
  }
}
