enum UserTalesStatus { reading, completed, following, unfollowing }

extension UserTalesStatusExtension on UserTalesStatus {
  String get name {
    switch (this) {
      case UserTalesStatus.reading:
        return 'Leyendo';
      case UserTalesStatus.completed:
        return 'Completado';
      case UserTalesStatus.following:
        return 'Siguiendo';
      case UserTalesStatus.unfollowing:
        return 'Dejar de seguir';
    }
  }
}
