import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_pasantia/layers/infrastructure/repositories/tales_repository.dart';

import '../../../../domain/entities/tales/tales_exports.dart';
import '../../providers.dart';

final actualTaleProvider = StateProvider<String>((ref) {
  return "";
});

final actualChapterProvider = StateProvider<int>((ref) {
  return 0;
});

final actualSectionProvider = StateProvider<String>((ref) {
  return "";
});

final loadSection = FutureProvider((ref) async {
  final actualTale = ref.watch(actualTaleProvider.notifier).state;
  final actualChapter = ref.watch(actualChapterProvider.notifier).state;
  final actualSection = ref.watch(actualSectionProvider.notifier).state;
  final datasource = ref.watch(talesRepositoryProvider);
  return await datasource.getSection(actualTale, actualChapter, actualSection);
});

final numberOfChapters = FutureProvider<int>((ref) async {
  final repository = ref.watch(talesRepositoryProvider);
  final String actualId = ref.watch(actualTaleProvider.notifier).state;
  final chapters = await repository.getTaleChapters(actualId);
  return chapters.length;
});

final readProvider =
    StateNotifierProvider<TalesReaderNotifier, TalesReaderState>((ref) {
  final repository = ref.watch(talesRepositoryProvider);
  final String actualId = ref.watch(actualTaleProvider.notifier).state;
  return TalesReaderNotifier(repository, actualId);
});

class TalesReaderState {}

class TalesReaderNotifier extends StateNotifier<TalesReaderState> {
  final TalesRepository repository;
  final String taleId;
  int actualChapterId = 0;
  int numberOfChapters = 0;
  Section? actualSection;
  TalesReaderNotifier(this.repository, this.taleId) : super(TalesReaderState());

  void init() async {
    final chapters = await repository.getTaleChapters(taleId);
    numberOfChapters = chapters.length;
  }

  void firstInitRead() async {
    final chapter = await repository.getChapter(taleId, actualChapterId);
    actualSection = chapter.getSections.first;
  }

  void getNextSection(Options option, BuildContext context) async {
    if (option.getNext.isNotEmpty) {
      actualSection =
          await repository.getSection(taleId, actualChapterId, option.getNext);
    } else {
      if (actualChapterId < numberOfChapters) {
        actualChapterId++;
        final chapter = await repository.getChapter(taleId, actualChapterId);
        actualSection = chapter.getSections.first;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No hay más contenido'),
          ),
        );
      }
    }
  }
}
