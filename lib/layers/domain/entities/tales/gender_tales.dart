// ignore_for_file: constant_identifier_names
enum Gender {
  Aventura,
  Fantasia,
  CienciaFiccion,
  Misterio,
  Humor,
  Drama,
  Romance,
  Suspense,
  Magia,
  Mitologia,
  Historico,
  Realista,
  Otro
}

extension GenderExtension on Gender {
  String toShortString() {
    switch (this) {
      case Gender.Aventura:
        return 'Aventura';
      case Gender.Fantasia:
        return 'Fantasía';
      case Gender.CienciaFiccion:
        return 'Ciencia Ficción';
      case Gender.Misterio:
        return 'Misterio';
      case Gender.Humor:
        return 'Humor';
      case Gender.Drama:
        return 'Drama';
      case Gender.Romance:
        return 'Romance';
      case Gender.Suspense:
        return 'Suspenso';
      case Gender.Magia:
        return 'Magia';
      case Gender.Mitologia:
        return 'Mitología';
      case Gender.Historico:
        return 'Histórico';
      case Gender.Realista:
        return 'Realista';
      case Gender.Otro:
        return 'Otro';
    }
  }
}

class GenderTalesHelper {
  List<Gender> get genders => Gender.values;
  static List<String> get gendersNames =>
      Gender.values.map((e) => e.name).toList();
  static String genderString(int index) => Gender.values[index].name;
  static Gender genderEnum(int index) => Gender.values[index];

  static Gender getGenderByName(String name) {
    return Gender.values.firstWhere(
        (element) => element.name.toLowerCase() == name.toLowerCase(),
        orElse: () => Gender.Otro);
  }
}
