import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_pasantia/layers/infrastructure/repositories/tales_repository.dart';

import '../../../domain/entities/tales/tales_exports.dart';

final talesRepositoryProvider = Provider((ref) => TalesRepository());

final talesNotifierProvider = StateNotifierProvider<TalesNotifier, TalesState>(
  (ref) => TalesNotifier(ref.watch(talesRepositoryProvider)),
);

class TalesState {
  final List<Tales> sliderTales;
  final List<Tales> recentTales;
  final List<Tales> ageLimitTales;
  final List<DocumentSnapshot> sliderTalesDocList;
  final List<DocumentSnapshot> recentTalesDocList;
  final List<DocumentSnapshot> ageLimitTalesDocList;
  bool isLoading;

  TalesState({
    this.sliderTales = const [],
    this.recentTales = const [],
    this.ageLimitTales = const [],
    this.sliderTalesDocList = const [],
    this.recentTalesDocList = const [],
    this.ageLimitTalesDocList = const [],
    this.isLoading = false,
  });

  TalesState copyWith({
    List<Tales>? sliderTales,
    List<Tales>? recentTales,
    List<Tales>? ageLimitTales,
    List<DocumentSnapshot>? sliderTalesDocList,
    List<DocumentSnapshot>? recentTalesDocList,
    List<DocumentSnapshot>? ageLimitTalesDocList,
    bool? isLoading,
  }) {
    return TalesState(
      sliderTales: sliderTales ?? this.sliderTales,
      recentTales: recentTales ?? this.recentTales,
      ageLimitTales: ageLimitTales ?? this.ageLimitTales,
      sliderTalesDocList: sliderTalesDocList ?? this.sliderTalesDocList,
      recentTalesDocList: recentTalesDocList ?? this.recentTalesDocList,
      ageLimitTalesDocList: ageLimitTalesDocList ?? this.ageLimitTalesDocList,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  String toString() {
    return '''
              TalesState{ 
                sliderTales: ${sliderTales.length},
                recentTales: ${recentTales.length},
                ageLimitTales: ${ageLimitTales.length},
                sliderTalesDocList: ${sliderTalesDocList.length},
                recentTalesDocList: ${recentTalesDocList.length},
                ageLimitTalesDocList: ${ageLimitTalesDocList.length},
                isLoading: $isLoading
              }
          ''';
  }
}

class TalesNotifier extends StateNotifier<TalesState> {
  final TalesRepository repository;
  TalesNotifier(this.repository) : super(TalesState());

  void initTales() async {
    state.copyWith(isLoading: true);
    state.toString();

    final sliderTales =
        await repository.fetchSliderTales(state.sliderTalesDocList);
    final recentTales =
        await repository.fetchMoreTalesByCreationTime(state.recentTalesDocList);
    final ageLimitTales = await repository.fetchMoreTalesByAgeLimit(
        15, state.ageLimitTalesDocList);

    state = state.copyWith(
      sliderTales: repository.convertToTales(sliderTales),
      recentTales: repository.convertToTales(recentTales),
      ageLimitTales: repository.convertToTales(ageLimitTales),
      sliderTalesDocList: sliderTales,
      recentTalesDocList: recentTales,
      ageLimitTalesDocList: ageLimitTales,
      isLoading: false,
    );

    state.toString();
  }

  void fetchMoreRecentTales() async {
    final recentTales =
        await repository.fetchMoreTalesByCreationTime(state.recentTalesDocList);
    final tales = repository.convertToTales(recentTales);

    state.copyWith(isLoading: true);

    state = state.copyWith(
        recentTales: tales, recentTalesDocList: recentTales, isLoading: false);
  }

  void fetchMoreAgeLimitTales() async {
    final ageLimitTales = await repository.fetchMoreTalesByAgeLimit(
        15, state.ageLimitTalesDocList);
    final tales = repository.convertToTales(ageLimitTales);

    state.copyWith(isLoading: true);

    state = state.copyWith(
        ageLimitTales: tales,
        ageLimitTalesDocList: ageLimitTales,
        isLoading: false);
  }
}
