import 'package:intl/intl.dart';

enum UserTalesStatus { inProgress, completed, following }

/// La clase UserTales permitirá realizar un seguimiento de la lectura del cuento
/// de parte del usuario y almacenar el progreso del mismo. Además, de facilitar la creación
/// de la librería de la aplicación.
class UserTales {
  final String taleId;
  final String taleTitle;
  String coverUrl = "";
  UserTalesStatus progress;
  String _lastChapterReaded = "";
  DateTime? _lastTimeRead;

  UserTales({
    required this.taleId,
    required this.taleTitle,
    required this.coverUrl,
    required this.progress,
  });

  UserTales.fromJson(Map<String, dynamic> json)
      : progress = UserTalesStatus.inProgress,
        taleId = json['idTale'],
        taleTitle = json['taleTitle'],
        coverUrl = json['coverUrl'] {
    progress = _parseUserTalesStatus(json['progress']);
    _lastChapterReaded = json['_lastChapterReaded'];
    _lastTimeRead = json['_lastTimeRead'] != null
        ? DateTime.parse(json['_lastTimeRead'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    return {
      'idTale': taleId,
      'taleTitle': taleTitle,
      'coverUrl': coverUrl,
      'progress': progress.toString(),
      '_lastChapterReaded': _lastChapterReaded,
      '_lastTimeRead':
          (_lastTimeRead == null) ? null : dateFormat.format(_lastTimeRead!)
    };
  }

  UserTalesStatus _parseUserTalesStatus(String progress) =>
      UserTalesStatus.values.firstWhere(
          (element) => element.toString() == progress,
          orElse: () => UserTalesStatus.inProgress);

  int daysSinceLastRead() {
    DateTime now = DateTime.now();
    if (_lastTimeRead != null) {
      int daysDifference = now.difference(_lastTimeRead!).inDays;
      return daysDifference.abs();
    }
    return -1;
  }

  int hoursSinceLastRead() {
    DateTime now = DateTime.now();
    if (_lastTimeRead != null) {
      int hoursDifference = now.difference(_lastTimeRead!).inHours;
      return hoursDifference.abs();
    }
    return -1;
  }

  set setLastChapterReaded(String lastChapterReaded) =>
      lastChapterReaded = _lastChapterReaded;
  String get getLastChapterReaded => _lastChapterReaded;

  set setLastTimeRead(DateTime? lastTimeRead) => lastTimeRead = _lastTimeRead;
  DateTime? get getLastTimeRead => _lastTimeRead;
}
