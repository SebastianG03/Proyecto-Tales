import 'package:cuentos_pasantia/layers/domain/entities/user/user_tales_status.dart';

class UserTalesCache {
  final String taleId;
  final String taleTitle;
  final String coverUrl;
  final UserTalesStatus progress;
  final int lastChapterReaded;
  final String lastSectionReaded;
  final DateTime? lastTimeRead;

  UserTalesCache({
    required this.taleId,
    required this.taleTitle,
    required this.coverUrl,
    required this.progress,
    required this.lastTimeRead,
    required this.lastChapterReaded,
    required this.lastSectionReaded,
  });
}
