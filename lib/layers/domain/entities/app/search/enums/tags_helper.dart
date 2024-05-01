import 'package:cuentos_pasantia/layers/domain/entities/app/search/enums/enums.dart';

///Esta clase solo puede ser utilizada para manejar las etiquetas de la pantalla
///principal.
class TagsHelper {
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
