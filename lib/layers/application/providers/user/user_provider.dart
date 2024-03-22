import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/user/users.dart';
import '../../../infraestructure/repositories/user_auth_repository.dart';
import '../../../presentation/widgets/custom/custom_components.dart';

final userDatasourceProvider = Provider<UserAuthRepository>((ref) {
  return UserAuthRepository();
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
  final UserAuthRepository repository;
  SignInNotifier()
      : repository = UserAuthRepository(),
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

  Future<void> signInWithGoogle({required BuildContext context}) async {
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
