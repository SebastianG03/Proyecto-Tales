enum UserTalesStatus { inProgress, completed, following }

extension UserTalesStatusExtension on UserTalesStatus {
  String get name {
    switch (this) {
      case UserTalesStatus.inProgress:
        return 'Leyendo';
      case UserTalesStatus.completed:
        return 'Completado';
      case UserTalesStatus.following:
        return 'Siguiendo';
    }
  }
}
