import 'package:proyecto_pasantia/layers/domain/entities/user/user_tales.dart';

/// La clase UserModel representa al usuario de la aplicación, los parámetros de name, email
/// y password los ingresa el usuario y son obligatorios. No obstante, el parámetro id 
/// será obtenido al momento de registrar el usuario mediante Firebase. Además, la edad
/// la ingresará el usuario al momento de configurar su cuenta.
class UserModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final int? age;
  final bool suscription;
  final List<UserTales> _userModelTales = <UserTales>[];

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.age,
    this.suscription = false,
  });

  get getUserModelTales => _userModelTales;
  set addUserModelTale(UserTales userModelTale) =>
      _userModelTales.add(userModelTale);
  void updateUserModelTale(UserTales userModelTale) {
    final index = _userModelTales
        .indexWhere((element) => element.tale == userModelTale.tale);
    _userModelTales[index] = userModelTale;
  }

  void deleteUserModelTale(UserTales userModelTale) =>
      _userModelTales.remove(userModelTale);
}
