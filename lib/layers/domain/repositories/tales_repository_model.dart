import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/app/search/enums/enums.dart';
import '../entities/tales/tales_exports.dart';

abstract class TaleRepositoryModel {
  Future<Tales> getTale(String id);
  Future<List<DocumentSnapshot>> getTaleByTitle(String title);
  Future<List<DocumentSnapshot>> fetchSliderTales(
      List<DocumentSnapshot> docsList);
  Future<List<DocumentSnapshot>> fetchMoreTalesByGender(
      List<Gender> genders, List<DocumentSnapshot> docsList);
  Future<List<DocumentSnapshot>> fetchMoreTalesByCreationTime(
      List<DocumentSnapshot> docsList);
  Future<List<DocumentSnapshot>> fetchMoreTalesByAgeLimit(
      AgeLimit ageLimit, List<DocumentSnapshot> docsList);
  Future<List<DocumentSnapshot>> fetchMoreTales(
      List<DocumentSnapshot> documentList);
  Future<List<DocumentSnapshot>> fetchMoreTalesByAccesibility(
      Accessibility accesibility, List<DocumentSnapshot> documentList);
  Future<List<DocumentSnapshot>> multiFetchTales(
    List<DocumentSnapshot> documentList,
    String taleTitle,
    List<Gender> genders,
    AgeLimit ageLimit,
    Accessibility accesibility,
    TimeLapse timeLapse,
  );
  Future<List<Chapter>> getTaleChapters(String taleId);
  Future<Chapter> getChapter(String taleId, int chapterId);
  Future<Section> getSection(String taleId, int chapterId, int page);
  Future<Section> loadNextSection(
      String taleId, int chapterId, String sectionId);
  Future<List<Section>> getSections(String taleId, int chapterId);
  List<Tales> convertToTales(List<DocumentSnapshot> docList);
}
