import 'package:cuentos_pasantia/layers/application/providers/providers.dart';
import 'package:cuentos_pasantia/layers/domain/entities/user/user_tales_status.dart';
import 'package:cuentos_pasantia/layers/domain/entities/user/users.dart';
import 'package:cuentos_pasantia/layers/infraestructure/repositories/usertales_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userTaleIsFollowing = FutureProvider.family<bool, String>((ref, userId) {
  if (userId.isEmpty) return Future.value(false);
  return ref
      .watch(libraryManagementProvider.notifier)
      .isFollowing(userId, ref.read(actualTaleProvider.notifier).state);
});

final libraryManagementProvider =
    StateNotifierProvider<LibraryManagementNotifier, UserTalesRepository>(
        (ref) => LibraryManagementNotifier());

class LibraryManagementNotifier extends StateNotifier<UserTalesRepository> {
  LibraryManagementNotifier() : super(UserTalesRepository());

  Future<void> updateTale({
    required String userId,
    required String taleId,
    required String taleTitle,
    required String coverUrl,
    required UserTalesStatus progress,
    int? lastChapterReaded,
    String? lastSectionReaded,
  }) async {
    final record = UserTales(
      taleId: taleId,
      taleTitle: taleTitle,
      coverUrl: coverUrl,
      progress: progress,
    );
    record.setLastTimeRead = DateTime.now();
    if (lastChapterReaded != null) {
      record.setLastChapterReaded = lastChapterReaded;
    }
    if (lastSectionReaded != null) {
      record.setLastSectionReaded = lastSectionReaded;
    }

    await state.updateUserTale(userId, record);
  }

  Future<UserTales> getTale(String userId, String taleId) async {
    return await state.getUserTale(userId, taleId);
  }

  Future<bool> userTaleExists(String userId, String taleId) async {
    return await state.userTaleExists(userId, taleId);
  }

  Future<bool> isFollowing(String userId, String taleId) async {
    final userTales = await state.getUserTale(userId, taleId);
    return userTales.progress == UserTalesStatus.following;
  }
}
