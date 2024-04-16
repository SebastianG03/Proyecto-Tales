import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuentos_pasantia/layers/application/providers/providers.dart';
import 'package:cuentos_pasantia/layers/domain/entities/app/search/search_state.dart';
import 'package:cuentos_pasantia/layers/domain/entities/tales/tales.dart';
import 'package:cuentos_pasantia/layers/infraestructure/repositories/tales_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// State provider, se encarga de manejar el estado de la busqueda.
/// Es necesario para ejecutar talesSearchProvider.
/// Devuelve un SearchState.
final searchStateProvider = StateProvider((ref) => SearchState());

/// Future provider, se encarga de buscar los cuentos en la base de datos.
/// Depende de searchStateProvider.
/// Devuelve una lista de cuentos.
final talesSearchProvider = FutureProvider(((ref) async {
  List<DocumentSnapshot> docList = [];
  final repo = ref.watch(talesRepositoryProvider);
  final searchState = ref.watch(searchStateProvider.notifier).state;
  docList = await repo.multiFetchTales(
      docList,
      searchState.search,
      searchState.genders,
      searchState.ageLimit,
      searchState.accesibility,
      searchState.timeLapse);
  return repo.convertToTales(docList);
}));

final searchProvider =
    StateNotifierProvider<SearchNotifier, List<Tales>>((ref) {
  final repository = ref.watch(talesRepositoryProvider);
  return SearchNotifier(repository: repository);
});

class SearchNotifier extends StateNotifier<List<Tales>> {
  final TalesRepository repository;

  SearchNotifier({required this.repository}) : super([]);

  Future<void> loadTales(SearchState newState) async {
    state.clear();
    final docList = await repository.multiFetchTales([],
        newState.search,
        newState.genders,
        newState.ageLimit,
        newState.accesibility,
        newState.timeLapse);

    state = repository.convertToTales(docList);
    newState.notify();
  }
}
