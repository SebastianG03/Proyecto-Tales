import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_pasantia/layers/domain/entities/tales/chapter.dart';
import 'package:proyecto_pasantia/layers/domain/entities/tales/gender_tales.dart';
import 'package:proyecto_pasantia/layers/domain/entities/tales/section.dart';
import 'package:proyecto_pasantia/layers/domain/entities/tales/tales.dart';
import 'package:proyecto_pasantia/layers/domain/repositories/tales_repository_model.dart';
import 'package:proyecto_pasantia/layers/infrastructure/datasources/tales_datasource.dart';

class TalesRepository extends TaleRepositoryModel {
  final TalesDataSource datasource;
  final List<Tales> generalTales = [];

  TalesRepository() : datasource = TalesDataSource();

  @override
  Future<Tales> getTale(String id) {
    return datasource.getTale(id);
  }

  @override
  Future<Chapter> getChapter(String taleId, int chapterId) {
    return datasource.getChapter(taleId, chapterId);
  }

  @override
  Future<List<Chapter>> getTaleChapters(String taleId) {
    return datasource.getTaleChapters(taleId);
  }

  @override
  Future<Section> getSection(String taleId, int chapterId, String sectionId) {
    return datasource.getSection(taleId, chapterId, sectionId);
  }

  @override
  Future<List<Section>> getSections(String taleId, int chapterId) {
    return datasource.getSections(taleId, chapterId);
  }

  @override
  Future<List<Tales>> getTaleByTitle(String title) {
    return datasource.getTaleByTitle(title);
  }

  @override
  Future<List<Tales>> fetchMoreTalesByAgeLimit(
      int ageLimit, List<DocumentSnapshot> docsList) async {
    final results =
        await datasource.fetchMoreTalesByAgeLimit(ageLimit, docsList);
    return datasource.convertToTales(results);
  }

  @override
  Future<List<Tales>> fetchMoreTalesByCreationTime(
      List<DocumentSnapshot> docsList) async {
    final results = await datasource.fetchMoreTalesByCreationTime(docsList);
    return datasource.convertToTales(results);
  }

  @override
  Future<List<Tales>> fetchMoreTalesByGender(
      Gender gender, List<DocumentSnapshot> docsList) async {
    final results = await datasource.fetchMoreTalesByGender(gender, docsList);
    return datasource.convertToTales(results);
  }
}
