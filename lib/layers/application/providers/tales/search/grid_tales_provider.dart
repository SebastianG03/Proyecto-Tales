import 'package:cuentos_pasantia/layers/application/providers/tales/loaders/tales_provider.dart';
import 'package:cuentos_pasantia/layers/domain/entities/app/search/search_state.dart';
import 'package:cuentos_pasantia/layers/domain/entities/tales/tales.dart';
import 'package:cuentos_pasantia/layers/infraestructure/repositories/tales_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// State provider, se encarga de manejar el estado de la busqueda.
/// Es necesario para ejecutar talesSearchProvider.
/// Devuelve un SearchState.
final gridTalesStateProvider = StateProvider((ref) => SearchState());

final filterProvider =
    StateNotifierProvider<FilterTalesNotifier, List<Tales>>((ref) {
  final repository = ref.watch(talesRepositoryProvider);
  return FilterTalesNotifier(repository: repository);
});

class FilterTalesNotifier extends StateNotifier<List<Tales>> {
  final TalesRepository repository;
  int visibleTales = 8;

  FilterTalesNotifier({required this.repository}) : super([]);

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

  void loadMoreTales() => visibleTales += 8;
}
