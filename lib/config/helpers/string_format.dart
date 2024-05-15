class StringFormat {
  static String formatText(String text) {
    // Reemplaza todos los saltos de línea por un espacio
    text = text.replaceAll(RegExp(r'\r?\n'), ' ');
    // Reemplaza múltiples espacios en blanco por un solo espacio
    text = text.replaceAll(RegExp(r'\s+'), ' ');
    text = text.trim();

    return text;
  }
}
