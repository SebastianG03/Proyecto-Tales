// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyecto_pasantia/layers/domain/datasources/user_datasource_model.dart';

import '../../domain/entities/user/users.dart';

class UserDatasource implements UserDatasourceModel {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  ///Creación de registro de usuarios en la base de datos.
  @override
  void uploadUserInfo(UserModel user) {
    if (!checkUserExists(user.id)) {
      _usersCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(user.toJson());
    } else {
      throw ('El usuario ya existe.');
    }
  }

  ///Obtención de información de usuario mediante su id.
  @override
  Future<UserModel> getUserById(String id) async {
    try {
      final DocumentSnapshot user = await _usersCollection.doc(id).get();
      return UserModel.fromJson(user.data() as Map<String, dynamic>);
    } on Exception catch (_) {
      throw ('''No se pudo obtener la información del usuario.
       El usuario no existe o no se encuentra registrado''');
    }
  }

  ///Verificación de existencia de usuario.
  ///Comprueba mediante el id si el usuario existe dentro de los registros.
  /// *Verdadero* si existe, *Falso* si no existe
  @override
  bool checkUserExists(String id) {
    _usersCollection.doc(id).get().then((value) {
      if (value.exists) {
        return true;
      } else {
        return false;
      }
    });
    return false;
  }

  ///Actualización de información de usuario.
  ///Este método solo será llamado cuando el usuario esté logueado.
  @override
  Future<bool> updateUser(UserModel user) async {
    try {
      await _usersCollection.doc(user.id).update(user.toJson());
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}
