// ignore_for_file: unnecessary_null_comparison

/// Clase Options, representa las opciones que el usuario puede seleccionar dentro de cada
/// sección del cuento. Además sirve de unión entre los nodos del árbol.
/// La id será un número algabético que representará la opción. Si es la primera opción será "A",
/// la segunda "B" y así sucesivamente.
library;

class Options {
  String id;
  String text;
  String _nextSectionId = "";
  String _previousSectionId = "";
  bool? isAEnd; // Only use if the tale is going to end and not continue anymore

  Options({
    required this.id,
    required this.text,
  });

  Options.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        text = json['text'] {
    _nextSectionId = json['nextSection'];
    _previousSectionId = json['previousSection'];
    isAEnd = json['isAEnd'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'isAEnd': isAEnd,
      'nextSection': _nextSectionId,
      'previousSection': _previousSectionId,
    };
  }

  /// GETTERS Y SETTERS

  ///Siguiente nodo al que apunta el árbol. Dos o más nodos pueden apuntar al mismo nodo.
  String get getNext => _nextSectionId;
  set setNext(String next) => _nextSectionId = next;

  ///Nodo anterior al que apunta el árbol. Dos o más nodos pueden apuntar al mismo nodo.
  String get getPrevious => _previousSectionId;
  set setPrevious(String previous) => _previousSectionId = previous;
}
