import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///Maneja el estado de la aplicación
///Puede tener los siguientes estados:
///Resumed, Inactive, Paused, Detached
final appStateProvider = StateProvider<AppLifecycleState>((ref) {
  return AppLifecycleState.resumed;
});
