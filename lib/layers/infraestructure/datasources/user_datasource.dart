// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuentos_pasantia/layers/domain/datasources/user_datasource_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

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
  ///No es recomendable utilizar este método para actualizar información de los cuentos
  ///del usuario. Dado que puede reemplazar todos los cuentos y ocasionar pérdida de información si es aplicado
  ///incorrectamente.
  @override
  Future<bool> updateUser(UserModel user) async {
    try {
      await _usersCollection.doc(user.id).update(user.toJson());
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  Future<void> updateUserTale(String userId, UserTales userTale) async {
    try {
      final user = await getUserById(userId);
      final userTales = user.getUserModelTales;
      int index =
          userTales.indexWhere((tale) => tale.taleId == userTale.taleId);

      if (index != -1) {
        userTales.remove(userTale);
        userTales.add(userTale);
      } else {
        userTales.add(userTale);
      }

      await _usersCollection.doc(userId).update(
          {'userModelTales': userTales.map((e) => e.toJson()).toList()});
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<bool> userTaleExists(String userId, String taleId) async {
    try {
      final query = await _usersCollection
          .where('id', isEqualTo: userId)
          .where('userModelTales', arrayContains: taleId)
          .get();
      return query.docs.isNotEmpty;
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<UserTales> getUserTale(String userId, String taleId) async {
    try {
      final user = await getUserById(userId);
      int index =
          user.getUserModelTales.indexWhere((tale) => tale.taleId == taleId);
      return (index != -1)
          ? user.getUserModelTales[index]
          : throw Exception(
              'No se encontró el cuento, intente de nuevo más tarde');
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<UserTales>> getUserTales(String userId, int page) async {
    try {
      final user = await getUserById(userId);

      return user.getUserModelTales;
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<UserTales>> getUserTalesByStatus(
      String userId, UserTalesStatus status, int page) async {
    try {
      final user = await getUserById(userId);

      final limit = page * 10;

      return user.getUserModelTales
          .where((value) => value.progress == status)
          .take(limit)
          .toList();
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
