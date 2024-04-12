import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../layers/domain/entities/user/users.dart';

///Permite obtener y establecer las preferencias de notificaciones y el id del usuario.
class Preferences {
  final String _notificationPreferences = "allowNotifications";
  final String _userData = "userData";
  final String _userId = "userId";
  final SharedPreferences instance;

  Preferences({required this.instance});

  bool getAllowNotifications() {
    return instance.getBool(_notificationPreferences) ?? true;
  }

  Future<bool> setAllowNotifications(bool value) async {
    return await instance.setBool(_notificationPreferences, value);
  }

  String getUserId() {
    return instance.getString(_userId) ?? "";
  }

  Future<bool> setUserId(String id) async {
    return await instance.setString(_userId, id);
  }

  UserModel? getUserData() {
    debugPrint(instance.toString());
    final data = instance.getString(_userData);
    debugPrint(data);
    if (data != null && data != "") {
      return UserModel.fromJson(jsonDecode(data));
    }
    return null;
  }

  Future<bool> setUserData(Map<String, dynamic> json) async {
    String userData = jsonEncode(json);
    return await instance.setString(_userData, userData);
  }

  void clearUserData() {
    instance.remove(_userData);
  }

  void clearUserId() {
    instance.remove(_userId);
  }
}
