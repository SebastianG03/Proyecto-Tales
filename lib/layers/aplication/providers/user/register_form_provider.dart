import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:proyecto_pasantia/layers/aplication/providers/providers.dart';
import 'package:proyecto_pasantia/layers/domain/entities/user/user.dart';
import 'package:proyecto_pasantia/layers/infrastructure/inputs/inputs.dart';
import 'package:proyecto_pasantia/layers/infrastructure/repositories/user_repository.dart';

final registerFormProvider =
    StateNotifierProvider<RegisterFormNotifier, RegisterFormState>((ref) {
  final register = ref.read(userDatasourceProvider);
  return RegisterFormNotifier(register);
});

class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;
  final Username username;
  final Age age;

  RegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.username = const Username.pure(),
    this.age = const Age.pure(),
  });

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
    Username? username,
    Age? age,
  }) {
    return RegisterFormState(
      isPosting: isPosting ?? this.isPosting,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isValid: isValid ?? this.isValid,
      email: email ?? this.email,
      password: password ?? this.password,
      username: username ?? this.username,
      age: age ?? this.age,
    );
  }

  @override
  String toString() {
    return '''RegisterFormState{
      isPosting: $isPosting,
      isFormPosted: $isFormPosted,
      isValid: $isValid,
      email: $email,
       password: $password}''';
  }
}

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  final UserRepository register;
  RegisterFormNotifier(this.register) : super(RegisterFormState());

  void emailChanged(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid:
          Formz.validate([newEmail, state.password, state.age, state.username]),
    );
  }

  void passwordChanged(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid:
          Formz.validate([newPassword, state.email, state.age, state.username]),
    );
  }

  void usernameChanged(String value) {
    final newUsername = Username.dirty(value);
    state = state.copyWith(
      username: newUsername,
      isValid:
          Formz.validate([newUsername, state.email, state.password, state.age]),
    );
  }

  void ageChanged(String value) {
    final newAge = Age.dirty(value);
    state = state.copyWith(
      age: newAge,
      isValid:
          Formz.validate([newAge, state.email, state.password, state.username]),
    );
  }

  void onSubmit() async {
    _validateAll();
    if (!state.isValid) return;
    state = state.copyWith(isPosting: true);
    register.createUserWithEmailAndPassword(
        name: state.username.value,
        age: int.parse(state.age.value),
        email: state.email.value,
        password: state.password.value);
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
