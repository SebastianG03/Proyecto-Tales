// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:formz/formz.dart';

enum UsernameError { invalid, empty, length }

class Username extends FormzInput<String, UsernameError> {
  const Username.pure() : super.pure('');

  const Username.dirty([super.value = '']) : super.dirty();

  static final _usernameRegex = RegExp(r'^[a-zA-Z0-9]+$');

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == UsernameError.empty) return 'El campo es requerido';
    if (displayError == UsernameError.length)
      return 'Mínimo 5 caracteres y maximo 18';
    if (displayError == UsernameError.invalid)
      return 'Solo se permiten letras y números';

    return null;
  }

  @override
  UsernameError? validator(String value) {
    if (value.trim().isEmpty || value.isEmpty) return UsernameError.empty;
    if (!_usernameRegex.hasMatch(value)) return UsernameError.invalid;
    if (value.length < 5 || value.length > 18) return UsernameError.length;
    return null;
  }
}
