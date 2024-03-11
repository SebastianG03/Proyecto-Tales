import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuentos_pasantia/layers/application/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/app/search/search_state.dart';
import '../../../domain/entities/tales/tales_exports.dart';
import '../../../infraestructure/repositories/tales_repository.dart';

final searchProvider =
    StateNotifierProvider<SearchNotifier, SearchState>((ref) {
  List<DocumentSnapshot> docList = [];
  final repository = ref.watch(talesRepositoryProvider);
  return SearchNotifier(repository, docList);
});

final talesSearchProvider = FutureProvider(((ref) async {
  List<DocumentSnapshot> docList = [];
  final repo = ref.watch(talesRepositoryProvider);
  docList = await repo.fetchMoreTales(docList);
  return repo.convertToTales(docList);
}));



class SearchNotifier extends StateNotifier<SearchState> {
  List<DocumentSnapshot> docList;
  List<Tales> tales = [];
  TalesRepository repository;
  SearchNotifier(this.repository, this.docList) : super(SearchState());

  void init() async {
    docList = await repository.fetchMoreTales(docList);
    tales = repository.convertToTales(docList);
  }
}
