// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuentos_pasantia/layers/domain/datasources/user_datasource_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/ui/firebase_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

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
      final query = await _usersCollection.where('id', isEqualTo: id).get();
      final user =
          UserModel.fromJson(query.docs.first.data() as Map<String, dynamic>);
      debugPrint(
          'Id: ${user.id} | length usertales: ${user.getUserModelTales.length}');
      return user;
      // final DocumentSnapshot user = await _usersCollection.doc(id).get();
      // return UserModel.fromJson(user.data() as Map<String, dynamic>);
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
        final actualUserTale = _updateUserTale(userTales[index], userTale);
        userTales.remove(userTales[index]);
        userTales.add(actualUserTale);
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
      final user = await getUserById(userId);

      return user.getUserModelTales
          .where((doc) => doc.taleId == taleId)
          .isNotEmpty;
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<UserTales> getUserTale(String userId, String taleId) async {
    try {
      final user = await getUserById(userId);
      return user.getUserModelTales.where((doc) => doc.taleId == taleId).first;
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<UserTales>> getUserTales(String userId) async {
    try {
      final query = await _usersCollection.where('id', isEqualTo: userId).get();
      final user =
          UserModel.fromJson(query.docs.first.data() as Map<String, dynamic>);
      return user.getUserModelTales;
    } catch (e) {
      throw ('''No se pudo obtener la información del usuario.
       El usuario no existe o no se encuentra registrado,
       ${e.toString()}''');
    }
  }

  Stream<List<UserTales>> getStreamUserTales(String userId) async* {
    try {
      final Stream<QuerySnapshot<Object?>> query =
          _usersCollection.where('id', isEqualTo: userId).get().asStream();

      await for (var snapshot in query) {
        final user = UserModel.fromJson(
            snapshot.docs.first.data() as Map<String, dynamic>);
        yield user.getUserModelTales;
      }
    } catch (e) {
      throw ('''No se pudo obtener la información del usuario.
       El usuario no existe o no se encuentra registrado,
       ${e.toString()}''');
    }
  }

  UserTales _updateUserTale(UserTales oldUserTale, UserTales newUserTale) {
    //Compares both instances and selects the last content if is updated.
    String taleId = oldUserTale.taleId == newUserTale.taleId
        ? oldUserTale.taleId
        : newUserTale.taleId.isEmpty
            ? oldUserTale.taleId
            : newUserTale.taleId;
    String taleTitle = oldUserTale.taleTitle == newUserTale.taleTitle
        ? oldUserTale.taleTitle
        : newUserTale.taleTitle.isEmpty
            ? oldUserTale.taleTitle
            : newUserTale.taleTitle;
    String coverUrl = oldUserTale.coverUrl == newUserTale.coverUrl
        ? oldUserTale.coverUrl
        : newUserTale.coverUrl.isEmpty
            ? oldUserTale.coverUrl
            : newUserTale.coverUrl;
    UserTalesStatus progress = oldUserTale.progress == newUserTale.progress
        ? oldUserTale.progress
        : newUserTale.progress;
    int lastChapterReaded =
        oldUserTale.getLastChapterReaded == newUserTale.getLastChapterReaded
            ? oldUserTale.getLastChapterReaded
            : newUserTale.getLastChapterReaded == 0
                ? oldUserTale.getLastChapterReaded
                : newUserTale.getLastChapterReaded;
    String lastSectionReaded =
        oldUserTale.getLastSectionReaded == newUserTale.getLastSectionReaded
            ? oldUserTale.getLastSectionReaded
            : newUserTale.getLastSectionReaded.isEmpty
                ? oldUserTale.getLastSectionReaded
                : newUserTale.getLastSectionReaded;
    DateTime? lastTimeReaded = (oldUserTale.getLastTimeRead != null &&
            newUserTale.getLastTimeRead == null)
        ? oldUserTale.getLastTimeRead
        : (newUserTale.getLastTimeRead != null &&
                oldUserTale.getLastTimeRead == null)
            ? newUserTale.getLastTimeRead
            : (newUserTale.getLastTimeRead != null &&
                    oldUserTale.getLastTimeRead != null)
                ? (newUserTale.getLastTimeRead!
                        .isBefore(oldUserTale.getLastTimeRead!)
                    ? newUserTale.getLastTimeRead
                    : oldUserTale.getLastTimeRead)
                : null;

    UserTales actualUserTale = UserTales(
        taleId: taleId,
        taleTitle: taleTitle,
        coverUrl: coverUrl,
        progress: progress);
    actualUserTale.setLastChapterReaded = lastChapterReaded;
    actualUserTale.setLastSectionReaded = lastSectionReaded;
    actualUserTale.setLastTimeRead = lastTimeReaded;

    return actualUserTale;
  }

  // @override
  // Future<void> updateUserTale(String userId, UserTales userTale) async {
  //   final userTalesSnapshot = await _userTales.child(userId).get();
  //   List<UserTales> userTales = userTalesSnapshot.children
  //       .map((val) => UserTales.fromJson(val as Map<String, dynamic>))
  //       .toList();

  //   userTales = _updateList(userTales, userTale);

  //   await _userTales
  //       .child(userId)
  //       .set(userTales.map((e) => e.toJson()).toList());
  // }

  // @override
  // Future<bool> userTaleExists(String userId, String taleId) async {
  //   try {
  //     final snapshot = await _userTales.child(userId).get();
  //     final usertales = snapshot.children
  //         .map((val) => UserTales.fromJson(val as Map<String, dynamic>))
  //         .toList();

  //     return usertales.where((data) => data.taleId == taleId).isNotEmpty;
  //   } on Exception catch (e) {
  //     debugPrint(e.toString());
  //     rethrow;
  //   }
  // }

  // @override
  // Future<UserTales> getUserTale(String userId, String taleId) async {
  //   try {
  //     final snapshot = await _userTales.child(userId).get();
  //     final usertales = snapshot.children
  //         .map((val) => UserTales.fromJson(val as Map<String, dynamic>))
  //         .toList();

  //     return usertales.where((data) => data.taleId == taleId).first;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<List<UserTales>> getUserTales(String userId) async {
  //   try {
  //     final ref = FirebaseDatabase.instance.ref('usertales/$userId');
  //     final dataSnapshot = await ref.get();
  //     if (!dataSnapshot.exists) return [];
  //     final listSnapshot = dataSnapshot.value as List<dynamic>;
  //     final usertales = listSnapshot.map((val) {
  //       return UserTales.fromJson(Map<String, dynamic>.from(val));
  //     }).toList();
  //     return usertales;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // List<UserTales> _updateList(List<UserTales> usertales, UserTales usertale) {
  //   int index = usertales.indexWhere((tale) => tale.taleId == usertale.taleId);

  //   if (index == -1) return [usertale];

  //   final oldUsertale = usertales[index];
  //   usertale.progress = _updateUserTalesStatus(oldUsertale, usertale);

  //   if (index != -1) {
  //     usertales.remove(usertales[index]);
  //     usertales.add(usertale);
  //   } else {
  //     usertales.add(usertale);
  //   }

  //   return usertales;
  // }

  // List<UserTalesStatus> _updateUserTalesStatus(
  //     UserTales oldUsertale, UserTales newUsertale) {
  //   final List<UserTalesStatus> oldProgress = oldUsertale.progress;
  //   final List<UserTalesStatus> newProgress = newUsertale.progress;
  //   final List<UserTalesStatus> actualProgress = [];
  //   if (listEquals(oldProgress, newProgress)) return newProgress;

  //   if ((oldProgress.contains(UserTalesStatus.completed) ||
  //           newProgress.contains(UserTalesStatus.completed)) &&
  //       !actualProgress.contains(UserTalesStatus.completed)) {
  //     actualProgress.add(UserTalesStatus.completed);
  //   }
  //   if ((oldProgress.contains(UserTalesStatus.following) &&
  //               newProgress.contains(UserTalesStatus.following) ||
  //           !oldProgress.contains(UserTalesStatus.following) &&
  //               newProgress.contains(UserTalesStatus.following)) &&
  //       !actualProgress.contains(UserTalesStatus.following)) {
  //     actualProgress.add(UserTalesStatus.following);
  //   }
  //   if ((oldProgress.contains(UserTalesStatus.reading) &&
  //               newProgress.contains(UserTalesStatus.reading) ||
  //           !oldProgress.contains(UserTalesStatus.reading) &&
  //               newProgress.contains(UserTalesStatus.reading)) &&
  //       !actualProgress.contains(UserTalesStatus.reading)) {
  //     actualProgress.add(UserTalesStatus.reading);
  //   }

  //   return actualProgress;
  // }
}
