import 'package:cuentos_pasantia/layers/infraestructure/repositories/usertales_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/user/users.dart';

final userTalesRepositoryProvider =
    Provider<UserTalesRepository>((ref) => UserTalesRepository());

final actualLibraryPage = StateProvider<int>((ref) {
  return 1;
});

final libraryStateValuesProvider = Provider(
  (ref) => UserTalesStatus.values,
);

final libraryFilterProvider =
    StateProvider<UserTalesStatus>((ref) => UserTalesStatus.reading);
