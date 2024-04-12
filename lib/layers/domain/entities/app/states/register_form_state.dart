import '../../../../infraestructure/inputs/inputs.dart';

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
