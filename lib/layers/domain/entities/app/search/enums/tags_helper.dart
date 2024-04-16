import 'package:cuentos_pasantia/layers/domain/entities/app/search/enums/enums.dart';

///Esta clase solo puede ser utilizada para manejar las etiquetas de la pantalla
///principal.
class TagsHelper {
  ///Devuelve el SearchKey del valor correspondiente.
  ///No aplica para en enum de Gender.
  static SearchKeys getInstanceOf(String value) {
    const ageLimitValues = AgeLimit.values;
    const accessibilityValues = Accessibility.values;

    if (ageLimitValues
        .where((element) => element.name.compareTo(value) == 0)
        .isNotEmpty) {
      return SearchKeys.ageLimit;
    } else if (accessibilityValues
        .where((element) => element.name.compareTo(value) == 0)
        .isNotEmpty) {
      return SearchKeys.accesibility;
    } else {
      return SearchKeys.timeLapse;
    }
  }

  static AgeLimit getAgeLimitByName(String name) {
    const ageLimitValues = AgeLimit.values;
    return ageLimitValues.where((element) => element.name == name).first;
  }

  static Accessibility getAccessibilityByName(String name) {
    const accessibilityValues = Accessibility.values;
    return accessibilityValues.where((element) => element.name == name).first;
  }

  static TimeLapse getTimeLapseByName(String name) {
    const timeLapseValues = TimeLapse.values;
    return timeLapseValues.where((element) => element.name == name).first;
  }
}
