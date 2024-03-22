import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/app/search/enums/enums.dart';

abstract class FetchTalesServiceModel {
  Future<List<DocumentSnapshot>> fetchTaleByTitle(String title);
  Future<List<DocumentSnapshot>> fetchSliderTales(
      List<DocumentSnapshot> docsList);
  Future<List<DocumentSnapshot>> fetchMoreTalesByGender(
      List<Gender> genders, List<DocumentSnapshot> documentList);
  Future<List<DocumentSnapshot>> fetchMoreTalesByCreationTime(
      List<DocumentSnapshot> documentList);
  Future<List<DocumentSnapshot>> fetchMoreTalesByAgeLimit(
      AgeLimit ageLimit, List<DocumentSnapshot> documentList);
  Future<List<DocumentSnapshot>> fetchMoreTalesByAccesibility(
      Accessibility accesibility, List<DocumentSnapshot> documentList);
  Future<List<DocumentSnapshot>> fetchMoreTales(
      List<DocumentSnapshot> documentList);
  Future<List<DocumentSnapshot>> multiFetchTales(
    List<DocumentSnapshot> documentList,
    String taleTitle,
    List<Gender> genders,
    AgeLimit ageLimit,
    Accessibility accesibility,
    TimeLapse timeLapse,
  );
}
