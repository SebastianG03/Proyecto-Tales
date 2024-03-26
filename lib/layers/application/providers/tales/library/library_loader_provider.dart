import 'package:cuentos_pasantia/layers/application/providers/tales/library/library_data_provider.dart';
import 'package:cuentos_pasantia/layers/domain/entities/tales/tales.dart';
import 'package:cuentos_pasantia/layers/domain/entities/user/users.dart';
import 'package:cuentos_pasantia/layers/infraestructure/repositories/user_auth_repository.dart';
import 'package:cuentos_pasantia/layers/infraestructure/repositories/usertales_repository.dart';
import 'package:flutter/foundation.dart';
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
  List<UserTales> tales = <UserTales>[];

  LibraryNotifier(super.state, {required this.userId});

  List<UserTales> actualStatus(UserTalesStatus status) {
    return tales.where((element) => element.progress == status).toList();
  }

  Future<void> loadTales() async {
    // tales.clear();
    final repository = UserAuthRepository();
    final user = await repository.getUserById(userId);
    debugPrint('Id: ${user.id} | user loaded');
    // final newTales = await state.getUserTales(userId);
    tales.addAll(user.getUserModelTales);
  }
}
