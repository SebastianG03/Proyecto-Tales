import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_pasantia/config/preferences/preferences.dart';
import 'package:proyecto_pasantia/layers/domain/entities/user/user.dart';

///Administra las preferencias utilizando un [StateNotifier] y un [StateProvider].
///El [StateNotifier] es el encargado de manejar el estado y el [StateProvider] es
///el encargado de proveer el estado y de modificarlo.
///Ademas, el [StateNotifier] aplica un [ChangeNotifier] para notificar a la aplicación
///cuando su estado cambia.
final preferencesProvider =
    StateNotifierProvider<PreferencesNotifier, PreferencesState>(
        (ref) => PreferencesNotifier());

class PreferencesState extends ChangeNotifier {
  final UserModel? user;
  final bool allowNotification;

  PreferencesState({this.user, this.allowNotification = true});

  PreferencesState copyWith({UserModel? user, bool? allowNotification}) {
    return PreferencesState(
        user: user ?? this.user,
        allowNotification: allowNotification ?? this.allowNotification);
  }

  void notify() => notifyListeners();
}

class PreferencesNotifier extends StateNotifier<PreferencesState> {
  final Preferences prefs = Preferences();
  PreferencesNotifier() : super(PreferencesState());

  void setUserData(Map<String, dynamic> json) {
    prefs.setUserData(json);
    state = state.copyWith(user: UserModel.fromJson(json));
    state.notify();
  }

  void getUserData() async {
    final user = await prefs.getUserData();
    state = state.copyWith(user: user);
    state.notify();
  }

  void clearUserData() async {
    prefs.clearUserData();
    state = state.copyWith(user: null);
    state.notify();
  }

  void setAllowNotifications(bool value) {
    prefs.setAllowNotifications(value);
    state = state.copyWith(allowNotification: value);
    state.notify();
  }

  void getAllowNotifications() async {
    final allow = await prefs.getAllowNotifications();
    state = state.copyWith(allowNotification: allow);
    state.notify();
  }
}
