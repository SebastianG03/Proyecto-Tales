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

class GenderTalesHelper {
  List<Gender> get genders => Gender.values;
  static String genderString(int index) => Gender.values[index].name;
  static Gender genderEnum(int index) => Gender.values[index];

  static Gender getGenderByName(String name) {
    return Gender.values.firstWhere(
        (element) => element.name.toLowerCase() == name.toLowerCase(),
        orElse: () => Gender.Otro);
  }

  static String getGenderName(Gender gender) {
    return (gender == Gender.CienciaFiccion) ? 'Ciencia Ficción' : gender.name;
  }
}
