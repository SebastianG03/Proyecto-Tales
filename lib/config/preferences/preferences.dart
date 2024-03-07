import 'dart:convert';

import 'package:proyecto_pasantia/layers/domain/entities/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Permite obtener y establecer las preferencias de notificaciones y el id del usuario.
class Preferences {
  final String _notificationPreferences = "allowNotifications";
  final String _userData = "userData";

  Preferences();

  Future<bool> getAllowNotifications() async {
    final instance = await SharedPreferences.getInstance();
    return instance.getBool(_notificationPreferences) ?? true;
  }

  Future<bool> setAllowNotifications(bool value) async {
    final instance = await SharedPreferences.getInstance();
    return instance.setBool(_notificationPreferences, value);
  }

  Future<UserModel?> getUserData() async {
    final instance = await SharedPreferences.getInstance();
    final data = instance.getString(_userData);
    if (data != null && data != "") {
      return UserModel.fromJson(jsonDecode(data));
    }
    return null;
  }

  Future<bool> setUserData(Map<String, dynamic> json) async {
    final instance = await SharedPreferences.getInstance();
    String userData = jsonEncode(json);
    return instance.setString(_userData, userData);
  }

  Future<void> clearUserData() async {
    final instance = await SharedPreferences.getInstance();
    instance.remove(_userData);
  }
}
