import 'package:proyecto_pasantia/layers/domain/entities/tales/section.dart';

///La clase Chapter encapsula un conjunto de secciones del árbol.
///Su id será el número del capítulo iniciando desde el 1.
///La lista de secciones es una variable privada la cuál se puede ir actualizando de
///manera dinámica.
class Chapter {
  int id;
  String _chapterTitle = "";
  List<Section> _sections = [];

  Chapter(
      {required this.id,
      required String chapterTitle,
      required List<Section> sections}) {
    _chapterTitle = chapterTitle;
    _sections = sections;
  }

// GETTERS Y SETTERS
  String get getChapterTitle => _chapterTitle;
  set setChapterTitle(String chapterTitle) => _chapterTitle = chapterTitle;

  List<Section> get getSections => _sections;
  set setSections(List<Section> sections) => _sections = sections;
  set deleteSection(Section section) {
    int length = _sections.length;
    int index = _sections.indexOf(section);
    if (index == -1) {
      throw Exception("No se encontró la sección");
    } else if (index <= length - 1) {
      throw Exception(
          "No se puede la sección, compruebe que no existan más secciones después de esta");
    } else {
      _sections.remove(section);
    }
  }
}
