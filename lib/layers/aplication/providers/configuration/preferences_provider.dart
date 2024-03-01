import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_pasantia/config/preferences/preferences.dart';
import 'package:proyecto_pasantia/layers/domain/entities/user/user.dart';

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
}
