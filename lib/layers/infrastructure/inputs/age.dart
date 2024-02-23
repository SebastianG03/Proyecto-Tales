// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:formz/formz.dart';

enum AgeError { format, empty, invalid }

class Age extends FormzInput<String, AgeError> {
  static final RegExp _ageRegExp = RegExp(r'^[0-9]+$');

  const Age.pure() : super.pure('');
  const Age.dirty([super.value = '']) : super.dirty();

  String? get errorMassage {
    if (isValid || isPure) return null;

    if (displayError == AgeError.empty) return 'El campo es obligatorio';
    if (displayError == AgeError.format)
      return 'El formato es incorrecto, solo se permiten números';
    if (displayError == AgeError.invalid)
      return 'La edad ingresada no es válida';

    return null;
  }

  @override
  AgeError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return AgeError.empty;
    if (!_ageRegExp.hasMatch(value)) return AgeError.format;
    if (int.tryParse(value) != null && int.tryParse(value) == 0 ||
        int.tryParse(value)! > 99) return AgeError.invalid;
    return null;
  }
}
