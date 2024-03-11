import 'package:cuentos_pasantia/layers/application/providers/user/user_provider.dart';
import 'package:cuentos_pasantia/layers/infraestructure/repositories/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import '../../../domain/entities/app/states/states.dart';
import '../../../infraestructure/inputs/inputs.dart';

final registerFormProvider =
    StateNotifierProvider<RegisterFormNotifier, RegisterFormState>((ref) {
  final register = ref.read(userDatasourceProvider);
  return RegisterFormNotifier(register);
});

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
