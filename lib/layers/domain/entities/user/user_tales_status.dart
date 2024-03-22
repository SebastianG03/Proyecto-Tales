enum UserTalesStatus { reading, completed, following, unFollow }

extension UserTalesStatusExtension on UserTalesStatus {
  String get name {
    switch (this) {
      case UserTalesStatus.reading:
        return 'Leyendo';
      case UserTalesStatus.completed:
        return 'Completado';
      case UserTalesStatus.following:
        return 'Siguiendo';
      case UserTalesStatus.unFollow:
        return 'Sin seguir';
    }
  }
}
