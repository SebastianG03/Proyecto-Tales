import 'package:proyecto_pasantia/layers/domain/entities/user/user_tales.dart';

/// La clase UserModel representa al usuario de la aplicación, los parámetros de name, email
/// y password los ingresa el usuario y son obligatorios. No obstante, el parámetro id
/// será obtenido al momento de registrar el usuario mediante Firebase. Además, la edad
/// la ingresará el usuario al momento de configurar su cuenta.

class UserModel {
  final String id;
  final String name;
  final String email;
  final int? age;
  final bool suscription;
  final List<UserTales> _userModelTales = <UserTales>[];

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.age,
    this.suscription = false,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        age = json['age'],
        suscription = json['suscription'] {
    if (json['userModelTales'] != null) {
      _userModelTales.clear();
      json['userModelTales'].forEach((v) {
        _userModelTales.add(UserTales.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'age': age,
      'suscription': suscription,
      'userModelTales': _userModelTales.map((e) => e.toJson()).toList(),
    };
  }

  get getUserModelTales => _userModelTales;
  bool addUserModelTale(UserTales userModelTale) {
    if (!_userModelTales.contains(userModelTale)) {
      _userModelTales.add(userModelTale);
      return true;
    }
    return false;
  }

  void updateUserModelTale(UserTales userModelTale) {
    int index = _userModelTales.indexOf(userModelTale);
    if (index != -1) {
      _userModelTales[index] = userModelTale;
    }
  }

  void deleteUserModelTale(UserTales userModelTale) =>
      _userModelTales.remove(userModelTale);
}
