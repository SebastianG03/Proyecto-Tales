import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:proyecto_pasantia/layers/infrastructure/inputs/inputs.dart';

final loginFormProvider =
    StateNotifierProvider<LoginFormNotifier, LoginFormState>(
  (ref) => LoginFormNotifier(),
);

class LoginFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;

  LoginFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
  }) {
    return LoginFormState(
      isPosting: isPosting ?? this.isPosting,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isValid: isValid ?? this.isValid,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  String toString() {
    return '''LoginFormState{
      isPosting: $isPosting,
      isFormPosted: $isFormPosted,
      isValid: $isValid,
      email: $email,
       password: $password}''';
  }
}

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  LoginFormNotifier() : super(LoginFormState());

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

  void onSubmit() {
    _validateAll();
    if (!state.isValid) return;
  }

  void _posting() async {
    state = state.copyWith(isPosting: true);
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
