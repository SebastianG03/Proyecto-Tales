import 'package:cuentos_pasantia/layers/application/providers/tales/tales_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final step1 = ref.watch(sliderTalesProvider).isEmpty;
  final step2 = ref.watch(kidsTalesProvider).isEmpty;
  final step3 = ref.watch(teensTalesProvider).isEmpty;
  final step4 = ref.watch(freeTalesProvider).isEmpty;
  final step5 = ref.watch(premiumTalesProvider).isEmpty;

  if (step1 || step2 || step3 || step4 || step5) return true;

  return false; // terminamos de cargar
});
