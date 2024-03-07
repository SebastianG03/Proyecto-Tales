import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:proyecto_pasantia/layers/aplication/providers/providers.dart';
import 'package:proyecto_pasantia/layers/infrastructure/inputs/inputs.dart';
import 'package:proyecto_pasantia/layers/domain/entities/app/states/states.dart';

final loginFormProvider =
    StateNotifierProvider<LoginFormNotifier, LoginFormState>(
  (ref) {
    final loginCallback =
        ref.read(userSignInProvider.notifier).signInWithEmailAndPassword;
    final notifier = ref.watch(userSignInProvider);
    final prefs = ref.watch(preferencesProvider.notifier).setUserData;
    return LoginFormNotifier(loginCallback, prefs, notifier);
  },
);

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  final void Function(
      {required BuildContext context,
      required String email,
      required String password}) loginCallback;
  void Function(Map<String, dynamic> json) prefs;
  final UserState notifier;
  LoginFormNotifier(
    this.loginCallback,
    this.prefs,
    this.notifier,
  ) : super(LoginFormState());

  void emailChanged(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail, state.password]),
    );
  }

  void passwordChanged(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([newPassword, state.email]),
    );
  }

  void onSubmit(BuildContext context) async {
    _validateAll();
    if (!state.isValid) return;

    state = state.copyWith(isPosting: true);
    loginCallback(
        context: context,
        email: state.email.value,
        password: state.password.value);
    final user = notifier.user;
    debugPrint(user?.name ?? 'Null user');
    prefs(user!.toJson());
    state = state.copyWith(isPosting: false);
  }

  void _validateAll() {
    final Email newEmail = Email.dirty(state.email.value);
    final Password newPassword = Password.dirty(state.password.value);

    state = state.copyWith(
      isFormPosted: true,
      email: newEmail,
      password: newPassword,
      isValid: Formz.validate([newEmail, newPassword]),
    );
  }
}
