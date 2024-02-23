import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_pasantia/config/preferences/preferences.dart';
import 'package:proyecto_pasantia/layers/domain/entities/user/user.dart';

final preferencesProvider =
    StateNotifierProvider<PreferencesNotifier, Preferences>(
        (ref) => PreferencesNotifier());

class PreferencesNotifier extends StateNotifier<Preferences> {
  PreferencesNotifier() : super(Preferences());

  UserModel? user;
  bool allowNotification = true;

  void setUserData(Map<String, dynamic> json) {
    state.setUserData(json);
  }

  UserModel? getUserData() {
    _getUserId();
    return user;
  }

  void _getUserId() async {
    user = await state.getUserData();
  }

  void setAllowNotifications(bool value) {
    state.setAllowNotifications(value);
    if (value != allowNotification) allowNotification = value;
  }

  bool getAllowNotifications() {
    _getAllowNotification();
    return allowNotification;
  }

  void _getAllowNotification() async {
    allowNotification = await state.getAllowNotifications();
  }
}
