import 'package:cuentos_pasantia/layers/application/providers/providers.dart';
import 'package:cuentos_pasantia/layers/domain/entities/user/users.dart';
import 'package:cuentos_pasantia/layers/infraestructure/repositories/usertales_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/user/user_tales.dart';

final favoriteUsertalesProvider =
    StateNotifierProvider<FavoriteUsertalesNotifier, UserTalesRepository>(
        (ref) {
  final repository = ref.watch(userTalesRepositoryProvider);
  return FavoriteUsertalesNotifier(repository);
});

class FavoriteUsertalesNotifier extends StateNotifier<UserTalesRepository> {
  FavoriteUsertalesNotifier(super.state);
  List<UserTales> usertales = [];
  List<UserTales> favoriteTales = [];
  List<UserTales> readingTales = [];

  void loadUserTales(String userId) async {
    usertales = await state.getUserTales(userId);
    favoriteTales = usertales
        .where((tale) => tale.progress == UserTalesStatus.following)
        .toList();

        readingTales = usertales
        .where((tale) => tale.progress == UserTalesStatus.reading)
        .toList();
  }
}
