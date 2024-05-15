import 'package:cuentos_pasantia/layers/domain/entities/user/user_tales_status.dart';
import 'package:intl/intl.dart';

/// La clase UserTales permitirá realizar un seguimiento de la lectura del cuento
/// de parte del usuario y almacenar el progreso del mismo. Además, de facilitar la creación
/// de la librería de la aplicación.
class UserTales {
  final String taleId;
  final String taleTitle;
  String coverUrl = "";
  // List<UserTalesStatus> progress;
  UserTalesStatus progress;
  int _lastChapterReaded = 0;
  String _lastSectionReaded = "";
  DateTime? _lastTimeRead;

  UserTales({
    required this.taleId,
    required this.taleTitle,
    required this.coverUrl,
    required this.progress,
  });

  UserTales.fromJson(Map<String, dynamic> json)
      : progress = UserTalesStatus.reading,
        taleId = json['idTale'],
        taleTitle = json['taleTitle'],
        coverUrl = json['coverUrl'] {
    progress = _parseUserTalesStatus(json['progress']);
    // if (json['progress'] != null) {
    //   progress = json['progress'].map((value) {
    //     return _parseUserTalesStatus(value);
    //   }).toList();
    // } else {
    //   progress = [];
    // }
    _lastChapterReaded = json['lastChapterReaded'];
    _lastSectionReaded = json['lastSectionReaded'];
    _lastTimeRead = json['lastTimeRead'] != null
        ? DateTime.parse(json['lastTimeRead'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    return {
      'idTale': taleId,
      'taleTitle': taleTitle,
      'coverUrl': coverUrl,
      'progress': progress.name,
      // (progress.isNotEmpty)
      //     ? progress.map((value) {
      //         value.name;
      //       }).toList()
      //     : [],
      'lastChapterReaded': _lastChapterReaded,
      'lastSectionReaded': _lastSectionReaded,
      'lastTimeRead':
          (_lastTimeRead == null) ? null : dateFormat.format(_lastTimeRead!)
    };
  }

  UserTalesStatus _parseUserTalesStatus(String progress) =>
      UserTalesStatus.values.firstWhere(
          (element) => element.name.compareTo(progress) == 0,
          orElse: () => UserTalesStatus.reading);

  String timeSinceLastRead() {
    DateTime now = DateTime.now();
    if (_lastTimeRead != null) {
      int timeDifferenceInSeconds = now.difference(_lastTimeRead!).inSeconds;
      return _formatTimeFromSeconds(timeDifferenceInSeconds);
    }
    return '';
  }

  String _formatTimeFromSeconds(int timeDifferenceInSeconds) {
    if (timeDifferenceInSeconds < 60) {
      return "Leído hace menos de 1 minuto";
    }

    int minutes = timeDifferenceInSeconds ~/ 60;
    if (minutes < 60) {
      return "Leído hace $minutes minutos";
    }

    minutes = (timeDifferenceInSeconds % 3600) ~/ 60;
    if (minutes > 0) {
      int hours = timeDifferenceInSeconds ~/ 3600;
      return "Leído hace $hours hora(s) y $minutes minuto(s)";
    }

    int days = timeDifferenceInSeconds ~/ 86400;
    return "Leído hace $days día(s)";
  }

  set setLastChapterReaded(int lastChapterReaded) =>
      _lastChapterReaded = lastChapterReaded;
  int get getLastChapterReaded => _lastChapterReaded;

  set setLastSectionReaded(String lastSectionReaded) =>
      _lastSectionReaded = lastSectionReaded;
  String get getLastSectionReaded => _lastSectionReaded;

  set setLastTimeRead(DateTime? lastTimeRead) => _lastTimeRead = lastTimeRead;
  DateTime? get getLastTimeRead => _lastTimeRead;
}
