import 'dart:io';

import 'package:proyecto_pasantia/layers/domain/entities/tales/chapter.dart';
import 'package:uuid/uuid.dart';

/// Clase Tales, representa el cuerpo principal del cuento que será
/// subido a la base de datos. Contiene el título del cuento, un resumen
/// al cual el usuario podrá acceder mediante la aplicación y una imagen de
/// portada, la cual se colocará en la aplicación para reconocer al cuento de la página principal.
class Tales {
  final String id;
  final String title;
  final String abstract;
  final File coverImage;
  String _coverUrl = "";
  List<Chapter> _chapters = [];

  Tales({
    required this.title,
    required this.abstract,
    required this.coverImage,
  }) : id = const Uuid().v4();

  get getCoverUrl => _coverUrl;
  set setCoverUrl(String coverUrl) => _coverUrl = coverUrl;

  get getChapters => _chapters;
  set setChapters(List<Chapter> chapters) => _chapters = chapters;
}
