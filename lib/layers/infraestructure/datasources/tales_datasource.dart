import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../domain/datasources/tale_datasource_model.dart';
import '../../domain/entities/app/search/enums/enums.dart';
import '../../domain/entities/tales/tales_exports.dart';
import 'package:firebase_storage/firebase_storage.dart' as fire_storage;

class TalesDataSource extends TaleDatasourceModel {
  final CollectionReference _talesCollection =
      FirebaseFirestore.instance.collection('tales');
  final fire_storage.FirebaseStorage _storage =
      fire_storage.FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final String _rootPath = 'tales';

  TalesDataSource();

  void init() async {
    await _auth.signInAnonymously();
  }

  void dispose() async {
    await _auth.signOut();
  }

  @override
  void uploadTale(Tales tale) async {
    // final cover = await tale.coverImage!.create();
    // final coverUrl = await uploadTaleCover(cover, tale.id, false);
    // tale.setCoverUrl = coverUrl;
    // tale = await _recursiveUploadSectionFiles(tale.id, tale, false);
    await _talesCollection.doc(tale.id).set(tale.toJson());
  }

  Future<Section> _uploadSectionFiles(
      String taleId, int chapterNumber, Section section, bool update) async {
    final imageFile = section.getImageFile;
    final audioFile = section.getAudioFile;

    if (imageFile != null) {
      section.setImageUrl = await uploadSectionFile(
          imageFile, taleId, chapterNumber, section.id, update);
    }
    if (audioFile != null) {
      section.setAudioUrl = await uploadSectionFile(
          audioFile, taleId, chapterNumber, section.id, update);
    }
    return section;
  }

  Future<Tales> _recursiveUploadSectionFiles(
      String taleId, Tales tale, bool update) async {
    for (var chapter in tale.getChapters) {
      for (var section in chapter.getSections) {
        section =
            await _uploadSectionFiles(taleId, chapter.id, section, update);
      }
    }
    return tale;
  }

  @override
  Future<String> uploadSectionFile(File file, String taleId, int chapterNumber,
      String sectionId, bool update) async {
    try {
      if (update) {
        // await _storage.refFromURL(oldSectionUrl).delete();
      }
      final upload = await _storage
          .ref()
          .child('$_rootPath/$taleId/$chapterNumber/$sectionId/')
          .putFile(file);
      final String url = await upload.ref.getDownloadURL();
      return url;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<String> uploadTaleCover(File file, String taleId, bool update) async {
    try {
      if (update) {
        final oldCover = await getTale(taleId);
        final oldCoverUrl = oldCover.getCoverUrl;
        await _storage.refFromURL(oldCoverUrl).delete();
      }
      debugPrint(
          'Path: ${file.path}, Absolute: ${file.absolute}, Uri: ${file.uri}');
      final upload =
          await _storage.ref('$_rootPath/$taleId').child('cover').putFile(file);
      final String url = await upload.ref.getDownloadURL();
      return url;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<bool> isTaleTitleUnique(String title) async {
    final query = await _talesCollection.where('title', isEqualTo: title).get();
    return query.docs.isEmpty;
  }

  @override
  void updateTale(Tales tale) async {
    final cover = File(tale.coverImage!.path);
    final coverUrl = await uploadTaleCover(cover, tale.id, true);
    tale.setCoverUrl = coverUrl;
    tale = await _recursiveUploadSectionFiles(tale.id, tale, true);
    await _talesCollection.doc(tale.id).update(tale.toJson());
  }

  @override
  Future<Tales> getTale(String id) async {
    try {
      final snapshot = await _talesCollection.doc(id).get();
      return Tales.fromJson(snapshot.data() as Map<String, dynamic>);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Chapter>> getTaleChapters(String taleId) async {
    final tale = await getTale(taleId);
    return tale.getChapters;
  }

  @override
  Future<Chapter> getChapter(String taleId, int chapterId) async {
    try {
      final query = await _talesCollection
          .where('id', isEqualTo: taleId)
          .where('chapters', arrayContains: chapterId)
          .get();
      return Chapter.fromJson(query.docs.first.data() as Map<String, dynamic>);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Section> getSection(String taleId, int chapterId, int page) async {
    try {
      final query = await _talesCollection.where('id', isEqualTo: taleId).get();
      final json = query.docs.first.data() as Map<String, dynamic>;
      final tale = Tales.allDataFromJason(json);
      debugPrint(
          'Tale: ${tale.title} | Section: ${tale.getChapters[chapterId].getSections[page].id}');
      return tale.getChapters[chapterId].getSections[page];
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Section> loadNextSection(
      String taleId, int chapterId, String sectionId) async {
    try {
      final query = await _talesCollection.where('id', isEqualTo: taleId).get();
      final json = query.docs.first.data() as Map<String, dynamic>;
      final tale = Tales.allDataFromJason(json);
      return tale.getChapters[chapterId].getSections
          .where((section) => section.id == sectionId)
          .first;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Section>> getSections(String taleId, int chapterId) async {
    try {
      final query = await _talesCollection.where('id', isEqualTo: taleId).get();
      final json = query.docs.first.data() as Map<String, dynamic>;
      final tale = Tales.allDataFromJason(json);
      return tale.getChapters[chapterId].getSections;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  List<Tales> convertToTales(List<DocumentSnapshot> documentList) {
    return documentList
        .map((docs) => Tales.fromJson(docs.data() as Map<String, dynamic>))
        .toList();
  }
}
