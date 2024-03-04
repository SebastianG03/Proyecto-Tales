/// [SearchCategories] contiene la clase que representa las categorías de búsqueda de la aplicación en base al ordenamiento de la fecha.
enum TimeLapse { old, recent }

extension TimeLapseExtension on TimeLapse {
  String get name {
    switch (this) {
      case TimeLapse.recent:
        return 'Descendente';
      case TimeLapse.old:
        return 'Ascendente';
    }
  }
}
