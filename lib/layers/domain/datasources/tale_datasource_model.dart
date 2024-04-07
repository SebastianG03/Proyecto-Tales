import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/tales/tales_exports.dart';

abstract class TaleDatasourceModel {
  Future<Tales> getTale(String id);
  List<Tales> convertToTales(List<DocumentSnapshot> documentList);
  Future<List<Chapter>> getTaleChapters(String taleId);
  Future<Chapter> getChapter(String taleId, int chapterId);
  Future<Section> getSection(String taleId, int chapterId, int page);
  Future<Section> loadNextSection(
      String taleId, int chapterId, String sectionId);
  Future<List<Section>> getSections(String taleId, int chapterId);
  void uploadTale(Tales tale);
  Future<Section> _uploadSectionFiles(
      String taleId, int chapterNumber, Section section, bool update);
  Tales _recursiveUploadSectionFiles(String taleId, Tales tale, bool update);
  void updateTale(Tales tale);
  Future<String> uploadSectionFile(File file, String taleId, int chapterNumber,
      String sectionId, bool update);
  Future<String> uploadTaleCover(File file, String taleId, bool update);
  Future<bool> isTaleTitleUnique(String title);
}
