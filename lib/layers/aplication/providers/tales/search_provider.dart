import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_pasantia/layers/aplication/providers/providers.dart';
import 'package:proyecto_pasantia/layers/infrastructure/repositories/tales_repository.dart';

import '../../../domain/entities/app/search/search_state.dart';
import '../../../domain/entities/tales/tales_exports.dart';

final searchProvider =
    StateNotifierProvider<SearchNotifier, SearchState>((ref) {
  List<DocumentSnapshot> docList = [];
  final repository = ref.watch(talesRepositoryProvider);
  return SearchNotifier(repository, docList);
});

class SearchNotifier extends StateNotifier<SearchState> {
  List<DocumentSnapshot> docList;
  List<Tales> tales = [];
  TalesRepository repository;
  SearchNotifier(this.repository, this.docList) : super(SearchState());

  void init() async {
    tales = repository.convertToTales(docList);
  }
}
