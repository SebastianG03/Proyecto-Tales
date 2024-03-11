import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../layers/domain/entities/user/users.dart';

///Permite obtener y establecer las preferencias de notificaciones y el id del usuario.
class Preferences {
  final String _notificationPreferences = "allowNotifications";
  final String _userData = "userData";
  final SharedPreferences instance;

  Preferences({required this.instance});

  bool getAllowNotifications() {
    return instance.getBool(_notificationPreferences) ?? true;
  }

  Future<bool> setAllowNotifications(bool value) async {
    return instance.setBool(_notificationPreferences, value);
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
    return instance.setString(_userData, userData);
  }

  void clearUserData() {
    instance.remove(_userData);
  }
}
