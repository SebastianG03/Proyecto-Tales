/// [Accesibility] contiene la clase que representa la accesibilidad de los cuentos para los usuarios.
/// Los usuarios pueden elegir entre ver todos los cuentos, [all]. O intercalar entre cuentos premium o
/// gratuitos, [premium] y [free] respectivamente.
enum Accesibility { premium, free, all }

extension AccesibilityExtension on Accesibility {
  String get name {
    switch (this) {
      case Accesibility.free:
        return 'Gratuitos';
      case Accesibility.premium:
        return 'Premium';
      case Accesibility.all:
        return 'Todos';
    }
  }
}
