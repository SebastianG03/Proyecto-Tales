import 'package:proyecto_pasantia/layers/domain/entities/app/search/enums/enums.dart';

class SearchModel {
  final TimeLapse timeLapse;
  final List<Gender>? genders;
  final AgeLimit ageLimit;
  final Accesibility accesibility;
  final String search;

  SearchModel({
    this.genders,
    this.ageLimit = AgeLimit.forAll,
    this.accesibility = Accesibility.all,
    this.timeLapse = TimeLapse.recent,
    required this.search,
  });

  SearchModel copyWith({
    TimeLapse? timeLapse,
    List<Gender>? genders,
    AgeLimit? ageLimit,
    Accesibility? accesibility,
    String? search,
  }) {
    return SearchModel(
      timeLapse: timeLapse ?? this.timeLapse,
      genders: genders ?? this.genders,
      ageLimit: ageLimit ?? this.ageLimit,
      accesibility: accesibility ?? this.accesibility,
      search: search ?? this.search,
    );
  }
}
