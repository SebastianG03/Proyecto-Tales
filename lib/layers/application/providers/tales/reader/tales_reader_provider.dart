import 'package:cuentos_pasantia/layers/application/providers/providers.dart';
import 'package:cuentos_pasantia/layers/infraestructure/repositories/tales_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/tales/tales_exports.dart';

final actualSectionProvider = StreamProvider<Section>((ref) {
  final sectionDataNotifier = ref.watch(sectionDataProvider.notifier);
  final selectedOption = ref.watch(selectedOptionProvider);
  return Stream.value(sectionDataNotifier.loadNextSection(selectedOption));
});

final selectedOptionProvider = StateProvider<String>((ref) {
  return "";
});

final sectionDataProvider =
    StateNotifierProvider<SectionDataNotifier, SectionData>((ref) {
  final repository = ref.watch(talesRepositoryProvider);
  final taleId = ref.watch(actualTaleProvider);
  return SectionDataNotifier(
      SectionData(taleId: taleId, chapter: 0), repository);
});

class SectionData extends ChangeNotifier {
  final String taleId;
  final int chapter;
  final int actualPage;
  final String lastSectionId;
  final int numberOfChapters;

  SectionData({
    required this.taleId,
    required this.chapter,
    this.lastSectionId = "",
    this.actualPage = 1,
    this.numberOfChapters = 0,
  });

  copyWith({
    String? taleId,
    int? chapter,
    int? numberOfChapters,
    int? actualPage,
    String? lastSectionId,
  }) {
    return SectionData(
      taleId: taleId ?? this.taleId,
      chapter: chapter ?? this.chapter,
      actualPage: actualPage ?? this.actualPage,
      lastSectionId: lastSectionId ?? this.lastSectionId,
      numberOfChapters: numberOfChapters ?? this.numberOfChapters,
    );
  }

  void notify() => notifyListeners();
}

class SectionDataNotifier extends StateNotifier<SectionData> {
  TalesRepository repository;
  final List<Section> sections = [];
  SectionDataNotifier(super.state, this.repository);

  Future<void> initData(String taleId, int chapter) async {
    final sections = await repository.getSections(taleId, chapter);
    state = state.copyWith(
      taleId: taleId,
      chapter: chapter,
      numberOfChapters: sections.length,
    );
    this.sections.clear();
    this.sections.addAll(sections);
    state.notify();
  }

  Section loadFirst() {
    if (sections.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 500), () {
        state = state.copyWith(lastSectionId: sections.first.id);
      });
      state.notify();
      return sections.first;
    } else {
      throw Exception("No se pudo cargar el contenido");
    }
  }

  Section loadNextSection(String sectionId) {
    if (sectionId == "") return loadFirst();
    if (sections.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 500), () {
        state = state.copyWith(
            lastSectionId: sectionId, actualPage: state.actualPage + 1);
      });
      state.notify();
      return sections.firstWhere((element) => element.id == sectionId);
    } else {
      // CustomSnackbar.showSnackBar(context, "No se pudo cargar el contenido");
      throw Exception("No se pudo cargar el contenido");
    }
  }

  Future<void> loadNextChapter() async {
    if (state.chapter + 1 > state.numberOfChapters) return;
    final newSections =
        await repository.getSections(state.taleId, state.chapter + 1);
    state = state.copyWith(
      chapter: state.chapter + 1,
      actualPage: 0,
    );
    sections.clear();
    sections.addAll(newSections);
    state.notify();
  }
}

final actualTaleProvider = StateProvider<String>((ref) {
  return "";
});
