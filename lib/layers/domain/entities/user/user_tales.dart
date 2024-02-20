import 'package:proyecto_pasantia/layers/domain/entities/tales/tales.dart';

enum UserTalesStatus { inProgress, completed, notStarted, following }

/// La clase UserTales permitirá realizar un seguimiento de la lectura del cuento
/// de parte del usuario y almacenar el progreso del mismo. Además, de facilitar la creación
/// de la librería de la aplicación.
class UserTales {
  final Tales tale;
  final UserTalesStatus progress;
  final String lastChapterReaded;
  final DateTime lastTimeRead;

  UserTales(
      {required this.tale,
      required this.progress,
      required this.lastChapterReaded,
      required this.lastTimeRead});
}
