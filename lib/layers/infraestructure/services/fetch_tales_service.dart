import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuentos_pasantia/layers/domain/services/fetch_tales_service_model.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/app/search/enums/enums.dart';

class FetchTalesService extends FetchTalesServiceModel {
  final CollectionReference _talesCollection =
      FirebaseFirestore.instance.collection('tales');

  @override
  Future<List<DocumentSnapshot>> fetchTaleByTitle(String title) async {
    try {
      if (title.isEmpty) return [];

      final query = await _talesCollection
          .where('title', isGreaterThanOrEqualTo: title)
          .limit(16)
          .get();
      return query.docs;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<DocumentSnapshot>> fetchMoreTalesByAccesibility(
      Accessibility accesibility, List<DocumentSnapshot> documentList) async {
    try {
      final query = (accesibility != Accessibility.all)
          ? _talesCollection.where('premium',
              isEqualTo: (accesibility == Accessibility.premium))
          : _talesCollection;
      final QuerySnapshot<Object?> fetch;
      if (documentList.isEmpty) {
        fetch = await query.limit(16).get();
      } else {
        fetch =
            await query.limit(16).startAfterDocument(documentList.last).get();
      }
      return List.from(documentList)..addAll(fetch.docs);
    } on SocketException {
      throw const SocketException('No hay conexión a internet');
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<DocumentSnapshot>> fetchMoreTales(
      List<DocumentSnapshot> documentList) async {
    try {
      final query = (documentList.isNotEmpty)
          ? await _talesCollection
              // .limit(16)
              .startAfterDocument(documentList.last)
              .get()
          : await _talesCollection.get();
      return List.from(documentList)..addAll(query.docs);
    } on SocketException {
      throw const SocketException('No hay conexión a internet');
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<DocumentSnapshot>> fetchSliderTales(
      List<DocumentSnapshot> docsList) async {
    try {
      final query = await _talesCollection
          .orderBy('title', descending: true)
          .limit(6)
          .get();
      return query.docs;
    } on SocketException {
      throw const SocketException('No hay conexión a internet');
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<DocumentSnapshot>> fetchMoreTalesByAgeLimit(
      AgeLimit ageLimit, List<DocumentSnapshot> documentList) async {
    try {
      int ageMinorLimit = 0;
      int ageMaxLimit = 18;
      if (ageLimit == AgeLimit.forKids) {
        ageMinorLimit = 8;
        ageMaxLimit = 12;
      } else if (ageLimit == AgeLimit.forTeens) {
        ageMinorLimit = 12;
        ageMaxLimit = 16;
      } else {
        ageMinorLimit = 0;
        ageMaxLimit = 15;
      }
      final query = (documentList.isEmpty)
          ? await _talesCollection
              .where('ageLimit', isLessThanOrEqualTo: ageMaxLimit)
              .where('ageLimit', isGreaterThanOrEqualTo: ageMinorLimit)
              .limit(16)
              .get()
          : await _talesCollection
              .where('ageLimit', isLessThanOrEqualTo: ageLimit)
              .startAfterDocument(documentList.last)
              .limit(16)
              .get();
      return List.from(documentList)..addAll(query.docs);
    } on SocketException {
      throw const SocketException('No hay conexión a internet');
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<DocumentSnapshot>> fetchMoreTalesByCreationTime(
      List<DocumentSnapshot> documentList) async {
    try {
      final query = (documentList.isEmpty)
          ? await _talesCollection
              .orderBy('creationTime', descending: true)
              .limit(16)
              .get()
          : await _talesCollection
              .orderBy('creationTime', descending: true)
              .startAfterDocument(documentList.last)
              .limit(16)
              .get();
      return List.from(documentList)..addAll(query.docs);
    } on SocketException {
      throw const SocketException('No hay conexión a internet');
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<DocumentSnapshot>> fetchMoreTalesByGender(
      List<Gender> genders, List<DocumentSnapshot> documentList) async {
    try {
      final query = (documentList.isEmpty)
          ? await _talesCollection
              .where('genders',
                  arrayContains: genders.map((e) => e.name).toList())
              .limit(16)
              .get()
          : await _talesCollection
              .where('genders',
                  arrayContains: genders.map((e) => e.name).toList())
              .startAfterDocument(documentList.last)
              .limit(16)
              .get();
      return List.from(documentList)..addAll(query.docs);
    } on SocketException {
      throw const SocketException('No hay conexión a internet');
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<DocumentSnapshot>> multiFetchTales(
    List<DocumentSnapshot> documentList,
    String taleTitle,
    List<Gender> genders,
    AgeLimit ageLimit,
    Accessibility accesibility,
    TimeLapse timeLapse,
  ) async {
    try {
      if (taleTitle == "") {
        if (accesibility == Accessibility.all &&
            ageLimit == AgeLimit.forAll &&
            timeLapse == TimeLapse.recent &&
            genders.isEmpty) {
          return fetchMoreTales(documentList);
        } else {
          final query = await _talesCollection
              .where('ageLimit', isEqualTo: ageLimit)
              .where('premium',
                  isEqualTo: (accesibility == Accessibility.premium))
              .where('genders', arrayContainsAny: genders)
              .orderBy('creationTime',
                  descending: timeLapse == TimeLapse.recent)
              .get();
          return query.docs;
        }
      } else {
        return fetchTaleByTitle(taleTitle);
      }
    } on SocketException {
      throw const SocketException('No hay conexión a internet');
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
