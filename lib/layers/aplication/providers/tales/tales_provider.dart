import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_pasantia/layers/infrastructure/repositories/tales_repository.dart';

import '../../../domain/entities/app/search/enums/enums.dart';
import '../../../domain/entities/tales/tales_exports.dart';

final talesRepositoryProvider = Provider((ref) => TalesRepository());

/// **talesNotifierProvider** es un [StateNotifierProvider] que se encarga de
///  manejar el estado de la lista de cuentos.
/// Este estado se utilizará en la pantalla de inicio para mostrar y desplegar
/// los cuentos correspondientes a cada categoría. El [TalesNotifier] cuenta con los
/// métodos respectivos para cargar los cuentos iniciales e inicializar las consultas.
final sliderTalesProvider =
    StateNotifierProvider<TalesNotifier, List<Tales>>((ref) {
  List<DocumentSnapshot> docList = [];
  final repository = ref.watch(talesRepositoryProvider);
  return TalesNotifier(repository, docList);
});

final premiumTalesProvider =
    StateNotifierProvider<TalesNotifier, List<Tales>>((ref) {
  List<DocumentSnapshot> docList = [];
  final repository = ref.watch(talesRepositoryProvider);
  return TalesNotifier(repository, docList);
});

final freeTalesProvider =
    StateNotifierProvider<TalesNotifier, List<Tales>>((ref) {
  List<DocumentSnapshot> docList = [];
  final repository = ref.watch(talesRepositoryProvider);
  return TalesNotifier(repository, docList);
});

final kidsTalesProvider =
    StateNotifierProvider<TalesNotifier, List<Tales>>((ref) {
  List<DocumentSnapshot> docList = [];
  final repository = ref.watch(talesRepositoryProvider);
  return TalesNotifier(repository, docList);
});

final teensTalesProvider =
    StateNotifierProvider<TalesNotifier, List<Tales>>((ref) {
  List<DocumentSnapshot> docList = [];
  final repository = ref.watch(talesRepositoryProvider);
  return TalesNotifier(repository, docList);
});

class TalesNotifier extends StateNotifier<List<Tales>> {
  final TalesRepository repository;
  List<DocumentSnapshot> docList;

  TalesNotifier(this.repository, this.docList) : super([]);

  void loadTalesSliderTales() async {
    docList = await repository.datasource.fetchSliderTales(docList);
    final List<Tales> tales = repository.convertToTales(docList);
    state = tales;
  }

  void loadTalesByAgeLimit(AgeLimit ageLimit) async {
    docList =
        await repository.datasource.fetchMoreTalesByAgeLimit(ageLimit, docList);
    final List<Tales> tales = repository.convertToTales(docList);
    state = tales;
  }

  void loadTalesByAccesibility(Accesibility accesibility) async {
    docList = await repository.datasource
        .fetchMoreTalesByAccesibility(accesibility, docList);
    final List<Tales> tales = repository.convertToTales(docList);
    state = tales;
  }
}
