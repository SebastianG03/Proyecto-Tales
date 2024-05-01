import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuentos_pasantia/layers/application/providers/providers.dart';
import 'package:cuentos_pasantia/layers/domain/entities/tales/tales.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider = StateProvider<String>((ref) => "");
final searchedTales = StateProvider<List<Tales>>((ref) => []);

/// State provider, se encarga de manejar la búsqueda de cuentos en la base de datos.
final searchTalesProvider =
    StateNotifierProvider<SearchTalesNotifier, List<Tales>>((ref) {
  final repo = ref.watch(talesRepositoryProvider);
  return SearchTalesNotifier(
      searchTales: repo.fetchTalesByTitle,
      convertToTales: repo.convertToTales,
      ref: ref);
});

typedef SearchTalesCallback = Future<List<DocumentSnapshot>> Function(
    String query);
typedef ConverToTales = List<Tales> Function(
    List<DocumentSnapshot<Object?>> docList);

class SearchTalesNotifier extends StateNotifier<List<Tales>> {
  final SearchTalesCallback searchTales;
  final ConverToTales convertToTales;
  final Ref ref;

  SearchTalesNotifier(
      {required this.searchTales,
      required this.convertToTales,
      required this.ref})
      : super([]);

  Future<List<Tales>> searchTalesByQuery(String query) async {
    ref.read(searchQueryProvider.notifier).update((_) => query);
    final talesDocs = await searchTales(query);
    final List<Tales> tales = convertToTales(talesDocs);
    state = tales;
    ref.read(searchedTales.notifier).update((_) => tales);
    return tales;
  }
}
