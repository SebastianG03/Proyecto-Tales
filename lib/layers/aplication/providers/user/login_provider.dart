import 'package:flutter_riverpod/flutter_riverpod.dart';

final usernameProvider = StateProvider<String>((ref) {
  return '';
});

final emailProvider = StateProvider<String>((ref) {
  return '';
});

final passwordProvider = StateProvider<String>((ref) {
  return '';
});

final ageProvider = StateProvider<int>((ref) {
  return 0;
});
