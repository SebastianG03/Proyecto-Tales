import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuentos_pasantia/layers/infraestructure/services/fetch_tales_service.dart';

import '../../domain/entities/app/search/enums/enums.dart';
import '../../domain/entities/tales/tales_exports.dart';
import '../../domain/repositories/tales_repository_model.dart';
import '../datasources/tales_datasource.dart';

class TalesRepository extends TaleRepositoryModel {
  final TalesDataSource datasource;
  final FetchTalesService _service = FetchTalesService();
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
  Future<Section> getSection(String taleId, int chapterId, int page) {
    return datasource.getSection(taleId, chapterId, page);
  }

  @override
  Future<Section> loadNextSection(
      String taleId, int chapterId, String sectionId) {
    return datasource.loadNextSection(taleId, chapterId, sectionId);
  }

  @override
  Future<List<Section>> getSections(String taleId, int chapterId) {
    return datasource.getSections(taleId, chapterId);
  }

  @override
  Future<List<DocumentSnapshot>> fetchTalesByTitle(String title) {
    return _service.fetchTaleByTitle(title);
  }

  @override
  Future<List<DocumentSnapshot>> fetchSliderTales(
      List<DocumentSnapshot> docsList) {
    return _service.fetchSliderTales(docsList);
  }

  @override
  Future<List<DocumentSnapshot>> fetchMoreTalesByAgeLimit(
      AgeLimit ageLimit, List<DocumentSnapshot> docsList) {
    return _service.fetchMoreTalesByAgeLimit(ageLimit, docsList);
  }

  @override
  Future<List<DocumentSnapshot>> fetchMoreTalesByCreationTime(
      List<DocumentSnapshot> docsList) async {
    return _service.fetchMoreTalesByCreationTime(docsList);
  }

  @override
  Future<List<DocumentSnapshot>> fetchMoreTalesByGender(
      List<Gender> genders, List<DocumentSnapshot> docsList) {
    return _service.fetchMoreTalesByGender(genders, docsList);
  }

  @override
  Future<List<DocumentSnapshot>> fetchMoreTales(
      List<DocumentSnapshot> documentList) {
    return _service.fetchMoreTales(documentList);
  }

  @override
  Future<List<DocumentSnapshot>> multiFetchTales(
    List<DocumentSnapshot> documentList,
    String taleTitle,
    List<Gender> genders,
    AgeLimit ageLimit,
    Accessibility accesibility,
    TimeLapse timeLapse,
  ) {
    return _service.multiFetchTales(
        documentList, taleTitle, genders, ageLimit, accesibility, timeLapse);
  }

  @override
  List<Tales> convertToTales(List<DocumentSnapshot<Object?>> docList) {
    return datasource.convertToTales(docList);
  }

  @override
  Future<List<DocumentSnapshot<Object?>>> fetchMoreTalesByAccesibility(
      Accessibility accesibility,
      List<DocumentSnapshot<Object?>> documentList) {
    return _service.fetchMoreTalesByAccesibility(accesibility, documentList);
  }
}
