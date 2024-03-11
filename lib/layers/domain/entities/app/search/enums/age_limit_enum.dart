/// [AgeLimit] contiene la clase que representa las categorías de búsqueda
///  de la aplicación en base a la clasificación de edad.
/// [forAll] representa cuentos para todas las edades. Específicamente de 8 años en
/// adelante.
/// [forTeens] se refiere a cuentos para adolescentes, es decir, de 12 años en adelante.
/// Por último, [forKids] se refiere a cuentos para niños, es decir, de 8 años en adelante, pero excluye cuentos que tengan una edad mínima
/// de 12 años.
enum AgeLimit { forKids, forTeens, forAll }

extension AgeLimitExtension on AgeLimit {
  String get name {
    switch (this) {
      case AgeLimit.forKids:
        return 'Para niños';
      case AgeLimit.forTeens:
        return 'Para adolescentes';
      case AgeLimit.forAll:
        return 'Público general';
    }
  }
}
