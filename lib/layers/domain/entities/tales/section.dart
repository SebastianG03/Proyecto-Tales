import 'dart:io';

import 'package:cuentos_pasantia/layers/domain/entities/tales/options.dart';
import 'package:uuid/data.dart';
import 'package:uuid/uuid.dart';

/// Clase Section, representa una sección del cuento. Cada sección tiene un texto y una lista de opciones posibles para el jugador.
/// Además, puede tener una imagen y un audio que se mostrará al jugador.
/// El parámetro publicId es un identificador único que el administrador puede asignar a la sección, su función es
/// permitir al usuario referenciar la sección en el árbol de decisiones. Tal que una opción pueda apuntar a un mismo final
/// o dos opciones concidir posteriormente en el mismo nodo.

class Section {
  String id;
  String publicId = "";
  String text;
  List<Options> options;

  File? _imageFile;
  String? _imageUrl;

  File? _audioFile;
  String? _audioUrl;

  Section({
    this.publicId = "",
    required this.text,
    required this.options,
  }) : id = const Uuid().v4();

  Section.fromJson(Map<String, dynamic> json)
      : options = [],
        id = json['id'],
        text = json['text'] {
    publicId = json['publicId'];
    _imageUrl = json['imageUrl'];
    _audioUrl = json['audioUrl'];

    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options.add(Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'publicId': publicId,
      'text': text,
      'imageUrl': _imageUrl,
      'audioUrl': _audioUrl,
      'options': options.map((e) => e.toJson()).toList(),
    };
  }

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
