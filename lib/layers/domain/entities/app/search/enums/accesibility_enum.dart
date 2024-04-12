/// [Accessibility] contiene la clase que representa la accesibilidad de los cuentos para los usuarios.
/// Los usuarios pueden elegir entre ver todos los cuentos, [all]. O intercalar entre cuentos premium o
/// gratuitos, [premium] y [free] respectivamente.
enum Accessibility { premium, free, all }

extension AccesibilityExtension on Accessibility {
  String get name {
    switch (this) {
      case Accessibility.free:
        return 'Gratuitos';
      case Accessibility.premium:
        return 'Premium';
      case Accessibility.all:
        return 'Todos';
    }
  }
}
