import 'package:cuentos_pasantia/layers/domain/entities/tales/gender_tales.dart';

class TalesCache {
  final String id;
  final String title;
  final List<Gender> genders;
  final String abstract;
  final bool premium;
  final String coverUrl;

  TalesCache({
    required this.id,
    required this.title,
    required this.genders,
    required this.abstract,
    required this.premium,
    required this.coverUrl,
  });

  TalesCache fromJson(Map<String, dynamic> json) {
    return TalesCache(
      id: json['id'],
      title: json['title'],
      genders: json['genders']
          .map((gender) =>
              Gender.values.firstWhere((element) => element.name == gender))
          .toList(),
      abstract: json['abstract'],
      premium: json['premium'],
      coverUrl: json['coverUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'genders': genders.map((gender) => gender.name).toList(),
      'abstract': abstract,
      'premium': premium,
      'coverUrl': coverUrl
    };
  }
}
