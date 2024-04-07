import 'package:cuentos_pasantia/config/preferences/preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final preferencesProvider = Provider<Future<Preferences>>((ref) async {
  final instance = await SharedPreferences.getInstance();
  return Preferences(instance: instance);
});
