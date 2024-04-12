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
  final String chapterTitle;

  SectionData({
    required this.taleId,
    required this.chapter,
    this.lastSectionId = "",
    this.actualPage = 1,
    this.numberOfChapters = 0,
    this.chapterTitle = "",
  });

  copyWith({
    String? taleId,
    int? chapter,
    int? numberOfChapters,
    int? actualPage,
    String? lastSectionId,
    String? chapterTitle,
  }) {
    return SectionData(
      taleId: taleId ?? this.taleId,
      chapter: chapter ?? this.chapter,
      actualPage: actualPage ?? this.actualPage,
      lastSectionId: lastSectionId ?? this.lastSectionId,
      numberOfChapters: numberOfChapters ?? this.numberOfChapters,
      chapterTitle: chapterTitle ?? this.chapterTitle,
    );
  }

  void notify() => notifyListeners();
}

class SectionDataNotifier extends StateNotifier<SectionData> {
  TalesRepository repository;
  final List<Section> sections = [];
  SectionDataNotifier(super.state, this.repository);

  Future<void> initData(String taleId, int chapter) async {
    final chapters = await repository.getTaleChapters(taleId);
    state = state.copyWith(
      taleId: taleId,
      chapter: chapter,
      numberOfChapters: chapters.length,
      chapterTitle: chapters[chapter].getChapterTitle,
    );
    sections.clear();
    sections.addAll(chapters[chapter].getSections);
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
      if (sectionId != "") {
        return sections.firstWhere((element) => element.id == sectionId);
      } else {
        return sections.first;
      }
    } else {
      // CustomSnackbar.showSnackBar(context, "No se pudo cargar el contenido");
      throw Exception("No se pudo cargar el contenido");
    }
  }

  Future<void> loadNextChapter() async {
    if (state.chapter >= state.numberOfChapters) return;
    final nextChapter =
        await repository.getChapter(state.taleId, state.chapter + 1);
    state = state.copyWith(
      chapter: state.chapter + 1,
      actualPage: 0,
      chapterTitle: nextChapter.getChapterTitle,
    );
    sections.clear();
    sections.addAll(nextChapter.getSections);
    state.notify();
  }
}

final actualTaleProvider = StateProvider<String>((ref) {
  return "";
});
