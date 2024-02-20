import 'dart:io';

import 'package:proyecto_pasantia/layers/domain/entities/tales/options.dart';

/// Clase Section, representa una sección del cuento. Cada sección tiene un texto y una lista de opciones posibles para el jugador.
/// Además, puede tener una imagen y un audio que se mostrará al jugador.
/// El parámetro publicId es un identificador único que el usuario puede asignar a la sección, su función es
/// permitir al usuario referenciar la sección en el árbol de decisiones. Tal que una opción pueda apuntar a un mismo final
/// o dos opciones concidir posteriormente en el mismo nodo.
class Section {
  String publicId = "";
  String text;
  List<Options> options;

  File? _imageFile;
  String? _imageUrl;
  String? _audioUrl;
  File? _audioFile;

  Section({
    this.publicId = "",
    required this.text,
    required this.options,
  });

  /// GETTERS Y SETTERS
  File? get getImageFile => _imageFile;
  set setImageFile(File imageFile) => _imageFile = imageFile;

  String? get getImageUrl => _imageUrl;
  set setImageUrl(String imageUrl) => _imageUrl = imageUrl;

  File? get getAudioFile => _audioFile;
  set setAudioFile(File audioFile) => _audioFile = audioFile;

  String? get getAudioUrl => _audioUrl;
  set setAudioUrl(String audioUrl) => _audioUrl = audioUrl;
}
