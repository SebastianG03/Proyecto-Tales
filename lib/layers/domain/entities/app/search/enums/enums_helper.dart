import 'package:cuentos_pasantia/layers/domain/entities/app/search/enums/enums.dart';

///Esta clase solo puede ser utilizada para manejar las etiquetas de la pantalla
///principal.
class TagsHelper {
  /// Cuando es verdadero, el enum AgeLimit contiene el elemento.
  /// Caso contrario lo contiene el enum Accesibility
  static bool tagContainsValue(String value) {
    const ageLimitValues = AgeLimit.values;
    return ageLimitValues.where((element) => element.name == value).isNotEmpty;
  }

  static AgeLimit getAgeLimitValue(String value) {
    const ageLimitValues = AgeLimit.values;
    return ageLimitValues.where((element) => element.name == value).first;
  }

  static Accessibility getAccessibilityValue(String value) {
    const accessibilityValues = Accessibility.values;
    return accessibilityValues.where((element) => element.name == value).first;
  }
}
