import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/tales/tales_exports.dart';

abstract class TaleRepositoryModel {
  Future<Tales> getTale(String id);
  Future<List<Tales>> getTaleByTitle(String title);
  Future<List<DocumentSnapshot>> fetchSliderTales(
      List<DocumentSnapshot> docsList);
  Future<List<DocumentSnapshot>> fetchMoreTalesByGender(
      Gender gender, List<DocumentSnapshot> docsList);
  Future<List<DocumentSnapshot>> fetchMoreTalesByCreationTime(
      List<DocumentSnapshot> docsList);
  Future<List<DocumentSnapshot>> fetchMoreTalesByAgeLimit(
      int ageLimit, List<DocumentSnapshot> docsList);
  Future<List<Chapter>> getTaleChapters(String taleId);
  Future<Chapter> getChapter(String taleId, int chapterId);
  Future<Section> getSection(String taleId, int chapterId, String sectionId);
  Future<List<Section>> getSections(String taleId, int chapterId);
  List<Tales> convertToTales(List<DocumentSnapshot> docList);
}
