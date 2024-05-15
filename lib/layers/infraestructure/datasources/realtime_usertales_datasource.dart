import 'package:cuentos_pasantia/layers/domain/entities/user/user_tales.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class RealtimeUserTalesDatasource {
  final _dbInstance = FirebaseDatabase.instance;
  final _userTales = FirebaseDatabase.instance.ref('usertales');

  void configureDatabase() {
    _dbInstance.setPersistenceEnabled(true);
    _dbInstance.setLoggingEnabled(true);
  }

  void updateUserTales(String userId, UserTales usertale) async {
    final userTalesSnapshot = await _userTales.child(userId).get();
    List<UserTales> userTales = userTalesSnapshot.children
        .map((val) => UserTales.fromJson(val as Map<String, dynamic>))
        .toList();

    userTales = _updateList(userTales, usertale);

    await _userTales
        .child(userId)
        .set(userTales.map((e) => e.toJson()).toList());
  }

  Future<bool> userTaleExists(String userId, String taleId) async {
    try {
      final snapshot = await _userTales.child(userId).get();
      final usertales = snapshot.children
          .map((val) => UserTales.fromJson(val as Map<String, dynamic>))
          .toList();

      return usertales.where((data) => data.taleId == taleId).isNotEmpty;
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  void getUserTaleStatus() {}

  Future<UserTales> getUserTale(String userId, String taleId) async {
      try {
        final exists = await userTaleExists(userId, taleId);
        if (exists) {
          final snapshot = await _userTales.child(userId).get();
          final usertales = snapshot.children
              .map((val) => UserTales.fromJson(val as Map<String, dynamic>))
              .toList();

          return usertales.where((data) => data.taleId == taleId).first;
        } else {
          return throw Exception(
              'Usertale with id $taleId from user $userId not found');
        }
      } catch (e) {
        rethrow;
      }
  }

  Future<List<UserTales>> getUserTales(String userId) async {
    try {
      final snapshot = await _userTales.child(userId).get();
      final usertales = snapshot.children
          .map((val) => UserTales.fromJson(val as Map<String, dynamic>))
          .toList();
      return usertales;
    } catch (e) {
      rethrow;
    }
  }

  List<UserTales> _updateList(List<UserTales> usertales, UserTales usertale) {
    int index = usertales.indexWhere((tale) => tale.taleId == usertale.taleId);

    if (index != -1) {
      usertales.remove(usertales[index]);
      usertales.add(usertale);
    } else {
      usertales.add(usertale);
    }

    return usertales;
  }
}
