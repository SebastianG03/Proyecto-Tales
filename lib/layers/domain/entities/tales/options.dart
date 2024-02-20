import 'package:proyecto_pasantia/layers/domain/entities/tales/section.dart';

/// Clase Options, representa las opciones que el usuario puede seleccionar dentro de cada
/// sección del cuento. Además sirve de unión entre los nodos del árbol.
/// La id será un número algabético que representará la opción. Si es la primera opción será "A",
/// la segunda "B" y así sucesivamente.
class Options {
  String id;
  String text;
  String? _userSelection;
  Section? _nextSection;
  Section? _previousSection;

  Options({
    required this.id,
    required this.text,
  });

  /// GETTERS Y SETTERS
  /// Selección del usuario, no puede ser nulo.
  String get getUserSelection => _userSelection!;
  set setUserSelection(String userSelection) => _userSelection = userSelection;

  ///Siguiente nodo al que apunta el árbol. Dos o más nodos pueden apuntar al mismo nodo.
  Section get getNext => _nextSection!;
  set setNext(Section next) => _nextSection = next;

  ///Nodo anterior al que apunta el árbol. Dos o más nodos pueden apuntar al mismo nodo.
  Section get getPrevious => _previousSection!;
  set setPrevious(Section previous) => _previousSection = previous;
}