import 'package:cuentos_pasantia/layers/application/providers/tales/library/library_data_provider.dart';
import 'package:cuentos_pasantia/layers/domain/entities/user/users.dart';
import 'package:cuentos_pasantia/layers/infraestructure/repositories/usertales_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final contentProvider =
//     FutureProvider.family<String>(
//         (ref, userId) {
//   final repository = ref.watch(userTalesRepositoryProvider);
//   return LibraryNotifier(repository, userId: userId);
// });


final libraryContentProvider =
    StateNotifierProvider.family<LibraryNotifier, UserTalesRepository, String>(
        (ref, userId) {
  final repository = ref.watch(userTalesRepositoryProvider);
  return LibraryNotifier(repository, userId: userId);
});

class LibraryNotifier extends StateNotifier<UserTalesRepository> {
  final String userId;
  final List<UserTales> tales = [];

  LibraryNotifier(super.state, {required this.userId});

  Future<void> loadTales(int page) async {
    tales.clear();
    final newTales = await state.getUserTales(userId, page);
    tales.addAll(newTales);
  }
}
