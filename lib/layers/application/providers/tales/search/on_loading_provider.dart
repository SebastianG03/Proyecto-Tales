import 'package:cuentos_pasantia/layers/application/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialSearchLoadingProvider = Provider<bool>((ref) {
  final step1 = ref.watch(searchProvider).isEmpty;

  if (step1) return true;

  return false; // terminamos de cargar
});
